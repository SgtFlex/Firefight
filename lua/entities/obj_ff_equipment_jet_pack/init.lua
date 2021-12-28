AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("entities/obj_ff_equipment_base/init.lua")

ENT.Model = "models/hr/unsc/equipment_jet_pack/equipment_jet_pack.mdl"
ENT.KeyType = KeyTypes.HOLD

local jetLoop 
ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    jetLoop = CreateSound(self, "equipment/jet_pack/jet_loop1.wav")
    jetLoop:Play()
    self:EmitSound("equipment/jet_pack/jet_in.wav")
    jetLoop:Play()
    timer.Create("Fly"..self.owner:GetCreationID(), 0.1, 0, function()
        if (!self.owner) then return end
        if (self.owner:IsOnGround()) then
            self.owner:SetPos(self.owner:GetPos() + Vector(0,0,6))
        end
        self.owner:SetVelocity(Vector(0,0,80))
    end)
end

ENT.oldDeactivate = ENT.DeactivateEquipment
function ENT:DeactivateEquipment()
    if self.oldDeactivate(self)==false then return end
    if (!self.owner) then return end
    jetLoop:Stop()
    self:EmitSound("equipment/jet_pack/jet_out.wav")
    timer.Destroy("Fly"..self.owner:GetCreationID())
end