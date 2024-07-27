AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("Cloak")
ENT.Model = "models/hr/unsc/equipment/equipment.mdl"

ENT.ModelColor = Color(0, 150, 150, 255)
ENT.Sound_Idle = "equipment/shared/equipment_loop.wav"
ENT.KeyType = KeyTypes.TOGGLE
local loopSound = nil

function ENT:ActivateEquipment()
    self.BaseClass.ActivateEquipment(self)
    net.Start("Cloak")
    net.WriteBool(self.EquipmentActive)
    net.Send(self.owner)
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
end

ENT.oldDeactivate = ENT.DeactivateEquipment
function ENT:DeactivateEquipment()
    self.BaseClass.DeactivateEquipment(self)
    net.Start("Cloak")
    net.WriteBool(self.EquipmentActive)
    net.Send(self.owner)
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

function ENT:Think()
    local oldVel = self:GetPhysicsObject():GetVelocity()
    self:NextThink(CurTime())
    self:GetPhysicsObject():SetVelocity(oldVel)
    self:GetPhysicsObject():SetAngles(Angle(0, self:GetAngles().y, 0))
    return true
end