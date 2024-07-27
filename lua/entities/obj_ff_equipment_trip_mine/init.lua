AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/unsc/equipment_trip_mine/equipment_trip_mine.mdl"
ENT.KeyType = KeyTypes.PRESS
ENT.ResourceRegen = 0
ENT.ResourceCostInitial = 1
ENT.ResourceMax = 1
ENT.ResourceCur = ENT.ResourceMax


ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    self.BaseClass.ActivateEquipment(self)
    self.mine = ents.Create("obj_ff_trip_mine")
    self.mine.Duration = self.DeployableDuration
    self.mine.StartHealth = self.DeployableHealth
    self.mine.owner = self.owner
    self.mine:Spawn()
    self.mine:SetPos(self.owner:GetPos() + self.owner:OBBCenter())
    self.mine:GetPhysicsObject():AddVelocity(self.owner:GetAimVector():GetNormalized()*400)
end