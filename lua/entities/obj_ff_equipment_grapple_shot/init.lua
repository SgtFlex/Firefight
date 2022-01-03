AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/bases/obj_ff_equipment_base/init.lua")

ENT.Model = "models/hr/unsc/equipment/equipment.mdl"
ENT.ModelColor = Color(0, 150, 150, 255)
ENT.KeyType = KeyTypes.PRESS
ENT.ResourceRegen = 0
ENT.ResourceCostInitial = 0
ENT.ResourceMax = 3
ENT.ResourceCur = ENT.ResourceMax


ENT.oldActivate = ENT.ActivateEquipment
ENT.LoopSound = nil
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    self:EmitSound("equipment/grapple_shot/deploy.wav")
    self.sensor = ents.Create("obj_ff_grapple_shot")
    self.sensor.Duration = 15
    self.sensor:SetPos(self.owner:EyePos())
    self.sensor.owner = self.owner
    self.sensor.Spawner = self
    self.LoopSound = CreateSound(self, "equipment/grapple_shot/loop.wav")
    self.sensor:Spawn()
    self.sensor:GetPhysicsObject():AddVelocity(self.owner:GetAimVector():GetNormalized()*4000)
end
