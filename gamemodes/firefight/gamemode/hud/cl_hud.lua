include ("cl_infopanel.lua")
include ("cl_healthpanel.lua")
include ("cl_ammopanel.lua")
include ("cl_markerpanel.lua")


local ply = LocalPlayer()
--Panels are CONTAINERS for surface/draw elements, so we should be incorporating that instead of using
--random coordinates all over the screen hoping everything lines up (which it won't on different resolutions)

hook.Add("HUDPaint", "DrawMapName", function()
    surface.SetFont("ChatFont")
    surface.SetTextPos( ScrW()*.1, ScrH()*.93 ) 
    surface.SetTextColor(0, 200, 255)
    surface.DrawText(game.GetMap())
end)



local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then
		return false
	end

	-- Don't return anything here, it may break other addons that rely on this hook.
end )

hook.Add("ClientSignOnStateChanged", "PlayerLoaded", function(userID, oldState, newState)
    if (newState!=SIGNONSTATE_FULL) then return end
    print("player fully loaded")
    ply = LocalPlayer()
    infoPanel = vgui.Create( "FirefightInfoPanel", parentpanel )
    healthPanel = vgui.Create("HealthPanel", parentpanel)
    ammoPanel = vgui.Create("AmmoPanel", parentpanel)
    markerPanel = vgui.Create("MarkerPanel", parentpanel)
end)

hook.Add("OnReloaded", "HotReloaded", function()
    if (infoPanel) then infoPanel:Remove() end
    if (healthPanel) then healthPanel:Remove() end
    if (ammoPanel) then ammoPanel:Remove() end
    if (markerPanel) then markerPanel:Remove() end
    ply = LocalPlayer()
    infoPanel = vgui.Create( "FirefightInfoPanel", parentpanel )
    healthPanel = vgui.Create("HealthPanel", parentpanel)
    ammoPanel = vgui.Create("AmmoPanel", parentpanel)
    markerPanel = vgui.Create("MarkerPanel", parentpanel)
    print("HUD hot reloaded")
end)