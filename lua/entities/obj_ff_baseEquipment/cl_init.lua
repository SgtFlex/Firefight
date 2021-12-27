include("shared.lua")
ENT.IconMat = Material( "icons/sprint" )

local function DrawIcon(pos, ang, scale, icon)
    cam.Start3D2D( pos, ang, scale )
		-- Actually draw the text. Customize this to your liking.
        surface.SetMaterial(icon)
        surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRectRotated(0, 0, 32, 32, 0)
	cam.End3D2D()
end

function ENT:Draw()
	-- Draw the model
	self:DrawModel()

	-- The text to display

	-- The position. We use model bounds to make the text appear just above the model. Customize this to your liking.
	local mins, maxs = self:GetModelBounds()
	local pos = self:GetPos() + Vector( 0, 0, maxs.z + 2 )

    local angle = (LocalPlayer():EyePos() - self:GetPos()):GetNormalized():Angle()
    angle:RotateAroundAxis( angle:Up(), 90 )
	angle:RotateAroundAxis( angle:Forward(), 90 )
    DrawIcon(self:GetAttachment(self:LookupAttachment("holo_icon"))["Pos"], angle, 1, self.IconMat)
end

local EquipmentPanel = {}
local pos = {x = ScrW()*.1, y = ScrH()*.85}
local size = {w = ScrW()*.1, h = ScrH()*.1}
local bar = Material( "models/wireframe" )

function EquipmentPanel:Init()    
	self:SetPos(pos.x, pos.y)
	self:SetSize(size.w, size.h)
end

function EquipmentPanel:Paint( width, height )
	pos.x = ScrW()*.1
	pos.y = ScrH()*.85
	size.w = width
	size.h = height
	self:SetPos(pos.x, pos.y)
	self:SetSize(size.w, size.h)

	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(bar)
	surface.DrawTexturedRect(size.w*.05 + 4, size.h*.5, 128, 24)

	surface.SetDrawColor(0, 200, 255, 255)
	surface.SetMaterial(bar)
	surface.DrawTexturedRect(size.w*.05 + 4, size.h*.5, 128*(self.ResourceCur/self.ResourceMax), 24)
end

vgui.Register( "EquipmentPanel", EquipmentPanel, "Panel" )


net.Receive("AddEquipmentIcon", function()
	print("Added the equipment icon")
	EquipmentPanel = vgui.Create("EquipmentPanel", parentpanel)
end)