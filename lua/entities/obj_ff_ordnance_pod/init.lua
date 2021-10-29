AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.weapon = "arccw_mw2_anaconda"
ENT.opened = false
ENT.attachedAmmo = nil
function ENT:Initialize()
    self:SetModel("models/hr/unsc/ordnance_pod/ordnance_pod.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    if (IsValid(self:GetPhysicsObject())) then
        self:GetPhysicsObject():Wake()
    end

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
    if (colData.Speed > 150 and self.opened==false) then
        self:SetPos(colData.HitPos)
        self:EmitSound("weapons/rocket launcher/impact/1.ogg")
        self:SetMoveType(MOVETYPE_NONE)
    end
end

function ENT:OpenPod()
    self.opened = true
    local oldPos = self.propDoor:GetPos()
    self.propDoor:SetParent(nil)
    self.propDoor:SetPos(oldPos)
    self.propDoor:GetPhysicsObject():AddVelocity(self:GetForward()*400)
    self:DeleteOnRemove(self.propDoor)
    self:EmitSound("weapons/rocket launcher/impact/3.ogg")

    self.attachedWep = ents.Create(self.weapon)
    self.attachedWep:Spawn()
    self.attachedWep:SetPos(self:GetAttachment(1)["Pos"]+ self:GetRight()*5)
    self.attachedWep:SetAngles(self:GetAttachment(1)["Ang"] + Angle(90,0,0))
    self.attachedWep:SetParent(self)
    self.attachedWep:GetPhysicsObject():Sleep()
    self.attachedAmmo = ents.Create("obj_ff_ammo_pouch")
    self.attachedAmmo:Spawn()
    self.attachedAmmo:SetPos(self:GetAttachment(1)["Pos"] + self:GetRight()*-5)
    self.attachedAmmo:SetAngles(self:GetAttachment(1)["Ang"] + Angle(90,0,0))
    self.attachedAmmo:SetParent(self)
    self.attachedAmmo:GetPhysicsObject():Sleep()
    local ammo = {
        [self.attachedWep:GetPrimaryAmmoType()] = (self.attachedWep:GetMaxClip1()*3),
    }
    self.attachedAmmo:SetAmmo(ammo)

    constraint.NoCollide(self.attachedWep, self)
    constraint.NoCollide(self, self.attachedWep)
    constraint.NoCollide(self.attachedAmmo, self)
    constraint.NoCollide(self, self.attachedAmmo)
end

ENT.checkTime = CurTime()
function ENT:Think()
    if (self.opened==false and self.checkTime + 0.5 < CurTime()) then
        self.checkTime = CurTime()
        for k, v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
            if (v:IsPlayer()) then
                self:OpenPod()
                return
            end
        end
    end
end