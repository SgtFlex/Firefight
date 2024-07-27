AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.ModelColor = Color(0, 150, 0, 255)
ENT.KeyType = KeyTypes.HOLD
ENT.Sound_Idle = "equipment/shared/equipment_loop.wav"


ENT.oldWalkSpeed = nil
ENT.oldRunSpeed = nil
local loopSound
function ENT:ActivateEquipment()
    self.BaseClass.ActivateEquipment(self)
    self:EmitSound("equipment/sprint/sprint_activate.wav")
    loopSound = CreateSound(self, "equipment/sprint/sprint.wav")
    loopSound:Play()
    self.oldWalkSpeed = self.owner:GetWalkSpeed()
    self.oldRunSpeed = self.owner:GetRunSpeed()
    self.owner:SetWalkSpeed(self.oldRunSpeed*1.5)
    self.owner:SetRunSpeed(self.oldRunSpeed*1.5)
end

function ENT:DeactivateEquipment()
    self.BaseClass.DeactivateEquipment(self)
    if (!self.owner) then return end
    loopSound:Stop()
    self:EmitSound("equipment/sprint/sprint_deactivate.wav")
    self:EmitSound("equipment/sprint/sprint_end_1.wav")
    self.owner:SetWalkSpeed(self.oldWalkSpeed)
    self.owner:SetRunSpeed(self.oldRunSpeed)
end
