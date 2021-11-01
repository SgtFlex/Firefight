include( "shared.lua" )
local ourMat = Material( "hud/hud_marker" )
local markedEnts = {
}
local ply = LocalPlayer()
local curSet = nil
local maxSet = nil
local curReinf = nil
local maxReinf = nil
local livesLeft = nil

hook.Add("InitPostEntity", "PlayerLoaded", function()
    ply = LocalPlayer()
end)

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

local hOMat = Material( "hud/healthBar_outline" )
local hFMat = Material( "hud/healthBar_fill" )
local hSize = {x = 500, y = 400}
local barPos = {x = ScrW()/2, y = 0}
hook.Add("HUDPaint", "DrawHealthBar", function()
    if (ply==nil) then return end
    --Draw the fill
    local healthPerc = (ply:Health()/ply:GetMaxHealth())*0.7 --This doesn't seem to work unless we have 0.7 or lower... why?
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.SetAlphaMultiplier(0.75)
    surface.SetMaterial(hFMat) -- Use our cached material
    surface.DrawTexturedRectUV( barPos.x, barPos.y, hSize.x*(healthPerc), hSize.y, 0, 0, 1*(healthPerc), 1 )
    surface.DrawTexturedRectUV( barPos.x - hSize.x*(healthPerc), barPos.y, hSize.x*(healthPerc), hSize.y, healthPerc, 0, 0, 1 )
    --Draw the outline
    surface.SetMaterial(hOMat) -- Use our cached material
    surface.DrawTexturedRectUV( barPos.x, barPos.y, hSize.x, hSize.y, 0, 0, 1, 1 )
    surface.DrawTexturedRectUV( barPos.x - hSize.x, barPos.y, hSize.x, hSize.y, 1, 0, 0, 1 )
end)

local sOMat = Material( "hud/shieldBar_outline" )
local sFMat = Material( "hud/shieldBar_fill" )
hook.Add("HUDPaint", "DrawShieldBar", function()
    if (ply==nil) then return end
    --Draw the fill
    local shieldPerc = ply:Armor()/ply:GetMaxArmor()
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.SetAlphaMultiplier(0.75)
    surface.SetMaterial(sFMat) -- Use our cached material
    surface.DrawTexturedRectUV( barPos.x, barPos.y, hSize.x*(shieldPerc), hSize.y, 0, 0, 1*(shieldPerc), 1 )
    surface.DrawTexturedRectUV( barPos.x - hSize.x*(shieldPerc), barPos.y, hSize.x*(shieldPerc), hSize.y, shieldPerc, 0, 0, 1 )
    --Draw the outline
    surface.SetMaterial(sOMat) -- Use our cached material
    surface.DrawTexturedRectUV( barPos.x, barPos.y, hSize.x, hSize.y, 0, 0, 1, 1 )
    surface.DrawTexturedRectUV( barPos.x - hSize.x, barPos.y, hSize.x, hSize.y, 1, 0, 0, 1 )
end)

hook.Add("HUDPaint", "DrawTime", function()
    surface.SetFont("ChatFont")
    surface.SetTextPos( ScrW()*.957, ScrH()*.885 ) 
    surface.SetTextColor(0, 200, 255)
    surface.DrawText(math.floor((CurTime()/60))..":"..(math.floor(CurTime())%60))
end)

hook.Add("HUDPaint", "DrawGamemodeName", function()
    surface.SetFont("ChatFont")
    surface.SetTextPos( ScrW()*.9, ScrH()*.9 ) 
    surface.SetTextColor(0, 200, 255)
    surface.DrawText("FIREFIGHT CLASSIC")
end)

local livesIcon = Material("hud/lives_icon")
hook.Add("HUDPaint", "DrawLives", function()
    if (livesLeft==nil) then return end
    surface.SetFont("ChatFont")
    surface.SetTextPos( ScrW()*.89, ScrH()*.915 ) 
    surface.SetTextColor(0, 200, 255)
    if livesLeft==-1 then
        surface.DrawText("∞")
    else
        surface.DrawText(livesLeft)
    end
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(livesIcon)
    surface.DrawTexturedRect(ScrW()*.89, ScrH()*.93, 12, 24)
    surface.DrawLine( ScrW()*.897, ScrH()*.9, ScrW()*.897, ScrH()*.95 )
end)

hook.Add("HUDPaint", "DrawReinforcement", function()
    if (curReinf==nil or maxReinf==nil) then return end
    surface.SetFont("ChatFont")
    surface.SetTextPos( ScrW()*.9, ScrH()*.915 ) 
    surface.SetTextColor(0, 200, 255)
    surface.DrawText("Reinforcement: "..curReinf.."/"..maxReinf)
end)

hook.Add("HUDPaint", "DrawSet", function()
    if (curSet==nil or maxSet==nil) then return end
    surface.SetFont("ChatFont")
    surface.SetTextPos( ScrW()*.9, ScrH()*.93 ) 
    surface.SetTextColor(0, 200, 255)
    surface.DrawText("Set: "..curSet.."/"..maxSet)
end)

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

net.Receive("UpdateReinforcements", function()
    curReinf = net.ReadInt(10)
end)

net.Receive("UpdateSet", function()
    curSet = net.ReadInt(10)
end)

net.Receive("GameInfo", function()
    maxReinf = net.ReadInt(10)
    maxSet = net.ReadInt(10)
    livesLeft = net.ReadInt(8)
end)

net.Receive("UpdateLives", function()
    livesLeft = net.ReadInt(8)
end)