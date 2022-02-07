AddCSLuaFile() --For entities to appear clientside (such as the spawnmenu), this function must be used for this file to get sent to clients.

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Category = "Halo Equipment"
ENT.Author = "Sgt Flexxx"
ENT.Contact = "https://steamcommunity.com/id/sgtflexxx/"
ENT.Purpose = "To test code."
ENT.Instructions = ""
ENT.Spawnable = true
ENT.PrintName = "Test Entity"

ENT.AutomaticFrameAdvance = true

if SERVER then
    
    function ENT:TaskStart_HelloWorld( data )
        print(data)
    
        -- Set a variable that is 5 seconds in the future so the task can complete when we tick past it
        self.TaskEndTime = CurTime() + 5
    end
    
    -- Called every think until the task is completed
    function ENT:Task_HelloWorld(data)
        print( data, "again" )
    
        -- Check if the 5 seconds have passed
        if CurTime() < self.TaskEndTime then
            self:TaskComplete()
        end
    end
    

    function ENT:Initialize()
        self:SetModel("models/hce/spv3/cov/phantom/phantom.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_FLY)

        local schdHello = ai_schedule.New( "SayHello" )
        schdHello:AddTask( "HelloWorld", "HELLO" )
        
    end

    function ENT:Think()
        self:SetVelocity(Vector(math.random(-1, 1), math.random(-1, 1), math.random(-0, 0))*50)
        self:SetAngles(self:GetVelocity():GetNormalized():Angle())
        self:NextThink(CurTime())
        return true
    end

    function ENT:MoveToPosition(Pos)
        print("hi12312")
    end

    function ENT:Accelerate()

    end

    function ENT:Decelerate()

    end

end

