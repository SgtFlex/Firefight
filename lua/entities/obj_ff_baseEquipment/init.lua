AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.owner = nil
ENT.ResourceMax = 100
ENT.ResourceCur = 100
ENT.ResourceRegen = 5
ENT.ResourceCostInitial = 25
ENT.ResourceCostPerSec = 5
ENT.ModelColor = Color(255, 255, 255, 255)
ENT.Model = "models/hr/unsc/equipment/equipment.mdl"

local SndTbl_Collide = {
    "equipment/shared/drop/equipment_drop (1).wav",
    "equipment/shared/drop/equipment_drop (2).wav",
    "equipment/shared/drop/equipment_drop (3).wav",
    "equipment/shared/drop/equipment_drop (4).wav",
}


function ENT:Initialize()
    self.Snd_EquipmentLoop = CreateSound(self, "equipment/shared/equipment_loop.wav")
    self.Snd_EquipmentLoop:Play()
    self.Snd_EquipmentLoop:ChangeVolume(0.25)
    self.Snd_EquipmentLoop:SetSoundLevel(20)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:SetUseType(SIMPLE_USE)
    self:SetColor(self.ModelColor)
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    if (IsValid(self:GetPhysicsObject())) then
        self:GetPhysicsObject():Wake()
    end
    self:CallOnRemove("RemoveJetpack", function(self) self:ReleasedQ() end)
end

function ENT:PhysicsCollide(colData, collider)
    if (colData.Speed > 50) then
        self:EmitSound(SndTbl_Collide[math.random(1, #SndTbl_Collide)])
    end
end

-- function ENT:Think()


--     self:NextThink( CurTime() ) -- Set the next think to run as soon as possible, i.e. the next frame.
--     return true
-- end


function ENT:Use(Activator, Caller, UseType, Integer)
    self:AttachToPlayer(Activator)
end

function ENT:AttachToPlayer(player)
    self.owner = player
    if (self.owner.HaloEquipment!=nil) then self.owner.HaloEquipment:Drop() end
    self.Snd_EquipmentLoop:Stop()
    self:EmitSound("equipment/shared/equipment_pickup.wav")
    self.owner.HaloEquipment = self
    self:SetParent(self.owner)
    self:SetSolid(SOLID_NONE)
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
    if (self.ResourceCostInitial < self.ResourceCur) then return end
    
end

function ENT:ReleasedQ()
end

function ENT:Drop()
    self.Snd_EquipmentLoop:Play()
    self:SetParent(nil)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():Wake()
    self:SetPos(self.owner:GetPos() + self.owner:OBBCenter())
    self:SetAngles(Angle(0,0,0))
    self:GetPhysicsObject():AddVelocity(self.owner:GetForward()*100)
    
   
    
    
    self:SetNoDraw(false)
    self.owner.HaloEquipment = nil
    self.owner = nil
end

function ENT:Remove()
    self.Snd_EquipmentLoop:Stop()
end