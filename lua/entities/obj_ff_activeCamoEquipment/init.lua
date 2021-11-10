AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include ("entities/obj_ff_baseEquipment/init.lua")

util.AddNetworkString("Cloak")

ENT.toggledOn = false
ENT.ModelColor = Color(0, 255, 255, 255)
local loopSound
function ENT:PressedQ()
    self:ActivateCamo()
end

function ENT:ReleasedQ()

end

function ENT:ActivateCamo()
    self.toggledOn = !self.toggledOn
    net.Start("Cloak")
    net.WriteBool(self.toggledOn)
    net.Send(self.owner)
    if (self.toggledOn) then
        self.owner:RemoveAllDecals()
        self.owner:DrawShadow(false)
        self.owner.Mat = self.owner:GetMaterial()
        self.owner:SetMaterial("effects/spv3/cloak")
        loopSound = CreateSound(self, "equipment/cloak/loop.wav")
        loopSound:Play()
        loopSound:ChangeVolume(0)
        loopSound:ChangeVolume(1, 2)
        self.owner:SetDSP(31)
        self.owner:AddFlags(FL_NOTARGET)
    else
        self.owner:SetMaterial(self.owner.Mat)
        self.owner:DrawShadow(true)
        loopSound:ChangeVolume(0, 2)
        self.owner:SetDSP(0)
        timer.Simple(2, function() 
            loopSound:Stop() 
        end)
        self.owner:RemoveFlags(FL_NOTARGET)
        self:EmitSound("equipment/cloak/invisibility_deactivate.wav")
    end
end

function ENT:DeactivateCamo()

end