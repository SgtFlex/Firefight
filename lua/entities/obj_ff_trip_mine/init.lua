AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/unsc/equipment_trip_mine/equipment_trip_mine.mdl"
ENT.SoundTbl_Explode = {
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion1.wav",
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion2.wav",
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion3.wav",
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion5.wav",
}
local SndTbl_Collide = {
    "equipment/shared/drop/equipment_drop (1).wav",
    "equipment/shared/drop/equipment_drop (2).wav",
    "equipment/shared/drop/equipment_drop (3).wav",
    "equipment/shared/drop/equipment_drop (4).wav",
}
ENT.Duration = 10


function ENT:Initialize()
    self:SetMaxHealth(10)
    self:SetHealth(10)
    self:SetModel(self.Model)
    self:SetBodygroup(1, 1)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:EmitSound("equipment/trip_mine/tripmine_armed.wav")
    timer.Simple(0.85, function()
        if (!IsValid(self)) then return end
        self.loopSound = CreateSound(self, "equipment/trip_mine/loop.wav")
        self.loopSound:Play()
        
    end)
    self.activateTime = CurTime() + 3
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    
    timer.Create("Explode"..self:GetCreationID(), self.Duration, 1, function()
        if (!IsValid(self)) then return end
        self:Expire()
    end)
    
end

function ENT:Explode()
    local dmginfo = DamageInfo()
    dmginfo:SetDamageType(DMG_BLAST)
    dmginfo:SetDamage(100)
    dmginfo:SetInflictor(self)
    util.BlastDamageInfo(dmginfo, self:GetPos(), 600)
    util.ScreenShake(self:GetPos(), 600, 600, 1.5, 600)
    self:EmitSound(self.SoundTbl_Explode[math.random(1, #self.SoundTbl_Explode)])
    self:Remove()
end


function ENT:OnRemove()
    self.loopSound:Stop()
end

function ENT:Think()
    if (CurTime() > self.activateTime) then
        for k, v in pairs(ents.FindInSphere(self:GetPos(), 150)) do
            if v:IsNPC() or v:IsPlayer() then
                self:Explode()
            end
        end
    end

    self:NextThink(CurTime()+1)
    return true
end

function ENT:OnTakeDamage(dmginfo)
    if dmginfo:GetInflictor()==self then return end
    self:SetHealth(self:Health() - dmginfo:GetDamage())
    if self:Health() <= 0 then
        self:Explode()
    end
end

function ENT:Expire()
    self:EmitSound("equipment/trip_mine/expire.wav")
    timer.Simple(5, function()
        if (!IsValid(self)) then return end
        self:Explode()
    end)
end

function ENT:PhysicsCollide(colData, collider)
    if (colData.Speed > 50) then
        self:EmitSound(SndTbl_Collide[math.random(1, #SndTbl_Collide)])
    end
end