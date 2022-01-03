AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/bases/deployable_base/init.lua")

ENT.Model = "models/hunter/plates/plate.mdl"
ENT.SoundTbl_Explode = {
    "equipment/flare/superflare_expl.wav",
}
ENT.SndTbl_Deploy = {
    "equipment/flare/superflare_arm.wav",
}
ENT.Snd_IdleLoop = nil
ENT.EffectDelay = 0.5
ENT.EffectRadius = 200
ENT.EffectTickRate = 0.1
util.AddNetworkString("GrappleHit")
local oldInit = ENT.Initialize
function ENT:Initialize()
    oldInit(self)
    self:SetOwner(self.owner)
    self:GetPhysicsObject():EnableGravity(false)
    self:GetPhysicsObject():EnableDrag(false)   
end

ENT.Collided = false
function ENT:PhysicsCollide(colData, collider)
    if (colData.HitEntity and !colData.HitEntity:IsWorld()) then self:SetParent(colData.HitEntity) end
    self:SetMoveType(MOVETYPE_NONE)
    
    self.Collided = true
    self.Spawner:EmitSound("equipment/grapple_shot/impact.wav")
    if (self.Spawner.LoopSound) then self.Spawner.LoopSound:Play() end
    self.Spawner.ResourceCur = self.Spawner.ResourceCur - 1
    net.Start("GrappleHit")
    net.WriteEntity(self.owner)
    net.Broadcast()
end

ENT.Force = 5
ENT.ForcePerTick = 0.1
ENT.MaxForce = 15
ENT.MaxRange = 1000
ENT.Failed = false
ENT.LastLineCheck = 0
ENT.BreakLine = false
function ENT:Think()
    self.Force = math.min(self.Force + self.ForcePerTick, self.MaxForce)
    local dist = self:GetPos():Distance(self.owner:GetPos())
    if (self.Failed) then
        self:GetPhysicsObject():SetVelocity((self:GetOwner():GetPos() + self:GetOwner():OBBCenter() - self:GetPos()):GetNormalized()*4000)
    end
    if (dist > self.MaxRange and self.Collided == false) then
        self.Failed = true
    elseif (self.Collided) then
        if CurTime() > self.LastLineCheck + 0.25 then --Only check expensive math every bit
            self.LastLineCheck = CurTime()
            local tr = util.TraceLine({
                start = self:GetPos(),
                endpos = self:GetOwner():EyePos(),
                filter = {self, self:GetOwner(), self.Spawner},
                ignoreworld = false,
            })
            local aimVector = self:GetOwner():GetAimVector()
            local entVector = (self:GetPos() - self:GetOwner():GetPos()):GetNormalized()
            
            if (tr.Hit or aimVector:Dot(entVector) < 0.4) then
                self.BreakLine = true
                print("Set line broken to true")
                print(tr.Entity)
                print(aimVector:Dot(entVector))
            end
        end
        if (self.owner:IsOnGround()) then
            self.owner:SetPos(self.owner:GetPos() + Vector(0,0,0.5))
        end
        self.owner:SetVelocity((self.owner:GetAimVector()*self.Force) + ((self:GetPos() - self.owner:GetPos()):GetNormalized()*self.Force) + Vector(0,0,10))
    end
    if ((dist < 100 or self.BreakLine or self:GetOwner():Crouching()) and (self.Collided or self.Failed)) then
        if (self.Spawner.LoopSound) then self.Spawner.LoopSound:Stop() end
        print(self.BreakLine)
        self.Spawner:EmitSound("equipment/grapple_shot/cut/cut4.wav")
        self:Remove()
    end
    self:NextThink(CurTime())
    return true
end