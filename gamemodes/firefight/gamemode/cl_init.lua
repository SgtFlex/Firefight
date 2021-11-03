include( "shared.lua" )
include ("hud/cl_infopanel.lua")
include ("hud/cl_healthbar.lua")
include ("hud/cl_ammopanel.lua")

local ourMat = Material( "hud/hud_marker" )
local markedEnts = {}
local ply = LocalPlayer()


--Panels are CONTAINERS for surface/draw elements, so we should be incorporating that instead of using
--random coordinates all over the screen hoping everything lines up (which it won't on different resolutions)

hook.Add("HUDPaint", "DrawHUDMarkers", function()
    for k, v in ipairs( markedEnts ) do
        if (!IsValid(v[1])) then table.remove(markedEnts, k) break end
        local point = v[1]:GetPos() + v[1]:OBBCenter()*3 -- Gets the position of the entity, specifically the center
        local data2D = point:ToScreen() -- Gets the position of the entity on your screen
        data2D.x = math.Clamp(data2D.x, 0 + (ScrW()*0.05) , ScrW() - (ScrW()*0.05))
        data2D.y = math.Clamp(data2D.y, 0 + (ScrH()*0.05), ScrH() - (ScrH()*0.05))
        
        -- The position is not visible from our screen, don't draw and continue onto the next prop


        -- Draw a simple text over where the prop is
        
        surface.SetAlphaMultiplier(0.5)
        surface.SetFont("ChatFont")
        if (data2D.x > ((ScrW()/2) - 100) and  data2D.x < ((ScrW()/2) + 100)) and 
        (data2D.y > ((ScrH()/2) - 100) and  data2D.y < ((ScrH()/2) + 100)) then
            surface.SetTextPos( data2D.x + 50, data2D.y + 5 ) 
            surface.SetTextColor(255, 255, 255, 255)
            surface.DrawText(v[2])
            surface.SetAlphaMultiplier(0.75)
        end
        
        surface.SetTextPos( data2D.x + 50, data2D.y + 25 ) 
        surface.SetTextColor(v[4])
        surface.DrawText(tostring(math.Round(LocalPlayer():GetPos():DistToSqr(v[1]:GetPos())/10000)).."u")
       
        surface.SetMaterial(v[3]) -- Use our cached material
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawTexturedRect( data2D.x, data2D.y, 48, 48 ) -- Actually draw the rectangle
    end
end)

hook.Add("HUDPaint", "DrawMapName", function()
    if (curSet==nil or maxSet==nil) then maxSet = -1 curSet = -1 return end
    surface.SetFont("ChatFont")
    surface.SetTextPos( ScrW()*.1, ScrH()*.93 ) 
    surface.SetTextColor(0, 200, 255)
    surface.DrawText(game.GetMap())
end)

function GetLowestDivisor(number)
    if (number%2==0) then
        return 2
    end

    for i=3,  math.sqrt(number) do
        if (number%i==0) then
            return i
        end
    end
    return number
end

function AddToDisplayList(ent, displayName, icon, textColor)
    print(tostring(ent))
    if (!table.HasValue(markedEnts, ent)) then
        table.insert(markedEnts, {ent, displayName, Material(icon), textColor})
        print(tostring(ent).." added")
    end
end

function RemoveFromDisplayList(ent)
    for k, v in pairs(markedEnts) do
        if (v[1] == ent) then
            print("Removed!")
            table.remove(markedEnts, k)
            break
        end
    end
end

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

net.Receive("DisplayListAdd", function()
    local table = net.ReadTable()
    AddToDisplayList(table[1], table[2], table[3], table[4])
end)

net.Receive("DisplayListRemove", function()
    RemoveFromDisplayList(net.ReadEntity())
end)





--useful hooks to use
--PlayerAmmoChanged


hook.Add("InitPostEntity", "PlayerLoaded", function()
    ply = LocalPlayer()
    infoPanel = vgui.Create( "FirefightInfoPanel", parentpanel )
    healthPanel = vgui.Create("HealthPanel", parentpanel)
    ammoPanel = vgui.Create("AmmoPanel", parentpanel)
end)

hook.Add("OnReloaded", "HotReloaded", function()
    if (infoPanel) then infoPanel:Remove() end
    if (healthPanel) then healthPanel:Remove() end
    if (ammoPanel) then ammoPanel:Remove() end
    ply = LocalPlayer()
    infoPanel = vgui.Create( "FirefightInfoPanel", parentpanel )
    healthPanel = vgui.Create("HealthPanel", parentpanel)
    ammoPanel = vgui.Create("AmmoPanel", parentpanel)
    print("HUD hot reloaded")
end)