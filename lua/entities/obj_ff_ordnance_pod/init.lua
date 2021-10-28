AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.weapon = "drc_spnkr"

function ENT:Initialize()
    self:SetModel("models/hr/unsc/ordnance_pod/ordnance_pod.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    if (IsValid(self:GetPhysicsObject())) then
        self:GetPhysicsObject():Wake()
    end
    local attachedWep = ents.Create(self.weapon)
    attachedWep:SetPos(self:GetAttachment(1)["Pos"])
    attachedWep:SetAngles(self:GetAttachment(1)["Ang"])
    attachedWep:SetParent(self, self:LookupAttachment("gun_spawn"))
    attachedWep:Spawn()

    self.propDoor = ents.Create("prop_physics")
    self.propDoor:SetModel("models/hr/unsc/ordnance_pod_panel/ordnance_pod_panel.mdl")
    self.propDoor:SetParent(self)
    self.propDoor:SetPos(self:GetPos())
    self.propDoor:SetAngles(self:GetAngles())
    self.propDoor:Spawn()
    constraint.NoCollide(self.propDoor, self)
    constraint.NoCollide(self, self.propDoor)
end

function ENT:SetWeapon(weapon)
    self.weapon = weapon
end

function ENT:PhysicsCollide(colData, collider)
    if (colData.Speed > 150) then
        self:EmitSound("weapons/rocket launcher/impact/1.ogg")
        self:SetMoveType(MOVETYPE_NONE)
        timer.Simple(2, function()
            local oldPos = self.propDoor:GetPos()
            self.propDoor:SetParent(nil)
            self.propDoor:SetPos(oldPos)
            self.propDoor:GetPhysicsObject():AddVelocity(self:GetForward()*400)
            self:DeleteOnRemove(self.propDoor)
            self:EmitSound("weapons/rocket launcher/impact/3.ogg")
            timer.Simple(300, function() self:Remove() end)
        end)
    end
end