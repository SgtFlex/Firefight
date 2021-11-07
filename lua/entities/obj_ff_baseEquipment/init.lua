AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.owner = nil

function ENT:Initialize()
    self:SetModel("models/hr/unsc/ammo_pouch/ammo_pouch.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    if (IsValid(self:GetPhysicsObject())) then
        self:GetPhysicsObject():Wake()
    end
    self:CallOnRemove("RemoveJetpack", function(self) self:ReleasedQ() end)
end


function ENT:Use(Activator, Caller, UseType, Integer)
    self:AttachToPlayer(Activator)
end

function ENT:AttachToPlayer(player)
    self.owner = player
    self:SetParent(self.owner)
    self:PhysicsInit(SOLID_NONE)
    self:SetNoDraw(true)
    hook.Add("PlayerButtonDown", "QPressed", function(player, button)
        if (player==self.owner) and (button == KEY_Q) and IsValid(self) then
            self:PressedQ()
        end
    end)
    hook.Add("PlayerButtonUp", "QReleased", function(player, button)
        if (player==self.owner) and (button == KEY_Q) and IsValid(self) then
            self:ReleasedQ()
        end
    end)
    hook.Add("PlayerDeath", "Drop", function(victim, infl, att)
        if (victim==self.owner) then
            self:Drop()
        end
    end)
end 

function ENT:PressedQ()
end

function ENT:ReleasedQ()
end

function ENT:Drop()
    self.owner = nil
    self:SetParent(nil)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:GetPhysicsObject():Wake()
    self:SetNoDraw(false)
end