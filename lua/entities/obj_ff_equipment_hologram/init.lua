AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.ModelColor = Color(130, 150, 0, 255)
ENT.toggledOn = false
ENT.bubble = nil
ENT.KeyType = KeyTypes.PRESS
ENT.Sound_Idle = "equipment/shared/equipment_loop.wav"



ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    self.BaseClass.ActivateEquipment(self)
    if (IsValid(self.holo)) then 
        timer.Destroy("HoloDespawn"..self.holo:GetCreationID())
        self.holo:Remove() 
    end
    local trace = util.TraceLine({
        start = self:GetOwner():EyePos(),
        endpos = self:GetOwner():EyePos() + self:GetOwner():GetAimVector()*10000,
        filter = {self:GetOwner(), self},
        ignoreworld = false,
    })
    self.holo = ents.Create("equip_ent_hologram")
    self.holo.endPos = trace.HitPos
    self.holo.Duration = self.DeployableDuration
    self.holo:SetOwner(self:GetOwner())
    self.holo:SetPos(self:GetOwner():GetPos())
    self.holo:SetAngles(Angle(0, self:GetOwner():EyeAngles().y, 0))
    self.holo:Spawn()
end
