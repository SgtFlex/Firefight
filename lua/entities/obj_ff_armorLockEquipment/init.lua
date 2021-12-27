AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include ("entities/obj_ff_baseEquipment/init.lua")
ENT.ModelColor = Color(255, 93, 0, 255)
ENT.toggledOn = false
ENT.KeyType = KeyTypes.HOLD


local loopSound
ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    if (!self.owner:IsOnGround()) then return end
    loopSound = CreateSound(self, "equipment/armor_lock/armorLockLoop.wav")
    loopSound:Play()
    self.owner:AddFlags(FL_FROZEN)
    self.owner:AddFlags(FL_GODMODE)
    self:EmitSound("equipment/armor_lock/armorLock_in.wav")
end

ENT.oldDeactivate = ENT.DeactivateEquipment
function ENT:DeactivateEquipment()
    if self.oldDeactivate(self)==false then return end
    loopSound:Stop()
    self.owner:RemoveFlags(FL_FROZEN)
    self.owner:RemoveFlags(FL_GODMODE)
    self:EmitSound("equipment/armor_lock/armorLock_out.wav")
end