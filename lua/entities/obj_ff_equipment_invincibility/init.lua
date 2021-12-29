AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("entities/bases/obj_ff_equipment_base/init.lua")

ENT.toggledOn = false
ENT.bubble = nil
ENT.KeyType = KeyTypes.PRESS


ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    if (!self.owner:IsOnGround()) then return end
    self:EmitSound("equipment/bubble_shield/deploy_shield.wav")
    self.bubble = ents.Create("base_gmodentity")
    self.bubble.loopSound = CreateSound(self.bubble, "equipment/bubble_shield/deploy_shield_loop.wav")
    timer.Simple(0.5, function()
        self:EmitSound("equipment/bubble_shield/deploy_shield_in.wav")
        self.bubble.loopSound:Play()
        self.bubble.Initialize = function(self)
            self:SetModelScale(0)
            self:SetModelScale(1, 0.65)
            self:PhysicsInit(SOLID_VPHYSICS)
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
        self.bubble.OnTakeDamage = function(self, dmginfo)
            self:SetHealth(self:Health() - dmginfo:GetDamage())
            if (self:Health() <= 0) then
                self.loopSound:Stop()
                self:EmitSound("equipment/bubble_shield/bubble_deativate.wav")
                self:Remove()
            end
        end
        self.bubble:SetModel("models/hr/unsc/bubble_shield/bubble_shield.mdl")
        self.bubble:SetPos(self.owner:GetPos())
        self.bubble:Spawn()
        self.bubble:SetHealth(300)
        self.bubble:SetMaxHealth(300)
        self.bubble:Activate()
        self.bubble:SetMoveType(MOVETYPE_NONE)
        
    end)
    self.ResourceCur = self.ResourceCur - self.ResourceCostInitial
    timer.Create("Regen"..self:GetCreationID(), 0.1, (self.ResourceMax - self.ResourceCur)/0.1, function()
        self.ResourceCur = self.ResourceCur + 0.1
    end)
end