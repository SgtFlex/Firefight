AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
util.AddNetworkString("AddEquipmentIcon")
ENT.owner = nil

ENT.Model = "models/hr/unsc/equipment/equipment.mdl"
KeyTypes = {
    TOGGLE = 1,
    HOLD = 2,
    PRESS = 3,
}
ENT.KeyType = KeyTypes.PRESS
ENT.EquipmentActive = false


local SndTbl_Collide = {
    "equipment/shared/drop/equipment_drop (1).wav",
    "equipment/shared/drop/equipment_drop (2).wav",
    "equipment/shared/drop/equipment_drop (3).wav",
    "equipment/shared/drop/equipment_drop (4).wav",
}


function ENT:Initialize()
    self:DrawShadow(false)
    self:PlayIdleSound()
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:SetUseType(SIMPLE_USE)
    self:SetModel(self.Model)
    if self.ModelColor then self:SetColor(self.ModelColor) end
    if self.Skin then self:SetSkin(self.Skin) end
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    if (IsValid(self:GetPhysicsObject())) then
        self:GetPhysicsObject():Wake()
    end
    self:CallOnRemove("RemoveJetpack", function(self) self:DeactivateEquipment() end)
end

function ENT:PhysicsCollide(colData, collider)
    if (colData.Speed > 50) then
        self:EmitSound(SndTbl_Collide[math.random(1, #SndTbl_Collide)])
    end
end

function ENT:Use(Activator, Caller, UseType, Integer)
    self:AttachToPlayer(Activator)
    net.Start("AddEquipmentIcon")
    net.Send(Activator)
end

-- function ENT:AttachToPlayer(player)
--     self.owner = player
--     if (self.owner.HaloEquipment!=nil and self.owner.HaloEquipment.Drop!=nil) then self.owner.HaloEquipment:Drop() end
--     self.Snd_EquipmentLoop:Stop()
--     self:EmitSound("equipment/shared/equipment_pickup.wav")
--     self.owner.HaloEquipment = self
--     self:SetParent(self.owner)
--     self:SetSolid(SOLID_NONE)
--     self:SetNoDraw(true)
--     hook.Add("PlayerButtonDown", "QPressed", function(player, button)
--         if (player==self.owner) and (button == KEY_T) and IsValid(self) then
--             PrintMessage(3, tostring(self.KeyType==KeyTypes.TOGGLE))
--             if (self.KeyType==KeyTypes.TOGGLE and self.EquipmentActive==true) then --If the keyType is toggle and it's active, deactivate the effect
--                 self:DeactivateEquipment()
--             else
--                 self:ActivateEquipment()
--             end
--         end
--     end)
--     hook.Add("PlayerButtonUp", "QReleased", function(player, button)
--         if (player==self.owner) and (button == KEY_T) and IsValid(self) then
--             if (self.KeyType==KeyTypes.HOLD) then --Make sure to deactivate only if our keytype is HOLD
--                 self:DeactivateEquipment()
--             end
--         end
--     end)
--     hook.Add("PlayerDeath", "Drop", function(victim, infl, att)
--         if (victim==self.owner) then
--             self:Drop()
--         end
--     end)
-- end

-- local rTickRate = 0.1
-- function ENT:ActivateEquipment()
--     if (self.ResourceCur < self.ResourceCostInitial) then return false end
--     PrintMessage(3, "Activate")
--     self.EquipmentActive = true
--     self.ResourceCur = self.ResourceCur - self.ResourceCostInitial
--     timer.Destroy("EquipmentRegen"..self:GetCreationID()) --Stop the regen if it's active

--     if (self.KeyType != KeyTypes.PRESS) then
--         timer.Create("EquipmentDegen"..self:GetCreationID(), rTickRate, 0, function() --Deduct the resource pool by the cost per tick
--             if !IsValid(self) then return end
--             self.ResourceCur = math.max(0, self.ResourceCur - (self.ResourceCostPerSec * rTickRate))
--             if (self.ResourceCur <= 0) then
--                 self:DeactivateEquipment()
--                 timer.Destroy("EquipmentDegen"..self:GetCreationID())
--             end
--         end)
--     end
-- end

-- function ENT:DeactivateEquipment()
--     if (self.EquipmentActive==false) then return false end
--     PrintMessage(3, "Deactivate")
--     self.EquipmentActive = false
--     timer.Destroy("EquipmentDegen"..self:GetCreationID()) --Stop the degen if it's active
--     timer.Create("EquipmentRegen"..self:GetCreationID(), rTickRate, 0, function()
--         if !IsValid(self) then return end
--         self.ResourceCur = math.min(self.ResourceMax, self.ResourceCur + (self.ResourceRegen * rTickRate))
--         if (self.ResourceCur >= self.ResourceMax) then
--             timer.Destroy("EquipmentRegen"..self:GetCreationID())
--         end
--     end)
-- end

function ENT:Drop()
    self:DeactivateEquipment()
    self:SetParent(nil)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():Wake()
    self:SetPos(self.owner:GetPos() + self.owner:OBBCenter())
    self:SetAngles(Angle(0,0,0))
    self:GetPhysicsObject():AddVelocity(self.owner:GetForward()*100 + self.owner:GetVelocity())
    self:SetNoDraw(false)
    self.owner.HaloEquipment = nil
    self.owner = nil
    self:PlayIdleSound()
end

function ENT:PlayIdleSound()
    if self.Sound_Idle==nil then return end
    self.Snd_EquipmentLoop = CreateSound(self, "equipment/shared/equipment_loop.wav")
    self.Snd_EquipmentLoop:Play()
    self.Snd_EquipmentLoop:ChangeVolume(0.25)
    self.Snd_EquipmentLoop:SetSoundLevel(20)
end

function ENT:OnRemove()
    if (self.owner!=nil) then
        self:Drop()
    end
    
    if (self.Snd_EquipmentLoop) then self.Snd_EquipmentLoop:Stop() end
end