AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/unsc/equipment_pack_elite/equipment_pack_elite.mdl"
ENT.SoundTbl_Explode = {
    "equipment/portable_gravity_lift/gravlift_death.wav",
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
    self:EmitSound("equipment/portable_gravity_lift/deploy.wav")
    self.loopSound = CreateSound(self, "equipment/portable_gravity_lift/loop.wav")
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

ENT.LastLiftSound = 0
function ENT:Think()
    if (CurTime() > self.activateTime) then
        local tr = util.TraceHull({
            start = self:GetPos(),
            endpos = self:GetPos() + self:GetUp()*100,
            filter = self,
            mins = Vector(-15,-15, 0),
            maxs = Vector(15,15, 0),
            ignoreworld = true,
        })
        debugoverlay.Box(self:GetPos(), Vector(-15,-15,0), Vector(15,15,100), self.TickRate*3)
        if (tr.Hit and CurTime() > self.LastLiftSound + 0.5) then
            self.LastLiftSound = CurTime()
            self:EmitSound("equipment/portable_gravity_lift/lift.wav")
        end
        
        if (tr.Entity:IsPlayer()) then
            if (tr.Entity:IsOnGround()) then
                tr.Entity:SetPos(tr.Entity:GetPos() + Vector(0,0,6))
            end
            tr.Entity:SetVelocity(self:GetUp()*200)
        elseif (tr.Entity:IsNPC()) then
            tr.Entity:SetVelocity(self:GetUp()*200)
        elseif (IsValid(tr.Entity) and IsValid(tr.Entity:GetPhysicsObject())) then
            tr.Entity:GetPhysicsObject():AddVelocity(self:GetUp()*200)
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