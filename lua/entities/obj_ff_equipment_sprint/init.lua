AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("entities/obj_ff_equipment_base/init.lua")

ENT.ModelColor = Color(33, 255, 0, 255)
ENT.KeyType = KeyTypes.HOLD


ENT.oldWalkSpeed = nil
ENT.oldRunSpeed = nil
local loopSound
ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    self:EmitSound("equipment/sprint/sprint_activate.wav")
    loopSound = CreateSound(self, "equipment/sprint/sprint.wav")
    loopSound:Play()
    self.oldWalkSpeed = self.owner:GetWalkSpeed()
    self.oldRunSpeed = self.owner:GetRunSpeed()
    self.owner:SetWalkSpeed(self.oldRunSpeed*1.5)
    self.owner:SetRunSpeed(self.oldRunSpeed*1.5)
end

ENT.oldDeactivate = ENT.DeactivateEquipment
function ENT:DeactivateEquipment()
    if self.oldDeactivate(self)==false then return end
    if (!self.owner) then return end
    loopSound:Stop()
    self:EmitSound("equipment/sprint/sprint_deactivate.wav")
    self:EmitSound("equipment/sprint/sprint_end_1.wav")
    self.owner:SetWalkSpeed(self.oldWalkSpeed)
    self.owner:SetRunSpeed(self.oldRunSpeed)
end
