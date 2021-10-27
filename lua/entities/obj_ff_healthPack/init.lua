AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.bUsable = nil
function ENT:Initialize()
    self:SetModel("models/ishi/halo_rebirth/props/human/health_kit.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    if (IsValid(self:GetPhysicsObject())) then
        self:GetPhysicsObject():Wake()
    end
    self:SetUsable(true)
end

function ENT:Use(activator, caller, useType, value)
    if ((activator:Health() < activator:GetMaxHealth()) && bUsable==true) then
        activator:SetHealth(activator:GetMaxHealth())
        self:SetUsable(false)
    end
end

function ENT:SetUsable(newUsable)
    bUsable = newUsable
    if (bUsable) then
        self:SetColor(Color(0, 150, 0))
    else
        self:SetColor(Color(150, 0, 0))
    end
end
