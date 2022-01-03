AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/bases/deployable_base/init.lua")

ENT.Model = "models/hr/cov/equipment_regenerator/equipment_regenerator.mdl"
ENT.SoundTbl_Explode = {
    "equipment/regenerator/regenerator_expl/regenerator_expl1.wav",
    "equipment/regenerator/regenerator_expl/regenerator_expl2.wav",
    "equipment/regenerator/regenerator_expl/regenerator_expl3.wav",
}
ENT.SndTbl_Deploy = {
    "equipment/regenerator/deploy.wav",
}
ENT.Snd_IdleLoop = "equipment/regenerator/loop.wav"
ENT.EffectRadius = 200
ENT.EffectDelay = 0.5
ENT.EffectTickRate = 0.1
ENT.EffectPFX = "Regenerator"
ENT.ExplosionDamage = 0
ENT.LoopAnimation = "spin"


ENT.HealthPerTick = 3
ENT.ArmorPerTick = 3

ENT.LastRun = 0
function ENT:Think()
    if (CurTime() >= self.LastRun + self.EffectTickRate) then
        self.LastRun = CurTime()
        if (CurTime() > self.activateTime) then
            for k, v in pairs(ents.FindInSphere(self:GetPos(), self.EffectRadius)) do
                self:EntityEffect(v)
            end
        end
    end
    self.oldVel = self:GetPhysicsObject():GetVelocity()
    self:NextThink(CurTime())
    self:GetPhysicsObject():SetAngles(Angle(0,self:GetAngles().y,0))
    self:GetPhysicsObject():SetVelocity(self.oldVel)
    return true
end

function ENT:EntityEffect(entity)
    if (entity:IsNPC() or entity:IsPlayer()) then
        if (entity:Health() < entity:GetMaxHealth()) then
            entity:SetHealth(math.min(entity:Health() + self.HealthPerTick, entity:GetMaxHealth()))
        end
    end
    if (entity:IsPlayer() and entity:Health() >= entity:GetMaxHealth() and entity:Armor() < entity:GetMaxArmor()) then
        entity:SetArmor(math.min(entity:Armor() + self.ArmorPerTick, entity:GetMaxArmor()))
    end
end