AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.ammoType = nil
ENT.ammoCount = nil

function ENT:Initialize()
    self:SetModel("models/hr/unsc/ammo_pouch/ammo_pouch.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    if (IsValid(self:GetPhysicsObject())) then
        self:GetPhysicsObject():Wake()
    end
end

function ENT:SetAmmo(ammoType, ammoCount)
    self.ammoType = ammoType
    self.ammoCount = ammoCount
end

function ENT:Use(activator, caller, useType, value)
    local weps = activator:GetWeapons()
    for i, weapon in pairs(weps) do
        local maxReserve = (weapon:GetMaxClip1()*3) + (weapon:GetMaxClip1() - weapon:Clip1())
        local amountToGive = 50
        if (self.ammoType==weapon:GetPrimaryAmmoType() and activator:GetAmmoCount(self.ammoType) < maxReserve) then
            activator:GiveAmmo(amountToGive, self.ammoType)
            self.ammoCount = self.ammoCount - amountToGive
            if (self.ammoCount <= 0) then
                self:Remove()
                break
            end
        end
    end
end
