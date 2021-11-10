AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include ("entities/obj_ff_baseEquipment/init.lua")
ENT.ModelColor = Color(255, 93, 0, 255)
ENT.toggledOn = false
local loopSound
function ENT:PressedQ()
    self:ActivateArmorLock()
end

function ENT:ReleasedQ()
    self:DeactivateArmorLock()
end

local loopSound
function ENT:ActivateArmorLock()
    if (!self.owner:IsOnGround()) then return end
    loopSound = CreateSound(self, "equipment/armor_lock/armorLockLoop.wav")
    loopSound:Play()
    self.owner:AddFlags(FL_FROZEN)
    self.owner:AddFlags(FL_GODMODE)
    self:EmitSound("equipment/armor_lock/armorLock_in.wav")
end

function ENT:DeactivateArmorLock()
    loopSound:Stop()
    self.owner:RemoveFlags(FL_FROZEN)
    self.owner:RemoveFlags(FL_GODMODE)
    self:EmitSound("equipment/armor_lock/armorLock_out.wav")
end