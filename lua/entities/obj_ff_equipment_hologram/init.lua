AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("entities/bases/obj_ff_equipment_base/init.lua")
ENT.ModelColor = Color(130, 150, 0, 255)
ENT.toggledOn = false
ENT.bubble = nil
ENT.KeyType = KeyTypes.PRESS
ENT.Sound_Idle = "equipment/shared/equipment_loop.wav"



ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
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
    self.holo.Duration = 10
    self.holo:SetOwner(self:GetOwner())
    self.holo:SetPos(self:GetOwner():GetPos())
    self.holo:SetAngles(Angle(0, self:GetOwner():EyeAngles().y, 0))
    self.holo:Spawn()
end
