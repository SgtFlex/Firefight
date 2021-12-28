AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = "models/hr/unsc/equipment_pack_elite/equipment_pack_elite.mdl"
ENT.SoundTbl_Explode = {
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion1.wav",
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion2.wav",
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion3.wav",
    "equipment/trip_mine/tripmine_explosion/tripmine_explosion5.wav",
}


function ENT:Initialize()
    self:EmitSound("equipment/trip_mine/tripmine_armed.wav")
    timer.Simple(0.85, function()
        self.loopSound = CreateSound(self, "equipment/trip_mine/loop.wav")
        self.loopSound:Play()
    end)
    self.activateTime = CurTime() + 3
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:SetPos(self.owner:GetPos() + self.owner:OBBCenter())
    self:GetPhysicsObject():AddVelocity(self.owner:GetAimVector():GetNormalized()*400)
    timer.Create("Explode"..self:GetCreationID(), self.Duration, 1, function()
        if (IsValid(self)) then
            self:Expire()
        end
    end)
end

function ENT:Explode()
    self:EmitSound(self.SoundTbl_Explode[math.random(1, #self.SoundTbl_Explode)])
    self.loopSound:Stop()
    self:Remove()
end

function ENT:Think()
    if (CurTime() > self.activateTime) then
        for k, v in pairs(ents.FindInSphere(self:GetPos(), 150)) do
            if v:IsNPC() or v:IsPlayer() then
                self:Explode()
            end
        end
    end

    self:NextThink(CurTime()+1)
    return true
end

function ENT:Expire()
    self.loopSound:Stop()
    self:EmitSound("equipment/trip_mine/expire.wav")
    timer.Simple(5, function()
        self:Explode()
    end)
end