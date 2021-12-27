
local MarkerPanel = {}
local ScrBound = 0.1
local pos = {x = `, y = ScrH()*ScrBound}
local size = {w = ScrW() - pos.x*2, h = ScrH() - pos.y*2}
local ourMat = Material( "hud/hud_marker" )
local markedEnts = {}

function MarkerPanel:Init()    
    self:SetPos(pos.x, pos.y)
    self:SetSize(size.w, size.h)
end


function MarkerPanel:Paint( width, height )
    pos.x = ScrW()*ScrBound
    pos.y = ScrH()*ScrBound
    size.w = width
    size.h = height
    self:SetPos(pos.x, pos.y)
    self:SetSize(size.w, size.h)

    self:DrawMarkers()
    draw.RoundedBox(0, 0, 0, width, height, Color(0,0,0,30))
end

local iconSize = {x = 48, y = 48}
local offscreenMat = Material("hud/offscreen_marker")
function MarkerPanel:DrawMarkers()
    for k, v in ipairs( markedEnts ) do
        if (!IsValid(v[1])) then table.remove(markedEnts, k) break end
        local point = v[1]:GetPos() + v[1]:OBBCenter()*3 -- Gets the position of the entity, specifically the center
        
        local data2D = point:ToScreen() -- Gets the position of the entity on your screen
        data2D.x, data2D.y = self:ScreenToLocal(data2D.x, data2D.y)
        local data2DUnclamped = data2D
        data2D.x = math.Clamp(data2D.x, 0 , size.w - iconSize.x)
        data2D.y = math.Clamp(data2D.y, 0, size.h - iconSize.y)
        
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
        if (data2D.x <= 0 or data2D.x >= size.w - iconSize.x) or (data2D.y <= 0 or data2D.y >= size.h-iconSize.y) then
            surface.SetMaterial(offscreenMat)
            surface.SetDrawColor(v[4])
            --our x axis goes from left to right
            --however, our y axis is upside down, so it is up to down
            --also when using RotatedRectangles, origin is in center rather than bottom left so displace by IconSize/2
            surface.DrawTexturedRectRotated(data2D.x + iconSize.x/2, data2D.y + iconSize.y/2, iconSize.x, iconSize.y , math.atan2(data2D.y - data2DUnclamped.y, data2DUnclamped.x - data2D.x)*180*math.pi)
        else
            surface.SetMaterial(v[3]) -- Use our cached material
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.DrawTexturedRect( data2D.x, data2D.y, iconSize.x, iconSize.y ) -- Actually draw the rectangle
        end
    end
end

function AddToDisplayList(ent, displayName, icon, textColor)
    print(tostring(ent))
    if (!table.HasValue(markedEnts, ent)) then
        table.insert(markedEnts, {ent,displayName,Material(icon),textColor})
        print(tostring(ent).." added")
    end
end

function RemoveFromDisplayList(ent)
    print("To remove: "..tostring(ent))
    for k, v in pairs(markedEnts) do
        print(v.Entity)
        if (v[1] == ent) then
            print("Removed!")
            table.remove(markedEnts, k)
            break
        end
    end
end

net.Receive("DisplayListAdd", function()
    local table = net.ReadTable()
    AddToDisplayList(table[1], table[2], table[3], table[4])
end)

net.Receive("DisplayListRemove", function()
    RemoveFromDisplayList(net.ReadEntity())
    print("Received net message")
end)



vgui.Register( "MarkerPanel", MarkerPanel, "Panel" )

