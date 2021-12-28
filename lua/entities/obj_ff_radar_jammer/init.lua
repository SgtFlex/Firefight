AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hunter/misc/sphere025x025.mdl"
ENT.SoundTbl_Explode = {
    "equipment/flare/superflare_expl.wav",
}
local SndTbl_Collide = {
    "equipment/shared/drop/equipment_drop (1).wav",
    "equipment/shared/drop/equipment_drop (2).wav",
    "equipment/shared/drop/equipment_drop (3).wav",
    "equipment/shared/drop/equipment_drop (4).wav",
}
ENT.Duration = 20
ENT.EffectRadius = 200
ENT.TickRate = 0.1

function ENT:Initialize()
    self:SetMaxHealth(10)
    self:SetHealth(10)
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:EmitSound("equipment/radar_jammer/jammer_windup.wav")
    self.loopSound = CreateSound(self, "equipment/radar_jammer/loop.wav")
    self.loopSound:Play()
    self.activateTime = CurTime() + 1
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    
    timer.Create("Explode"..self:GetCreationID(), self.Duration, 1, function()
        if (!IsValid(self)) then return end
        self:Explode()
    end)
end

function ENT:Explode()
    util.ScreenShake(self:GetPos(), 600, 600, 1.5, 600)
    self:EmitSound(self.SoundTbl_Explode[math.random(1, #self.SoundTbl_Explode)])
    self:Remove()
end


function ENT:OnRemove()
    self.loopSound:Stop()
end


function ENT:Think()
    if (CurTime() > self.activateTime) then
        for k, v in pairs(ents.FindInSphere(self:GetPos(), self.EffectRadius)) do
            if (v:IsPlayer()) then
                
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