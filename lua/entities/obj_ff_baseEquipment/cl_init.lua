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
