AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/bases/deployable_base/init.lua")

ENT.Model = "models/hr/unsc/equipment_trip_mine/equipment_trip_mine.mdl"
ENT.SoundTbl_Explode = {
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion1.wav",
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion2.wav",
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion3.wav",
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion5.wav",
}
ENT.SndTbl_Deploy = {
    "equipment/trip_mine/tripmine_armed.wav",
}
ENT.Snd_IdleLoop = "equipment/trip_mine/loop.wav"
ENT.EffectRadius = 200
ENT.EffectDelay = 1
ENT.EffectTickRate = 1
ENT.ExplosionDamage = 100
ENT.ExplosionRadius = 500
ENT.Bodygroups = "01"

function ENT:EntityEffect(entity)
    self:Explode()
end

function ENT:Expire()
    self:EmitSound("equipment/trip_mine/expire.wav")
    timer.Simple(5, function()
        if (!IsValid(self)) then return end
        self:Explode()
    end)
end