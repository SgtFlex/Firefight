ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Category = "Halo Equipment"
ENT.Author = "Sgt Flexxx"
ENT.Contact = "https://steamcommunity.com/id/sgtflexxx/"
ENT.Purpose = "To debug the equipment system"
ENT.Instructions = ""
ENT.Spawnable = true
ENT.PrintName = "Base Equipment"

if SERVER then
    function ENT:UseConvars()
        self.ResourceMax = GetConVar("h_"..self.ConVarName.."_resource_max"):GetFloat()
        self.ResourceCur = self.ResourceMax
        self.ResourceRegen = GetConVar("h_"..self.ConVarName.."_resource_regen"):GetFloat()
        self.ResourceCostPerSec = GetConVar("h_"..self.ConVarName.."_resource_cps"):GetFloat()
        self.ResourceCostInitial = GetConVar("h_"..self.ConVarName.."_resource_cost_initial"):GetFloat()
        self.ResourceRegenDelay = GetConVar("h_"..self.ConVarName.."_resource_delay"):GetFloat()
        self.ResourceTickRate = 0.1

        self.DeployableDuration = GetConVar("h_"..self.ConVarName.."_duration"):GetFloat()
        self.DeployableHealth = GetConVar("h_"..self.ConVarName.."_health"):GetFloat()
        
    end

    function ENT:AttachToPlayer(player)
        self.owner = player
        self:SetOwner(player)
        if (self.owner.HaloEquipment!=nil and self.owner.HaloEquipment.Drop!=nil) then self.owner.HaloEquipment:Drop() end
        if (self.Snd_EquipmentLoop) then self.Snd_EquipmentLoop:Stop() end
        self:EmitSound("equipment/shared/equipment_pickup.wav")
        self.owner.HaloEquipment = self
        self:SetParent(self.owner)
        self:SetSolid(SOLID_NONE)
        self:SetNoDraw(true)
        hook.Add("PlayerButtonDown", "EquipmentKeyPressed", function(player, button)
            if (player==self.owner) and (button == GetConVar("he_equipment_bind"):GetInt()) and IsValid(self) then
                if (self.KeyType==KeyTypes.TOGGLE and self.EquipmentActive==true) then --If the keyType is toggle and it's active, deactivate the effect
                    self:DeactivateEquipment()
                else
                    self:ActivateEquipment()
                end
            end
        end)
        hook.Add("PlayerButtonUp", "EquipmentKeyReleased", function(player, button)
            if (player==self.owner) and (button == KEY_T) and IsValid(self) then
                if (self.KeyType==KeyTypes.HOLD) then --Make sure to deactivate only if our keytype is HOLD
                    self:DeactivateEquipment()
                end
            end
        end)
        hook.Add("PlayerDeath", "Drop", function(victim, infl, att)
            if (victim==self.owner) then
                self:Drop()
            end
        end)
    end
end

function ENT:ActivateEquipment()
    if (self.ResourceCur < self.ResourceCostInitial) then return false end
    self.EquipmentActive = true
    self.ResourceCur = self.ResourceCur - self.ResourceCostInitial
    if self.ResourceCur < self.ResourceCostInitial and self.ResourceRegen <= 0 then self:Remove() end
    timer.Destroy("EquipmentRegen"..self:GetCreationID()) --Stop the regen if it's active

    if (self.KeyType != KeyTypes.PRESS) then
        timer.Create("EquipmentDegen"..self:GetCreationID(), self.ResourceTickRate, 0, function() --Deduct the resource pool by the cost per tick
            if !IsValid(self) then return end
            self.ResourceCur = math.max(0, self.ResourceCur - (self.ResourceCostPerSec * self.ResourceTickRate))
            if (self.ResourceCur <= 0) then
                self:DeactivateEquipment()
                timer.Destroy("EquipmentDegen"..self:GetCreationID())
            end
        end)
    end
end

function ENT:DeactivateEquipment()
    if (self.EquipmentActive==false) then return false end
    self.EquipmentActive = false
    timer.Destroy("EquipmentDegen"..self:GetCreationID()) --Stop the degen if it's active
    timer.Create("EquipmentRegenDelay"..self:GetCreationID(), self.ResourceRegenDelay, 1, function()
        if !IsValid(self) then return end
        timer.Create("EquipmentRegen"..self:GetCreationID(), self.ResourceTickRate, 0, function()
            if !IsValid(self) then return end
            self.ResourceCur = math.min(self.ResourceMax, self.ResourceCur + (self.ResourceRegen * self.ResourceTickRate))
            if (self.ResourceCur >= self.ResourceMax) then
                timer.Destroy("EquipmentRegen"..self:GetCreationID())
            end
        end)
    end)
end




