AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/bases/deployable_base/init.lua")

ENT.Model = "models/hr/cov/equipment_power_drain/equipment_power_drain.mdl"
ENT.SoundTbl_Explode = {
    "equipment/flare/superflare_expl.wav",
}
ENT.SndTbl_Deploy = {
    "equipment/flare/superflare_arm.wav",
}
ENT.Snd_IdleLoop = "equipment/flare/loop.wav"
ENT.EffectDelay = 0.5
ENT.EffectRadius = 200
ENT.EffectTickRate = 0.1
ENT.Skin = 3
ENT.EffectPFX = "Flare"

function ENT:EntityEffect(entity)
end
