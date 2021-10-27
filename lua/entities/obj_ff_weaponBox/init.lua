AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/items/ammocrate_pistol.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    if (IsValid(self:GetPhysicsObject())) then
        self:GetPhysicsObject():Wake()
    end
end

function ENT:Use(activator, caller, useType, value)
    local ammoType = activator:GetActiveWeapon():GetPrimaryAmmoType()
    local clipSize = activator:GetActiveWeapon():GetMaxClip1()
    local giveAmmoCount = (activator:GetActiveWeapon():GetMaxClip1()*4 - activator:GetAmmoCount(ammoType))
    if (activator:GetAmmoCount(ammoType) < clipSize*4) then
        activator:GiveAmmo(giveAmmoCount, ammoType)
    end
end