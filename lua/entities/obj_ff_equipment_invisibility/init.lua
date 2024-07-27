AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/cov/equipment_bubble_shield/equipment_bubble_shield.mdl"
ENT.KeyType = KeyTypes.PRESS
ENT.ResourceRegen = 0.01
ENT.ResourceCostInitial = 1
ENT.ResourceMax = 1
ENT.ResourceCur = ENT.ResourceMax
ENT.Duration = 20

ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    self.BaseClass.ActivateEquipment(self)
    net.Start("Cloak")
    net.WriteBool(self.EquipmentActive)
    net.Send(self.owner)
    self.owner:RemoveAllDecals()
    self.owner:DrawShadow(false)
    self.owner.Mat = self.owner:GetMaterial()
    self.owner:SetMaterial("effects/spv3/cloak")
    loopSound = CreateSound(self, "equipment/cloak/loop.wav")
    loopSound:Play()
    loopSound:ChangeVolume(0)
    loopSound:ChangeVolume(1, 2)
    self.owner:AddFlags(FL_NOTARGET)
    timer.Simple(self.Duration, function()
        self:DeactivateEquipment()
        self:Remove()
    end)
end

ENT.oldDeactivate = ENT.DeactivateEquipment
function ENT:DeactivateEquipment()
    if self.oldDeactivate(self)==false then return end
    net.Start("Cloak")
    net.WriteBool(self.EquipmentActive)
    net.Send(self.owner)
    self.owner:SetMaterial(self.owner.Mat)
    self.owner:DrawShadow(true)
    loopSound:ChangeVolume(0, 2)
    timer.Simple(2, function() 
        loopSound:Stop() 
    end)
    self.owner:RemoveFlags(FL_NOTARGET)
    self:EmitSound("equipment/cloak/invisibility_deactivate.wav")
end