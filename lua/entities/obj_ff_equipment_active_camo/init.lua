AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("entities/bases/obj_ff_equipment_base/init.lua")

util.AddNetworkString("Cloak")

ENT.ModelColor = Color(0, 150, 150, 255)
ENT.Sound_Idle = "equipment/shared/equipment_loop.wav"
ENT.KeyType = KeyTypes.TOGGLE
local loopSound


ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
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
    if self.oldDeactivate(self)==false then return end
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