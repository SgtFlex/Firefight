AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/unsc/equipment_trip_mine/equipment_trip_mine.mdl"
ENT.SoundTbl_Explode = {
    "equipment/regenerator/regenerator_expl/regenerator_expl1.wav",
    "equipment/regenerator/regenerator_expl/regenerator_expl2.wav",
    "equipment/regenerator/regenerator_expl/regenerator_expl3.wav",
}
ENT.SndTbl_Collide = {
    "equipment/shared/drop/equipment_drop (1).wav",
    "equipment/shared/drop/equipment_drop (2).wav",
    "equipment/shared/drop/equipment_drop (3).wav",
    "equipment/shared/drop/equipment_drop (4).wav",
}
ENT.EffectPFX = nil
ENT.SndTbl_Deploy = {}
ENT.Snd_IdleLoop = nil
ENT.Duration = nil
ENT.EffectDelay = 0.85
ENT.EffectRadius = 100
ENT.EffectTickRate = 1
ENT.StartHealth = 10
ENT.ExplosionDamage = 0
ENT.ExplosionRadius = 300
ENT.Skin = nil
ENT.Bodygroups = nil



function ENT:Initialize()
    self:SetModel(self.Model)
    if (self.Skin!=nil) then self:SetSkin(self.Skin) end
    if (self.Bodygroups!=nil) then self:SetBodyGroups(self.Bodygroups) end
    self:SetHealth(self.StartHealth)
    self:SetMaxHealth(self.StartHealth)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:GetPhysicsObject():Wake()
    if (!table.IsEmpty(self.SndTbl_Deploy)) then self:EmitSound(self.SndTbl_Deploy[math.random(1, #self.SndTbl_Deploy)]) end
    timer.Simple(self.EffectDelay, function()
        if (!IsValid(self) or self.Snd_IdleLoop==nil) then return end
        self.loopSound = CreateSound(self, self.Snd_IdleLoop)
        self.loopSound:Play()
        if (self.EffectPFX!=nil) then ParticleEffectAttach(self.EffectPFX, 4, self, 1) end
    end)
    self.activateTime = CurTime() + self.EffectDelay
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    if (self.Duration!=nil and self.Duration > 0) then
        timer.Create("Explode"..self:GetCreationID(), self.Duration, 1, function()
            if (!IsValid(self)) then return end
            self:Expire()
        end)
    end
end

function ENT:Explode()
    if (self.ExplosionDamage > 0) then
        local dmginfo = DamageInfo()
        dmginfo:SetDamageType(DMG_BLAST)
        dmginfo:SetDamage(self.ExplosionDamage)
        dmginfo:SetInflictor(self)
        util.BlastDamageInfo(dmginfo, self:GetPos(), self.ExplosionRadius)
    end
    ParticleEffect("Equipment_destroy", self:GetPos(), Angle(0,0,0))
    util.ScreenShake(self:GetPos(), 600, 600, 1.5, 600)
    self:EmitSound(self.SoundTbl_Explode[math.random(1, #self.SoundTbl_Explode)])
    self:Remove()
end

function ENT:Expire()
    self:Explode()
end

function ENT:OnRemove()
    if (self.Snd_IdleLoop!=nil) then
        self.loopSound:Stop()
    end
end

function ENT:Think()
    if (CurTime() > self.activateTime) then
        for k, v in pairs(ents.FindInSphere(self:GetPos(), self.EffectRadius)) do
            if v:IsNPC() or v:IsPlayer() then
                self:EntityEffect(v)
            end
        end
    end

    self:NextThink(CurTime()+self.EffectTickRate)
    return true
end

function ENT:EntityEffect(entity)
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
        self:EmitSound(self.SndTbl_Collide[math.random(1, #self.SndTbl_Collide)])
    elseif (colData.Speed > 500) then
        self:TakeDamage(self.StartHealth)
    end
end