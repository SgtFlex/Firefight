ENT.Type = "anim"
ENT.Base = "deployable_base"
ENT.Category = "Halo Equipment"
ENT.Author = "Sgt Flexxx"
ENT.Contact = "https://steamcommunity.com/id/sgtflexxx/"
ENT.Purpose = "To blind foes."
ENT.Instructions = "Use on enemies to blind them."
ENT.Spawnable = false
ENT.PrintName = "Grapple Shot"

if (CLIENT) then
    local ropeMat = Material("cable/rope")

    local ply = nil
    net.Receive("GrappleHit", function()
        ply = net.ReadEntity()
    end)
    
    local oldDraw = ENT.Draw
    function ENT:Draw()
        self:DrawModel()
        render.SetMaterial(ropeMat)
        render.DrawBeam(self:GetPos(), self:GetOwner():GetPos() + self:GetOwner():OBBCenter(), 2, 0, 15, Color(255,255,255,255))
    end
end