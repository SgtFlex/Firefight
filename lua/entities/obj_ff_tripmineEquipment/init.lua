AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("entities/obj_ff_baseEquipment/init.lua")

ENT.ModelColor = Color(127, 0, 255, 255)
ENT.Model = "models/hr/unsc/equipment_pack_elite/equipment_pack_elite.mdl"
ENT.KeyType = KeyTypes.PRESS


ENT.oldActivate = ENT.ActivateEquipment
function ENT:ActivateEquipment()
    if self.oldActivate(self)==false then return end --run the old function and check if it ran successfully
    if (!self.owner:IsOnGround()) then return end
    self.mine = ents.Create("base_gmodentity")
    self.mine:SetModel(self:GetModel())
    self.mine:PhysicsInit(SOLID_VPHYSICS)
    self.mine:GetPhysicsObject():Wake()
    self.mine.owner = self.owner

    function self.mine:Initialize()
        self.activateTime = CurTime() + 3
        self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        self:SetPos(self.owner:GetPos() + self.owner:OBBCenter())
        self:GetPhysicsObject():AddVelocity(self.owner:GetAimVector():GetNormalized()*400)
    end

    function self.mine:Explode()
        PrintMessage(3, "Boom!")
        self:Remove()
    end

    function self.mine:Think()
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

    

    self.mine:Spawn()
end