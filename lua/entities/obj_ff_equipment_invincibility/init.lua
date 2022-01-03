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
ENT.Duration = 20

ENT.oldActivate = ENT.ActivateEquipment
local owner = nil
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    self.owner:AddFlags(FL_GODMODE)
    owner = self.owner
    timer.Simple(self.Duration, function()
        owner:RemoveFlags(FL_GODMODE)
    end)
end