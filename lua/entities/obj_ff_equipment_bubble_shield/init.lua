AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("entities/bases/obj_ff_equipment_base/init.lua")

ENT.Model = "models/hr/cov/equipment_bubble_shield/equipment_bubble_shield.mdl"
ENT.KeyType = KeyTypes.PRESS
ENT.ResourceRegen = 0
ENT.ResourceCostInitial = 1
ENT.ResourceMax = 1
ENT.ResourceCur = ENT.ResourceMax


ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    self.shield = ents.Create("obj_ff_bubble_shield")
    self.shield.Duration = self.DeployableDuration
    self.shield.StartHealth = self.DeployableHealth
    self.shield:SetPos(self.owner:GetPos() + self.owner:OBBCenter())
    self.shield.owner = self.owner
    self.shield:Spawn()
    self.shield:GetPhysicsObject():AddVelocity(self.owner:GetAimVector():GetNormalized()*400)
end