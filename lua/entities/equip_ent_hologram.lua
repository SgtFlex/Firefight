AddCSLuaFile() --For entities to appear clientside (such as the spawnmenu), this function must be used for this file to get sent to clients.

ENT.Type = "nextbot"
ENT.Base = "base_nextbot"
ENT.Category = "Halo Equipment"
ENT.Author = "Sgt Flexxx"
ENT.Contact = "https://steamcommunity.com/id/sgtflexxx/"
ENT.Purpose = "To distract enemies."
ENT.Instructions = "Use to distract foes."
ENT.Spawnable = true
ENT.PrintName = "Hologram"

ENT.AutomaticFrameAdvance = true

if SERVER then
    ENT.Duration = 0
    ENT.AnimTbl_ACT = {
        Idle = nil,
        Walk = nil,
        Run = nil,
        CrouchIdle = nil,
        CrouchWalk = nil,
        Jump = nil,
        SwimIdle = nil,
        Swim = nil,
    }
    function ENT:SpawnFunction(ply, tr, class) --Set ownership
        local ent = ents.Create(class)
        ent:SetPos(tr.HitPos)
        ent:SetAngles(ply:GetAngles() + Angle(0,180,0))
        ent:SetOwner(ply)
        ent:Spawn()
        ent:Activate()
    
        return ent
    end

    function ENT:Initialize()
        self:SetupMovement()
        self:EmitSound("equipment/hologram/holo_activate.wav")
        self:SetModel(self:GetOwner():GetModel())
        self:SetSkin(self:GetOwner():GetSkin())
        self:SetColor(self:GetOwner():GetColor())
        self:SetBodyGroups(self:GetOwner():GetBodyGroups())
        self:SetMaxHealth(self:GetOwner():GetMaxHealth())
        self:SetHealth(self:GetOwner():Health())
        self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
        self:AddFlags(FL_OBJECT)
        self:ResetSequence(self:SelectWeightedSequence((self.AnimTbl_ACT["Idle"])))
        local gun = ents.Create("prop_dynamic")
        gun:SetModel(self:GetOwner():GetActiveWeapon():GetModel())
        gun:SetOwner(self)
        gun:Spawn()
        gun:SetParent(self)
        gun:Fire("SetParentAttachment","anim_attachment_RH")
        gun:FollowBone(self, 31)
        gun:AddEffects(EF_BONEMERGE)
        print("Player:                      "..tostring(self:GetOwner()))
        print("Player's weapon:             "..tostring(self:GetOwner():GetActiveWeapon()))
        print("Weapon's parent:             "..tostring(self:GetOwner():GetActiveWeapon():GetParent()))
        print("Weapon's parent attachment:  "..tostring(self:GetOwner():GetActiveWeapon():GetParentAttachment()))
        print("Weapon's effect bitflag:     "..tostring(self:GetOwner():GetActiveWeapon():GetEffects()))
        -- --Attach whatever's attached to the player, also to the hologram
        -- for _, v in pairs(self:GetOwner():GetChildren()) do
        --     ent = ents.Create(v:GetClass())
        --     ent:SetParent(self, v:GetParentAttachment())
        --     ent:SetPos(v:GetPos())
        --     ent:SetAngles(v:GetAngles())
        --     ent:Spawn()
        --     ent:SetNoDraw(v:GetNoDraw())
        --     ent:SetColor(v:GetColor())
        --     ent:SetSkin(v:GetSkin())
        --     ent:SetBodyGroups(v:GetBodyGroups())
        -- end
        
        if (self.Duration > 0) then
            timer.Create("HoloDespawn"..self:GetCreationID(), self.Duration, 1, function()
                if (!IsValid(self) or !IsValid(self)) then return end
                self:Remove()
            end)
        end
    end

    function ENT:SetupMovement()
        local holdType = self:GetOwner():GetActiveWeapon():GetHoldType()
        local holdTypeStartNumber = nil
        if (holdType=="pistol") then
            holdTypeStartNumber = 1787
        elseif (holdType == "smg") then
            holdTypeStartNumber = 1797
        elseif (holdType == "grenade") then
            holdTypeStartNumber = 1737
        elseif (holdType == "ar2") then
            holdTypeStartNumber = 1807
        elseif (holdType == "shotgun") then
            holdTypeStartNumber = 1817
        elseif (holdType == "rpg") then
            holdTypeStartNumber = 1827
        elseif (holdType == "physgun") then
            holdTypeStartNumber = 1857
        elseif (holdType == "crossbow") then
            holdTypeStartNumber = 1867
        elseif (holdType == "melee") then
            holdTypeStartNumber = 1877
        elseif (holdType == "slam") then
            holdTypeStartNumber = 1887
        elseif (holdType == "normal") then
            holdTypeStartNumber = 1777
        elseif (holdType == "fist") then
            holdTypeStartNumber = 1960
        elseif (holdType == "melee2") then
            holdTypeStartNumber = 1995
        elseif (holdType == "passive") then
            holdTypeStartNumber = 1985
        elseif (holdType == "knife") then
            holdTypeStartNumber = 1975
        elseif (holdType == "duel") then
            holdTypeStartNumber = 1847
        elseif (holdType == "camera") then
            holdTypeStartNumber = 1673
        elseif (holdType == "magic") then
            holdTypeStartNumber = 1653
        elseif (holdType == "revolver") then
            holdTypeStartNumber = 1663
        else
            holdTypeStartNumber = 1807 -- ar2 holdtype
        end
        self.AnimTbl_ACT["Idle"] = holdTypeStartNumber
        self.AnimTbl_ACT["Walk"] = holdTypeStartNumber + 1
        self.AnimTbl_ACT["Run"] = holdTypeStartNumber + 2
        self.AnimTbl_ACT["CrouchIdle"] = holdTypeStartNumber + 3
        self.AnimTbl_ACT["CrouchWalk"] = holdTypeStartNumber + 4
        self.AnimTbl_ACT["Jump"] = holdTypeStartNumber + 7
        self.AnimTbl_ACT["SwimIdle"] = holdTypeStartNumber + 8
        self.AnimTbl_ACT["Swim"] = holdTypeStartNumber + 9
    end

    function ENT:Think()
        local speed = self:GetVelocity():Length()
        local maxSpeed = 200
        if (self:WaterLevel()>=2) then
            if (speed==0) then
                self:ResetSequence(self:SelectWeightedSequence((self.AnimTbl_ACT["SwimIdle"])))
            else
                self:ResetSequence(self:SelectWeightedSequence((self.AnimTbl_ACT["Swim"])))
            end
            self:SetPoseParameter("move_x", speed)
        elseif (!self:IsOnGround()) then
            self:StartActivity(self.AnimTbl_ACT["Jump"])
        else
            local speed = self:GetVelocity():Length()
            if (speed==0) then
                self:ResetSequence(self:SelectWeightedSequence((self.AnimTbl_ACT["Idle"])))
            -- elseif (speed<=self:GetOwner():GetWalkSpeed()/2) then --Actually slow walking
            --     maxSpeed = self:GetOwner():GetWalkSpeed()
            --     print("walking")
            --     self:ResetSequence(self:SelectWeightedSequence((self.AnimTbl_ACT["Walk"])))
            else --Normal walking pace for players
                maxSpeed = self:GetOwner():GetWalkSpeed()
                self:ResetSequence(self:SelectWeightedSequence((self.AnimTbl_ACT["Run"])))
            end
            self:SetPoseParameter("move_x", speed/maxSpeed)
        end
    end

    function ENT:RunBehaviour()
        self.loco:SetAvoidAllowed(false)
        self.loco:SetJumpGapsAllowed(false)
        self.loco:SetDeathDropHeight(100000)
        self.loco:SetClimbAllowed(false)
        self.loco:SetAcceleration(1200)
        self.loco:SetDesiredSpeed(self:GetOwner():GetWalkSpeed())
        self.loco:SetStepHeight(25)
        if (self:GetOwner()) then
            local trace = util.TraceLine({
                start = self:GetOwner():EyePos(),
                endpos = self:GetOwner():EyePos() + self:GetOwner():GetAimVector()*10000,
                filter = {self:GetOwner(), self},
                ignoreworld = false,
            })
            debugoverlay.Line(self:GetOwner():EyePos(), self:GetOwner():EyePos() + self:GetOwner():GetAimVector()*1000, 5)
            while (true) do
                self:MoveToPos(trace.HitPos, {tolerance = 50})
                coroutine.yield()
            end
        end
    end

    function ENT:OnTakeDamage(dmginfo)
        dmginfo:ScaleDamage(3)
        if (dmginfo:GetDamage() >= self:Health()) then
            self:Remove()
        end
    end

    function ENT:OnRemove()
        self:EmitSound("equipment/bubble_shield/bubble_deativate.wav")
        ParticleEffect("Bubble_destroy", self:GetPos(), Angle(0,0,0))
    end
end

