AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/cov/equipment_grav_lift/equipment_grav_lift_undeployed.mdl"
ENT.KeyType = KeyTypes.PRESS
ENT.ResourceRegen = 0
ENT.ResourceCostInitial = 1
ENT.ResourceMax = 1
ENT.ResourceCur = ENT.ResourceMax


function ENT:ActivateEquipment()
    self.BaseClass.ActivateEquipment(self)
    self.mine = ents.Create("obj_ff_grav_lift")
    self.mine.Duration = self.DeployableDuration
    self.mine.StartHealth = self.DeployableHealth
    self.mine.owner = self.owner
    self.mine:Spawn()
    self.mine:SetPos(self.owner:GetPos() + self.owner:OBBCenter())
    self.mine:GetPhysicsObject():AddVelocity(self.owner:GetAimVector():GetNormalized()*400)
end