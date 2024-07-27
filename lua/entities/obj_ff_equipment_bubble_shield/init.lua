AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/cov/equipment_bubble_shield/equipment_bubble_shield.mdl"
ENT.KeyType = KeyTypes.PRESS
ENT.ResourceRegen = 0
ENT.ResourceCostInitial = 1
ENT.ResourceMax = 1
ENT.ResourceCur = ENT.ResourceMax


function ENT:ActivateEquipment()
    self.BaseClass.ActivateEquipment(self)
    self.shield = ents.Create("obj_ff_bubble_shield")
    self.shield.Duration = self.DeployableDuration
    self.shield.StartHealth = self.DeployableHealth
    self.shield:SetPos(self.owner:GetPos() + self.owner:OBBCenter())
    self.shield.owner = self.owner
    self.shield:Spawn()
    self.shield:GetPhysicsObject():AddVelocity(self.owner:GetAimVector():GetNormalized()*400)
end