AddCSLuaFile("shared.lua")
include("shared.lua")


ENT.Model = "models/hr/cov/equipment_grav_lift/equipment_grav_lift.mdl"
ENT.SoundTbl_Explode = {
    "equipment/portable_gravity_lift/gravlift_death.wav",
}
ENT.SndTbl_Deploy = {
    "equipment/portable_gravity_lift/deploy.wav",
}
ENT.Snd_IdleLoop = "equipment/portable_gravity_lift/loop.wav"
ENT.EffectRadius = 300
ENT.EffectDelay = 0.5
ENT.EffectTickRate = 0.1
ENT.EffectPFX = "Gravity_Lift"
ENT.ExplosionDamage = 0
ENT.DeployAnimation = "deploy"
ENT.LoopAnimation = "idle_deployed"

ENT.LastLiftSound = 0
ENT.LastActivateTime = 0

function ENT:UseConvars()
    self.BaseClass.UseConvars(self)
    self.LiftPower = GetConVar("h_grav_lift_power"):GetFloat()
end

function ENT:Think()
    if (CurTime() > self.ActivateTime and CurTime() > self.LastActivateTime + self.EffectTickRate) then
        self.LastActivateTime = CurTime()
        local tr = util.TraceHull({
            start = self:GetPos(),
            endpos = self:GetPos() + self:GetUp()*100,
            filter = self,
            mins = Vector(-25,-25, 0),
            maxs = Vector(25,25, 0),
            ignoreworld = true,
        })
        if (tr.Hit and CurTime() > self.LastLiftSound + 0.5) then
            self.LastLiftSound = CurTime()
            self:EmitSound("equipment/portable_gravity_lift/lift.wav")
        end
        self:EntityEffect(tr.Entity)
    end
    self:NextThink(CurTime())
    return true
end

function ENT:EntityEffect(entity)
    if (entity:IsPlayer()) then
        if (entity:IsOnGround()) then
            entity:SetPos(entity:GetPos() + Vector(0,0,6))
        end
        entity:SetVelocity(self:GetUp()*self.LiftPower)
    elseif (entity:IsNPC()) then
        entity:SetVelocity(self:GetUp()*self.LiftPower)
    elseif (IsValid(entity) and IsValid(entity:GetPhysicsObject())) then
        entity:GetPhysicsObject():AddVelocity(self:GetUp()*self.LiftPower)
    end
end