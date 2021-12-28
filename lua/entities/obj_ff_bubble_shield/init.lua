AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


ENT.bubble = nil
function ENT:Initialize()
    self:SetModel("models/props_interiors/pot01a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():Wake()
    self:SpawnShield()
    self:SetHealth(50)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:GetPhysicsObject():AddVelocity(self.owner:GetAimVector():GetNormalized()*400)
end

function ENT:OnTakeDamage(damage)
    self:SetHealth(self:Health() - dmginfo:GetDamage())
    if (self:Health() <= 0) then
        self.loopSound:Stop()
        self:EmitSound("equipment/bubble_shield/bubble_deativate.wav")
        self:Remove()
    end
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
        self:SetHealth(10)
        self:SetColor(Color(255, 0, 0))
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
        
        timer.Simple(10, function()
            if (!IsValid(self)) then return end
            self.loopSound:Stop()
            self:EmitSound("equipment/bubble_shield/bubble_deativate.wav")
            self:Remove()
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