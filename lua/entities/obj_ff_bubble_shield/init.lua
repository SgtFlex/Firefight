AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local SndTbl_Collide = {
    "equipment/shared/drop/equipment_drop (1).wav",
    "equipment/shared/drop/equipment_drop (2).wav",
    "equipment/shared/drop/equipment_drop (3).wav",
    "equipment/shared/drop/equipment_drop (4).wav",
}


ENT.bubble = nil
ENT.Duration = 10
function ENT:Initialize()
    self:SetModel("models/hr/cov/equipment_bubble_shield/equipment_bubble_shield.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():Wake()
    self:SpawnShield()
    self:SetMaxHealth(25)
    self:SetHealth(self:GetMaxHealth())
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    timer.Create("BubbleShield"..self:GetCreationID(), self.Duration, 1, function()
        if (!IsValid(self)) then return end
        self:Remove()
    end)
end

function ENT:OnTakeDamage(dmginfo)
    self:SetHealth(self:Health() - dmginfo:GetDamage())
    if (self:Health() <= 0) then
        self:Remove()
    end
end

function ENT:OnRemove()
    self.bubble.loopSound:Stop()
    self:EmitSound("equipment/bubble_shield/bubble_deativate.wav")
    self.bubble:Remove()
end

function ENT:SpawnShield()
    self.bubble = ents.Create("base_gmodentity")
    self.bubble.loopSound = CreateSound(self.bubble, "equipment/bubble_shield/deploy_shield_loop.wav")
    self:EmitSound("equipment/bubble_shield/deploy_shield_in.wav")
    self.bubble.loopSound:Play()
    self.bubble.Initialize = function(self)
        self:SetModelScale(0)
        self:SetModelScale(1, 0.65)
        self:PhysicsInit(SOLID_NONE)
        self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
        self:SetCustomCollisionCheck(true)
        self:SetMaterial("effects/bubble_shield")
        self:DrawShadow(false)
        self:AddEFlags(EFL_DONTBLOCKLOS)
        self:CollisionRulesChanged()
        hook.Add("ShouldCollide", "Bubble", function(ent1, ent2)
            if ((ent1:IsNPC()) and (ent2==self)) or (ent1==self and ent2:IsNPC()) then
                print("Allow passage")
                return false
            end
        end)
    end
    self.bubble:SetModel("models/hr/unsc/bubble_shield/bubble_shield.mdl")
    self.bubble:SetPos(self:GetPos())
    self.bubble:Spawn()
    self.bubble:Activate()
    self.bubble:SetMoveType(MOVETYPE_NONE)
    constraint.NoCollide(self, self.bubble, 0, 0)
    constraint.NoCollide(self.bubble, self, 0, 0)
    constraint.Weld(self, self.bubble, 0, 0, 0, true, true)
end

function ENT:PhysicsCollide(colData, collider)
    if (colData.Speed > 50) then
        self:EmitSound(SndTbl_Collide[math.random(1, #SndTbl_Collide)])
    end
end

function ENT:Think()
    self.oldVel = self:GetPhysicsObject():GetVelocity()
    self:NextThink(CurTime())
    self:GetPhysicsObject():SetAngles(Angle(0,self:GetAngles().y,0))
    self:GetPhysicsObject():SetVelocity(self.oldVel)
    return true
end