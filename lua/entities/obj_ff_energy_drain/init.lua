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
    "equipment/energy_drain/in.wav",
}
ENT.Snd_IdleLoop = "equipment/energy_drain/track1_loop.wav"
ENT.EffectRadius = 200
ENT.EffectDelay = 0.5
ENT.EffectTickRate = 0.1
ENT.EffectPFX = "Powerdrain"
ENT.ExplosionDamage = 10
ENT.ExplosionRadius = ENT.EffectRadius
ENT.Skin = 1

ENT.DrainDamage = 10
function ENT:EntityEffect(entity)
    if (entity:Armor() > 0) then
        entity:TakeDamage(math.min(self.DrainDamage, entity:Armor()), self:GetOwner(), self)
    end
end