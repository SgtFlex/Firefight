AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/cov/equipment_bubble_shield/equipment_bubble_shield.mdl"
ENT.SndTbl_Deploy = {
    "equipment/bubble_shield/deploy_shield_in.wav",
}
ENT.Snd_IdleLoop = "equipment/bubble_shield/deploy_shield_loop.wav"
ENT.EffectDelay = 0.85
ENT.StartHealth = 25
ENT.EffectPFX = "BubbleShield"
ENT.LoopAnimation = "spin"


ENT.bubble = nil
local oldInit = ENT.Initialize
function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self:SpawnShield()
end

local oldRemove = ENT.OnRemove
function ENT:OnRemove()
    self.BaseClass.OnRemove(self)
    self:EmitSound("equipment/bubble_shield/bubble_deativate.wav")
    ParticleEffect("Bubble_destroy", self.bubble:GetPos(), Angle(0,0,0))
    self.bubble:Remove()    
end

function ENT:SpawnShield()
    self.bubble = ents.Create("base_entity")
    self.bubble.Initialize = function(self)
        self:SetModel("models/hr/unsc/bubble_shield/bubble_shield.mdl")
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetModelScale(0)
        self:SetModelScale(1, 0.85)
        self:SetSkin(2)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
        self:SetCustomCollisionCheck(true)
        self:DrawShadow(false)
        self:AddEFlags(EFL_DONTBLOCKLOS)
        self:CollisionRulesChanged()
        hook.Add("ShouldCollide", "Bubble", function(ent1, ent2)
            if ((ent1:IsNPC()) and (ent2==self)) or (ent1==self and ent2:IsNPC()) then
                return false
            end
        end)
    end
    self.bubble:SetPos(self:GetPos())
    self.bubble:Spawn()
    self.bubble:Activate()
end

function ENT:Think()
    self.bubble:SetPos(self:GetPos())
    self.oldVel = self:GetPhysicsObject():GetVelocity()
    self:NextThink(CurTime())
    self:GetPhysicsObject():SetAngles(Angle(0,self:GetAngles().y,0))
    self:GetPhysicsObject():SetVelocity(self.oldVel)
    return true
end