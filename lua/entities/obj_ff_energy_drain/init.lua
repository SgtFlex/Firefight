AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/cov/equipment_power_drain/equipment_power_drain.mdl"
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
ENT.Duration = 7
ENT.DrainRadius = 200
ENT.TickRate = 0.1
ENT.DrainDamage = 10

function ENT:Initialize()
    self:SetMaxHealth(10)
    self:SetHealth(10)
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:EmitSound("equipment/energy_drain/in.wav")
    self:EmitSound("equipment/energy_drain/flash.wav")
    self.loopSound = CreateSound(self, "equipment/energy_drain/track1_loop.wav")
    self.loopSound2 = CreateSound(self, "equipment/energy_drain/track2_loop.wav")
    self.loopSound:Play()
    self.loopSound2:Play()
    self.activateTime = CurTime() + 1
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    ParticleEffectAttach("Powerdrain", 4, self, 0)
    timer.Create("Explode"..self:GetCreationID(), self.Duration, 1, function()
        if (!IsValid(self)) then return end
        self:Explode()
    end)
end

function ENT:Explode()
    local dmginfo = DamageInfo()
    dmginfo:SetDamageType(DMG_BLAST)
    dmginfo:SetDamage(10)
    dmginfo:SetInflictor(self)
    util.BlastDamageInfo(dmginfo, self:GetPos(), self.DrainRadius)
    util.ScreenShake(self:GetPos(), 600, 600, 1.5, 600)
    self:EmitSound(self.SoundTbl_Explode[math.random(1, #self.SoundTbl_Explode)])
    self:Remove()
end


function ENT:OnRemove()
    self.loopSound:Stop()
    self.loopSound2:Stop()
end


function ENT:Think()
    if (CurTime() > self.activateTime) then
        for k, v in pairs(ents.FindInSphere(self:GetPos(), self.DrainRadius)) do
            if (v:IsNPC() or v:IsPlayer()) then
                if (v:Armor() > 0) then
                    v:TakeDamage(math.min(self.DrainDamage, v:Armor()), self:GetOwner(), self)
                end
            end
        end
    end

    self:NextThink(CurTime()+self.TickRate)
    return true
end

function ENT:OnTakeDamage(dmginfo)
    if dmginfo:GetInflictor()==self then return end
    self:SetHealth(self:Health() - dmginfo:GetDamage())
    if self:Health() <= 0 then
        self:Explode()
    end
end

function ENT:PhysicsCollide(colData, collider)
    if (colData.Speed > 50) then
        self:EmitSound(SndTbl_Collide[math.random(1, #SndTbl_Collide)])
    end
end