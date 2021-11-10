AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("entities/obj_ff_baseEquipment/init.lua")

ENT.ModelColor = Color(33, 255, 0, 255)
function ENT:PressedQ()
    self:ActivateSprint()
end

function ENT:ReleasedQ()
    self:DeactivateSprint()
end

ENT.oldWalkSpeed = nil
ENT.oldRunSpeed = nil
local loopSound
function ENT:ActivateSprint()
    self:EmitSound("equipment/sprint/sprint_activate.wav")
    loopSound = CreateSound(self, "equipment/sprint/sprint.wav")
    loopSound:Play()
    self.oldWalkSpeed = self.owner:GetWalkSpeed()
    self.oldRunSpeed = self.owner:GetRunSpeed()
    self.owner:SetWalkSpeed(self.oldRunSpeed*1.5)
    self.owner:SetRunSpeed(self.oldRunSpeed*1.5)
end

function ENT:DeactivateSprint()
    if (!self.owner) then return end
    loopSound:Stop()
    self:EmitSound("equipment/sprint/sprint_deactivate.wav")
    self:EmitSound("equipment/sprint/sprint_end_1.wav")
    self.owner:SetWalkSpeed(self.oldWalkSpeed)
    self.owner:SetRunSpeed(self.oldRunSpeed)
end
