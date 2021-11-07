AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include ("entities/obj_ff_baseEquipment/init.lua")

ENT.toggledOn = false
function ENT:PressedQ()
    self.toggledOn = !self.toggledOn
    if (self.toggledOn) then
        self.owner:AddFlags(FL_NOTARGET)
    else
        self.owner:RemoveFlags(FL_NOTARGET)
    end
end