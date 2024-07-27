AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Weapons = {
    "drc_srs99am",
    "drc_spnkr",
    "drc_m45",
    "drc_splaser",
    "drc_m139",
    "drc_m739",
}

ENT.opened = false
ENT.attachedAmmo = nil
ENT.trailSound = nil
ENT.trace = nil
ENT.startPosition = nil
ENT.landed = false
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
    self.propDoor:SetCollisionGroup(2)
    self.propDoor:Spawn()
    constraint.NoCollide(self.propDoor, self)
    constraint.NoCollide(self, self.propDoor)
    util.SpriteTrail(self, 0, Color(150, 150, 150), true, 35, 0, 1, 50, "trails/smoke")
    self.trailSound = CreateSound(self, "ordnance_pod/rocket_loop.wav")
    self.trailSound:SetSoundLevel(90)
    self.trailSound:Play()
    self.trace = util.TraceLine({
        startpos = self:GetPos() + Vector(0,0,-200),
        endpos = self:GetPos() + self:GetUp()*-10000,
        filter = self,
    })
    self.endZ = self.trace.HitPos.z
    self.startZ = self.endZ + 1500
    self.spriteLight = ents.Create("env_sprite")
    self.spriteLight:SetKeyValue("rendermode", "9")
    self.spriteLight:SetKeyValue("renderamt", "255")
    self.spriteLight:SetKeyValue("model","effects/ordnance_pod_beacon.vmt")
    self.spriteLight:SetKeyValue("GlowProxySize","10")
    self.spriteLight:SetKeyValue("rendercolor", "0 255 0")
    self.spriteLight:SetKeyValue("scale", "0.3")
    self.spriteLight:SetPos(self:GetPos() + Vector(0,0,105))
    self.spriteLight:Spawn()
    self.spriteLight:SetParent(self)
    self.spriteLight:Activate()
end

function ENT:SetWeapons(weapons)
    self.Weapons = weapons
end

function ENT:PhysicsCollide(colData, collider)
    if (colData.Speed > 150 and self.landed==false) then
        self.landTime = CurTime()
        self.landed = true
        ParticleEffect("vj_explosion2", self:GetPos(), Angle(0,0,0))
        util.ScreenShake(self:GetPos(), 1000, 1000, 2, 1500)
        self.trailSound:Stop()
        self:SetPos(colData.HitPos)
        self:EmitSound("ordnance_pod/resupply_pod_impact3.wav", 90)
        self:SetMoveType(MOVETYPE_NONE)
    end
end

function ENT:OpenPod()
    
    self.opened = true
    util.ScreenShake(self:GetPos(), 500, 500, 0.5, 500)
    local oldPos = self.propDoor:GetPos()
    self.propDoor:SetParent(nil)
    self.propDoor:SetPos(oldPos)
    self.propDoor:GetPhysicsObject():AddVelocity(self:GetForward()*400)
    self:DeleteOnRemove(self.propDoor)
    self:EmitSound("ordnance_pod/human_expl_small2.wav")

    self.attachedWep = ents.Create(self.Weapons[math.random(1, #self.Weapons)])
    self.attachedWep:Spawn()
    self.attachedWep:SetPos(self:GetAttachment(1)["Pos"])
    self.attachedWep:SetAngles(self:GetAttachment(1)["Ang"] + Angle(90,0,0))
    self.attachedWep:SetParent(self)
    self.attachedWep:GetPhysicsObject():Sleep()
    self.attachedWep.ReserveAmmo = self.attachedWep:GetMaxClip1()*2
    self.attachedWep.Pod = self
    self.attachedWep.Equip = function(self)
        net.Start("DisplayListRemove")
        net.WriteEntity(self.Pod)
        net.Broadcast()
    end
    util.PrecacheModel(self.attachedWep:GetModel())
    constraint.NoCollide(self.attachedWep, self)
    constraint.NoCollide(self, self.attachedWep)
end

ENT.checkTime = CurTime()
function ENT:Think()
    if (self.landed==false) then
        self.currZ = self:GetPos().z
        local dist = math.abs(self.startZ) + math.abs(self.endZ)
        local lerp = math.min(1, (dist-(self.startZ - self.currZ))/(dist))
        self.trailSound:ChangePitch(100*lerp)
    else
        if (self.opened==false and CurTime() > self.landTime + 2.5) then
            for k, v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
                if (v:IsPlayer()) then
                    self:OpenPod()
                    return
                end
            end
        end
    end
    self:NextThink(CurTime())
    return true
end

function ENT:OnRemove()
    self.trailSound:Stop()
end

-- startZ = 2000
-- currZ = 1900
-- endZ = -2000

-- (self.startZ - self.currZ)/(self.startZ + abs(self.endZ))
-- 100/4000