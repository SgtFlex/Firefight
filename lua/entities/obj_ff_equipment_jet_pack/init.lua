AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/unsc/equipment_jet_pack/equipment_jet_pack.mdl"
ENT.KeyType = KeyTypes.HOLD
ENT.Sound_Idle = "equipment/shared/equipment_loop.wav"
ENT.ModelColor = Color(125,125,125,255)


local jetLoop = nil
function ENT:ActivateEquipment()
    self.BaseClass.ActivateEquipment(self)
    jetLoop = CreateSound(self, "equipment/jet_pack/jet_loop1.wav")
    jetLoop:Play()
    self:EmitSound("equipment/jet_pack/jet_in.wav")
    jetLoop:Play()
    timer.Create("Fly"..self.owner:GetCreationID(), 0.1, 0, function()
        if (!self.owner) then return end
        if (self.owner:IsOnGround()) then
            self.owner:SetPos(self.owner:GetPos() + Vector(0,0,0.5))
        end
        self.owner:SetVelocity(Vector(0,0,80))
    end)
end

ENT.oldDeactivate = ENT.DeactivateEquipment
function ENT:DeactivateEquipment()
    self.BaseClass.DeactivateEquipment(self)
    if (!self.owner) then return end
    if (jetLoop) then jetLoop:Stop() end
    self:EmitSound("equipment/jet_pack/jet_out.wav")
    timer.Destroy("Fly"..self.owner:GetCreationID())
end