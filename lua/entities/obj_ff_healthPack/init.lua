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
    if ((activator:Health() < activator:GetMaxHealth()) && self.bUsable==true) then
        activator:SetHealth(activator:GetMaxHealth())
        self:SetUsable(false)
    end
end

function ENT:SetUsable(newUsable)
    self.bUsable = newUsable
    if (self.bUsable) then
        self:SetColor(Color(0, 150, 0))
        -- net.Start("DisplayListAdd")
        -- net.WriteTable({self, "HEALTH", nil, Color(0, 200, 255)})
        -- net.Broadcast()
    else
        self:SetColor(Color(150, 0, 0))
        -- net.Start("DisplayListRemove")
        -- net.WriteEntity(self)
        -- net.Broadcast()
    end
end
