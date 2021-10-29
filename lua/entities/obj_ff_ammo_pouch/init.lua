AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.AmmoTable = {}

function ENT:Initialize()
    self:SetModel("models/hr/unsc/ammo_pouch/ammo_pouch.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    if (IsValid(self:GetPhysicsObject())) then
        self:GetPhysicsObject():Wake()
    end
end

function ENT:SetAmmo(ammoTbl)
    self.AmmoTable = ammoTbl
end

function ENT:Use(activator, caller, useType, value)
    for k,v in pairs(self.AmmoTable) do
        activator:GiveAmmo(v, k)
    end
    self:Remove()
end