AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.RefillableWeapons = {
    "drc_dmr",
}

function ENT:Initialize()
    self:SetModel("models/hr/unsc/ammo_box/ammo_box.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    if (IsValid(self:GetPhysicsObject())) then
        self:GetPhysicsObject():Wake()
    end
end

local ammoType = nil
local clipSize = nil
local giveAmmoCount = nil
function ENT:Use(activator, caller, useType, value)
    for k, v in pairs(activator:GetWeapons()) do
        if (table.HasValue(self.RefillableWeapons, v:GetClass())) then
            ammoType = v:GetPrimaryAmmoType()
            clipSize = v:GetMaxClip1()
            if (activator:GetAmmoCount(ammoType) < clipSize*4) then
                giveAmmoCount = (v:GetMaxClip1()*4 - activator:GetAmmoCount(ammoType))
                activator:GiveAmmo(giveAmmoCount, ammoType)
            end
        end
    end
end