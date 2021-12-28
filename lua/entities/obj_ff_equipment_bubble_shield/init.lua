AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("entities/obj_ff_equipment_base/init.lua")

ENT.ModelColor = Color(127, 0, 255, 255)
ENT.Model = "models/hr/unsc/equipment_pack_elite/equipment_pack_elite.mdl"
ENT.KeyType = KeyTypes.PRESS
ENT.ResourceRegen = 0
ENT.ResourceCostInitial = 1
ENT.ResourceMax = 1
ENT.ResourceCur = ENT.ResourceMax


ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    self.shield = ents.Create("obj_ff_bubble_shield")
    self.shield:SetPos(self.owner:GetPos() + self.owner:OBBCenter())
    self.shield.owner = self.owner
    self.shield:Spawn()
    self.shield:GetPhysicsObject():AddVelocity(self.owner:GetAimVector():GetNormalized()*400)
end