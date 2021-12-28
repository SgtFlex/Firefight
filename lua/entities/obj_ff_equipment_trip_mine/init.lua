AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/obj_ff_equipment_base/init.lua")

ENT.ModelColor = Color(127, 0, 255, 255)
ENT.Model = "models/hr/unsc/equipment_pack_elite/equipment_pack_elite.mdl"
ENT.KeyType = KeyTypes.PRESS


ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    if (!self.owner:IsOnGround()) then return end
    self.mine = ents.Create("obj_ff_trip_mine")
    self.mine.owner = self.owner
    self.mine:Spawn()
end