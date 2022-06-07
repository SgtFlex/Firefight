AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/bases/deployable_base/init.lua")
ENT.Model = "models/hr/cov/equipment_power_drain/equipment_power_drain.mdl"
ENT.SoundTbl_Explode = {
    "equipment/regenerator/regenerator_expl/regenerator_expl1.wav",
    "equipment/regenerator/regenerator_expl/regenerator_expl2.wav",
    "equipment/regenerator/regenerator_expl/regenerator_expl3.wav",
}
ENT.SndTbl_Deploy = {
    "equipment/energy_drain/deploy.wav",
}
ENT.Snd_IdleLoop = "equipment/energy_drain/deployed_loop.wav"
ENT.EffectRadius = 200
ENT.EffectDelay = 0.5
ENT.EffectTickRate = 0.1
ENT.EffectPFX = "Powerdrain"
ENT.ExplosionDamage = 10
ENT.ExplosionRadius = ENT.EffectRadius
ENT.Skin = 1

ENT.DrainDamage = 10
local oldConvars = ENT.UseConvars
function ENT:UseConvars()
    oldConvars(self)
    self.DrainDamage = GetConVar("h_energy_drain_dps"):GetFloat()
end

function ENT:EntityEffect(entity)
    if (entity.Armor and entity:Armor() > 0) then
        entity:TakeDamage(math.min(self.DrainDamage, entity:Armor()), self:GetOwner(), self)
    elseif (entity.ShieldCurrentHealth > 0) then
        entity:TakeDamage(math.min(self.DrainDamage, entity.ShieldCurrentHealth), self:GetOwner(), self)
    end
end