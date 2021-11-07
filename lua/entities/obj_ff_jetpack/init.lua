AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("entities/obj_ff_baseEquipment/init.lua")


function ENT:PressedQ()
    self:ActivateJets()
end

function ENT:ReleasedQ()
    self:DeactivateJets()
end

local jetLoop 
function ENT:ActivateJets()
    jetLoop = CreateSound(self, "equipment/jet_pack/jet_loop1.wav")
    jetLoop:Play()
    self:EmitSound("equipment/jet_pack/jet_in.wav")
    jetLoop:Play()
    timer.Create("Fly"..self.owner:GetCreationID(), 0.1, 0, function()
        if (!self.owner) then return end
        self.owner:SetVelocity(Vector(0,0,80))
    end)
end

function ENT:DeactivateJets()
    if (!self.owner) then return end
    jetLoop:Stop()
    self:EmitSound("equipment/jet_pack/jet_out.wav")
    timer.Destroy("Fly"..self.owner:GetCreationID())
end
