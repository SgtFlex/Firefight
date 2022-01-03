AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/bases/obj_ff_equipment_base/init.lua")

ENT.Model = "models/sentinels/sentinel_turret.mdl"
ENT.KeyType = KeyTypes.PRESS
ENT.ResourceRegen = 0
ENT.ResourceCostInitial = 1
ENT.ResourceMax = 3
ENT.ResourceCur = ENT.ResourceMax

ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    self:EmitSound("equipment/trip_mine/tripmine_explosion/tripmine_explosion1.wav")
    self.sensor = ents.Create("obj_ff_threat_sensor")
    self.sensor.Duration = 15
    self.sensor:SetPos(self.owner:GetPos() + self.owner:OBBCenter())
    self.sensor.owner = self.owner
    self.sensor:Spawn()
    self.sensor:GetPhysicsObject():AddVelocity(self.owner:GetAimVector():GetNormalized()*1500)
end