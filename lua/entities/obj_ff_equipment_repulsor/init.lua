AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/unsc/equipment/equipment.mdl"
ENT.ModelColor = Color(0, 150, 150, 255)
ENT.KeyType = KeyTypes.PRESS
ENT.ResourceRegen = 0
ENT.ResourceCostInitial = 1
ENT.ResourceMax = 3
ENT.ResourceCur = ENT.ResourceMax
ENT.Strength = 2000

function ENT:ActivateEquipment()
    self.BaseClass.ActivateEquipment(self)
    self:EmitSound("equipment/trip_mine/tripmine_explosion/tripmine_explosion1.wav")
    if (!self:GetOwner():IsOnGround()) then
        self:GetOwner():SetVelocity(self:GetOwner():GetAimVector():GetNormalized()*-750)
    end
    local ents = ents.FindInCone(self.owner:EyePos(), self.owner:GetAimVector(), 500, math.cos( math.rad( 45 ) ))
    local tr = util.TraceLine({
        start = self.owner:EyePos(),
        endpos = self.owner:GetAimVector()*100000,
        filter = self.owner,
        ignoreworld = true,
    })
    for k, entity in pairs(ents) do
        local force = (tr.HitPos - entity:GetPos()):GetNormalized()*self.Strength
        if (IsValid(entity:GetParent() or entity:IsWorld() or entity==self)) then 
            goto cont
        end
        if ((entity:IsNPC() or entity:IsPlayer()) and entity:IsOnGround()) then
            entity:SetPos(entity:GetPos() + Vector(0,0,6))
            entity:SetVelocity(force*5)
        elseif (IsValid(entity:GetPhysicsObject())) then
            entity:SetOwner(self)
            entity:GetPhysicsObject():SetVelocity(force)
        end
        ::cont::
    end
end