
local HealthPanel = {}
local size = {w = ScrW()*.3, h = ScrH()*.2}
local pos = {x = ScrW()/2 - size.w/2, y = 0}

local sOMat = Material( "hud/shieldBar_outline" )
local sFMat = Material( "hud/shieldBar_fill" )
local hOMat = Material( "hud/healthBar_outline" )
local hFMat = Material( "hud/healthBar_fill" )





function HealthPanel:Init()
    self:SetSize(size.w, size.h )
    self:SetPos(pos.x, pos.y)    
end

function HealthPanel:Paint( w, h )
    if (LocalPlayer()==nil) then return end
    self:DrawShields()
    self:DrawHealth()
    --draw.RoundedBox(0, 0, 0, size.w, size.h, Color(0,0,0,100))
end


function HealthPanel:DrawShields(w, h)
    if (LocalPlayer()==nil) then return end
    --Draw the fill
    local shieldPerc = LocalPlayer():Armor()/LocalPlayer():GetMaxArmor()
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.SetAlphaMultiplier(0.75)
    surface.SetMaterial(sFMat) -- Use our cached material
    surface.DrawTexturedRectUV( size.w/2, 0, size.w/2*(shieldPerc), size.h, 0, 0, 1*(shieldPerc), 1 )
    surface.DrawTexturedRectUV( size.w/2 - size.w/2*(shieldPerc), 0, size.w/2*(shieldPerc), size.h, 1*(shieldPerc), 0, 0, 1 )
    --Draw the outline
    surface.SetMaterial(sOMat) -- Use our cached material
    surface.DrawTexturedRectUV( size.w/2, 0, size.w/2, size.h, 0, 0, 1, 1 )
    surface.DrawTexturedRectUV( 0, 0, size.w/2, size.h, 1, 0, 0, 1 )
end

function HealthPanel:DrawHealth(w, h)
    if (LocalPlayer()==nil) then return end
    --Draw the fill
    local healthPerc = (LocalPlayer():Health()/LocalPlayer():GetMaxHealth())*0.7 --This doesn't seem to work unless we have 0.7 or lower... why?
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.SetAlphaMultiplier(0.75)
    surface.SetMaterial(hFMat) -- Use our cached material
    surface.DrawTexturedRectUV( size.w/2, 0, size.w/2*(healthPerc), size.h, 0, 0, 1*(healthPerc), 1 )
    surface.DrawTexturedRectUV( size.w/2 - size.w/2*(healthPerc), 0, size.w/2*(healthPerc), size.h, 1*(healthPerc), 0, 0, 1 )
    --Draw the outline
    surface.SetMaterial(hOMat) -- Use our cached material
    surface.DrawTexturedRectUV( size.w/2, 0, size.w/2, size.h, 0, 0, 1, 1 )
    surface.DrawTexturedRectUV( 0, 0, size.w/2, size.h, 1, 0, 0, 1 )
end

vgui.Register( "HealthPanel", HealthPanel, "Panel" )

