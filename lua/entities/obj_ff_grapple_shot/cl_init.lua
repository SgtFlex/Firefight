include( "shared.lua" )
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