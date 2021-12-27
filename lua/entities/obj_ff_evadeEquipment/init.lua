AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("entities/obj_ff_baseEquipment/init.lua")

ENT.ModelColor = Color(127, 0, 255, 255)
ENT.Model = "models/hr/unsc/equipment_pack_elite/equipment_pack_elite.mdl"
ENT.KeyType = KeyTypes.PRESS


ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    if (!self.owner:IsOnGround()) then return end
    self:EmitSound("equipment/evade/evade_activate.wav")
    self.owner:SetPos(self.owner:GetPos() + Vector(0,0,10))
    local velXY = Vector(self.owner:GetVelocity().x, self.owner:GetVelocity().y, 0):GetNormalized()
    self.owner:SetVelocity(velXY*1500)
end