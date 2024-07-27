AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.ModelColor = Color(0, 161, 255, 255)
ENT.toggledOn = false
ENT.bubble = nil
ENT.KeyType = KeyTypes.PRESS
ENT.Sound_Idle = "equipment/shared/equipment_loop.wav"

ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    self.BaseClass.ActivateEquipment(self)
    if (!self.owner:IsOnGround()) then return end
    self:EmitSound("equipment/bubble_shield/deploy_shield.wav")
    self.bubble = ents.Create("base_entity")
    self.bubble:SetOwner(self)
    self.bubble.loopSound = CreateSound(self.bubble, "equipment/bubble_shield/deploy_shield_loop.wav")
    timer.Simple(0.5, function()
        self:EmitSound("equipment/bubble_shield/deploy_shield_in.wav")
        self.bubble.loopSound:Play()
        self.bubble.Initialize = function(self)
            self:SetModel("models/hr/unsc/bubble_shield/bubble_shield.mdl")
            self:SetMaxHealth(self:GetOwner().DeployableHealth)
            self:SetHealth(self:GetMaxHealth())
            -- self:SetModelScale(0) --Causes weird bugs
            self:SetModelScale(1, 0.65)
            self:SetMoveType(MOVETYPE_VPHYSICS)
            self:PhysicsInit(SOLID_VPHYSICS)
            self:SetSkin(1)
            self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
            self:SetCustomCollisionCheck(true)
            self:DrawShadow(false)
            self:AddEFlags(EFL_DONTBLOCKLOS)
            self:CollisionRulesChanged()
            hook.Add("ShouldCollide", "BubbleCollisionCheck", function(ent1, ent2)
                if (ent1:IsNPC() and ent2==self) or (ent1==self and ent2:IsNPC()) then
                    PrintMessage(3, "No colliding "..tostring(ent1).." and "..tostring(ent2))
                    return false
                end
            end)
            
            timer.Simple(self:GetOwner().DeployableDuration, function()
                if (!IsValid(self)) then return end
                self:Remove()
            end)
        end
        self.bubble.OnRemove = function(self)
            self.loopSound:Stop()
            self:EmitSound("equipment/bubble_shield/bubble_deativate.wav")
        end
        self.bubble.OnTakeDamage = function(self, dmginfo)
            self:SetHealth(self:Health() - dmginfo:GetDamage())
            if (self:Health() <= 0) then
                self.loopSound:Stop()
                self:EmitSound("equipment/bubble_shield/bubble_deativate.wav")
                self:Remove()
            end
        end
        self.bubble:SetPos(self.owner:GetPos())
        self.bubble:Spawn()
        self.bubble:Activate()
        self.bubble:SetMoveType(MOVETYPE_NONE)
    end)
    self.ResourceCur = self.ResourceCur - self.ResourceCostInitial
    timer.Create("Regen"..self:GetCreationID(), 0.1, (self.ResourceMax - self.ResourceCur)/0.1, function()
        self.ResourceCur = self.ResourceCur + 0.1
    end)
end