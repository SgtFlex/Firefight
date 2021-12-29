AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/bases/obj_ff_equipment_base/init.lua")

ENT.Model = "models/hr/cov/equipment_power_drain/equipment_power_drain.mdl"
ENT.Skin = 2
ENT.KeyType = KeyTypes.PRESS
ENT.ResourceRegen = 0
ENT.ResourceCostInitial = 1
ENT.ResourceMax = 1
ENT.ResourceCur = ENT.ResourceMax


ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    self.mine = ents.Create("obj_ff_radar_jammer")
    self.mine.owner = self.owner
    self.mine:Spawn()
    self.mine:SetPos(self.owner:GetPos() + self.owner:OBBCenter())
    self.mine:GetPhysicsObject():AddVelocity(self.owner:GetAimVector():GetNormalized()*400)
end