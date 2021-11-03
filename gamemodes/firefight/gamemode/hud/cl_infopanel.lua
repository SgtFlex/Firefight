
local InfoCorner = {}
local pos = {x = ScrW()*.85, y = ScrH()*.85}
local size = {w = ScrW()*.1, h = ScrH()*.1}

local livesIcon = Material("hud/lives_icon")






function InfoCorner:Init()    
    self:SetPos(pos.x, pos.y)
    self:SetSize(size.w, size.h)
end


function InfoCorner:Paint( width, height )
    pos.x = ScrW()*.85
    pos.y = ScrH()*.85
    size.w = width
    size.h = height
    self:SetPos(pos.x, pos.y)
    self:SetSize(size.w, size.h)

    self:DrawTime()
    self:DrawGamemodeName()
    self:DrawSets()
    self:DrawReinforcements()
    self:DrawLives()
    self:DrawLines()
    --draw.RoundedBox( 0, 0, 0, size.w, size.h, Color(0,0,0,50))
end

function InfoCorner:DrawReinforcements()
    if (!curReinf or !maxReinfl) then curReinf = -1 maxReinf = -1 end
    surface.SetFont("ChatFont")
    surface.SetTextPos( size.w*.2, size.h*.65 ) 
    surface.SetTextColor(0, 200, 255)
    surface.DrawText("Wave: "..curReinf.."/"..maxReinf)
end

function InfoCorner:DrawLives()
    if (livesLeft==nil) then livesLeft = -1 end
    surface.SetFont("ChatFont")
    surface.SetTextPos( size.w*.05, size.h*.3 ) 
    surface.SetTextColor(0, 200, 255)
    if livesLeft==-1 then
        surface.DrawText("∞")
    else
        surface.DrawText(livesLeft)
    end
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(livesIcon)
    surface.DrawTexturedRect(size.w*.05 + 4, size.h*.5, 12, 24)
end

function InfoCorner:DrawSets()
    if (curSet==nil or maxSet==nil) then maxSet = -1 curSet = -1 end
    surface.SetFont("ChatFont")
    surface.SetTextPos( size.w*.2, size.h*.45 ) 
    surface.SetTextColor(0, 200, 255)
    surface.DrawText("Set: "..curSet.."/"..maxSet)
end

function InfoCorner:DrawGamemodeName()
    surface.SetFont("ChatFont")
    surface.SetTextPos( size.w*.2, size.h*.25 ) 
    surface.SetTextColor(0, 200, 255)
    local gameName = engine.ActiveGamemode()
    surface.DrawText(gameName)
end

function InfoCorner:DrawTime()
    surface.SetFont("ChatFont")
    surface.SetTextPos( size.w*.65, 0 ) 
    surface.SetTextColor(0, 200, 255)
    surface.DrawText(math.floor((CurTime()/60))..":"..(math.floor(CurTime())%60))
end

function InfoCorner:DrawLines()
    surface.DrawLine( size.w*.15, size.h*.2, size.w*.15, size.h )
    surface.DrawLine(size.w*.15, size.h*.2 , size.w, size.h*.2)
end

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


vgui.Register( "FirefightInfoPanel", InfoCorner, "Panel" )

