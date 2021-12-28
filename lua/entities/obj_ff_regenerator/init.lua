AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/unsc/equipment_pack_elite/equipment_pack_elite.mdl"
ENT.SoundTbl_Explode = {
    "equipment/regenerator/regenerator_expl/regenerator_expl1.wav",
    "equipment/regenerator/regenerator_expl/regenerator_expl2.wav",
    "equipment/regenerator/regenerator_expl/regenerator_expl3.wav",
}
local SndTbl_Collide = {
    "equipment/shared/drop/equipment_drop (1).wav",
    "equipment/shared/drop/equipment_drop (2).wav",
    "equipment/shared/drop/equipment_drop (3).wav",
    "equipment/shared/drop/equipment_drop (4).wav",
}
ENT.Duration = 15
ENT.ReplenishRadius = 200
ENT.TickRate = 0.1
ENT.HealthAmount = 3
ENT.ArmorAmount = 3

function ENT:Initialize()
    self:SetMaxHealth(10)
    self:SetHealth(10)
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:EmitSound("equipment/regenerator/in.wav")
    self:EmitSound("equipment/regenerator/regenerator_arm.wav")
    self.loopSound = CreateSound(self, "equipment/regenerator/loop.wav")
    self.loopSound:Play()
    self.activateTime = CurTime() + 1
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    
    timer.Create("Explode"..self:GetCreationID(), self.Duration, 1, function()
        if (!IsValid(self)) then return end
        self:Explode()
    end)
end

function ENT:Explode()
    util.ScreenShake(self:GetPos(), 600, 600, 1.5, 600)
    self:EmitSound(self.SoundTbl_Explode[math.random(1, #self.SoundTbl_Explode)])
    self:Remove()
end


function ENT:OnRemove()
    self.loopSound:Stop()
end


function ENT:Think()
    if (CurTime() > self.activateTime) then
        for k, v in pairs(ents.FindInSphere(self:GetPos(), self.ReplenishRadius)) do
            if (v:IsNPC() or v:IsPlayer()) then
                if (v:Health() < v:GetMaxHealth()) then
                    v:SetHealth(math.min(v:Health() + self.HealthAmount, v:GetMaxHealth()))
                elseif (v:Armor() < v:GetMaxArmor()) then
                    v:SetArmor(math.min(v:Armor() + self.ArmorAmount, v:GetMaxArmor()))
                end
            end
        end
    end

    self:NextThink(CurTime()+self.TickRate)
    return true
end

function ENT:OnTakeDamage(dmginfo)
    if dmginfo:GetInflictor()==self then return end
    self:SetHealth(self:Health() - dmginfo:GetDamage())
    if self:Health() <= 0 then
        self:Explode()
    end
end

function ENT:PhysicsCollide(colData, collider)
    if (colData.Speed > 50) then
        self:EmitSound(SndTbl_Collide[math.random(1, #SndTbl_Collide)])
    end
end