AddCSLuaFile("shared.lua")
include("shared.lua")


ENT.ModelColor = Color(255, 93, 0, 255)
ENT.Sound_Idle = "equipment/shared/equipment_loop.wav"
ENT.toggledOn = false
ENT.KeyType = KeyTypes.HOLD


local loopSound = nil
function ENT:ActivateEquipment()
    self.BaseClass.ActivateEquipment(self)
    
end

ENT.oldDeactivate = ENT.DeactivateEquipment
function ENT:DeactivateEquipment()
    self.BaseClass.DeactivateEquipment(self)
    loopSound:Stop()
    self.owner:RemoveFlags(FL_FROZEN)
    self.owner:RemoveFlags(FL_GODMODE)
    self:EmitSound("equipment/armor_lock/armorLock_out.wav")
end