
local AmmoPanel = {}
local pos = {x = ScrW()*.75, y = ScrH()*.1}
local size = {w = ScrW()*.15, h = ScrH()*.3}
local ply = nil


local columnMax = 10
local rowMax = 3
local rowBreak = 15
local primWep = nil
local primWepMat = nil
local secWep = nil
local secWepMat = nil
local backupMat = Material( "models/wireframe" )
local bulletMat = Material("hud/bullet_icon")
local bulletSize = {x = 10, y = 20}
local bulletSpacing = 5


hook.Add("Think", "GetPlayerWeapons", function()
    ply = LocalPlayer()
    if (ply:GetActiveWeapon()!=nil) then
        primWep = ply:GetActiveWeapon()
        if (ply:GetActiveWeapon().WepSelectIcon!=nil) then
            primWepMat = tonumber(primWep.WepSelectIcon)
        else
            primWepMat = backupMat
        end
    end
    if (ply:GetPreviousWeapon()!=nil) then
        secWep = ply:GetPreviousWeapon()
        if (ply:GetPreviousWeapon().WepSelectIcon!=nil) then
            secWepMat = tonumber(secWep.WepSelectIcon) --Need to find the hooks that allow us to change this
        else
            secWepMat = backupMat
        end
    end
end)


function AmmoPanel:Init()    
    self:SetPos(pos.x, pos.y)
    self:SetSize(size.w, size.h)
    ply = LocalPlayer()
    primWep = ply:GetActiveWeapon()
end


function AmmoPanel:Paint( width, height )
    pos.x = ScrW()*.75
    pos.y = ScrH()*.1
    size.w = width
    size.h = height
    self:SetPos(pos.x, pos.y)
    self:SetSize(size.w, size.h)
    self:DrawPrimaryInfo()
    self:DrawSecondaryInfo()
    self:DrawBullets()
    --draw.RoundedBox( 0, 0, 0, size.w, size.h, Color(0,0,0,50))
end

local rowMax = 5
function AmmoPanel:DrawBullets() --Should look into if we can make this more efficient later
    if (!primWep or !IsValid(primWep)) then return end
    surface.SetMaterial(bulletMat)

    local maxClip = primWep:GetMaxClip1()
    local cols = GetColumnMax(maxClip)
    local rows = maxClip/cols
    local bulLeft = primWep:Clip1()
    
    
    bulletSize.x = 10*(15/math.min(15, cols))
    bulletSize.y = 20*(15/math.min(15, cols)) 
    if (rows > 4) then
        bulletSize.y = bulletSize.y * (3/rows) --start scaling down the y past 5 rows
    end
    
    bulletSpacing = 5 * (15/math.min(15, cols))

    --Drawing of the bullets
    surface.SetDrawColor(0, 255, 255, 150)
    for row = 1, rows do
        for col = 1, cols do
            if (bulLeft <= 0) then
                surface.SetDrawColor(0, 0, 0, 150) --Draw the empty bullets as black silhouttes
            end
            bulLeft = bulLeft-1
            
            surface.DrawTexturedRect(size.w*0.2 - bulletSize.x + col*(bulletSpacing+bulletSize.x), size.h*0.5 - bulletSize.y + row*(bulletSpacing+bulletSize.y), bulletSize.x, bulletSize.y)
        end
    end
end

local colMax = 15
function GetColumnMax(number)
    for k = colMax, 1, -1 do
        if (number%k==0) then
            return k
        end
    end
    return colMax
end

function AmmoPanel:DrawPrimaryInfo()
    if (!primWep or !IsValid(primWep)) then return end
    --Draw primary weapon info
    surface.SetFont("ChatFont")
    surface.SetTextPos( size.w*.65, size.h*.3 ) 
    surface.SetTextColor(0, 200, 255, 200)
    surface.DrawText(ply:GetAmmoCount(primWep:GetPrimaryAmmoType()))
    
    if (isnumber(primWepMat)) then --Draw the image
        surface.SetDrawColor(0, 200, 255, 200)
        --surface.SetMaterial(primWepMat)
        surface.SetTexture(primWepMat)
        surface.DrawTexturedRect(size.w*0.2, size.h*0.1, size.w/2, size.h/3)
    end
end

function AmmoPanel:DrawSecondaryInfo()
    if (!secWep  or !IsValid(secWep)) then return end
    --Draw secondary weapon info
    surface.SetFont("ChatFont")
    surface.SetTextPos( size.w*.8, size.h*0.1 ) 
    surface.SetTextColor(0, 200, 255, 200)
    surface.DrawText(ply:GetAmmoCount(secWep:GetPrimaryAmmoType()))
    
    if (isnumber(secWepMat)) then
        surface.SetDrawColor(0, 200, 255, 200)
        --surface.SetMaterial(secWepMat)
        surface.SetTexture(secWepMat)
        surface.DrawTexturedRect(size.w*0.5, size.h*0.02, size.w/3, size.h/4)
    end
end

vgui.Register( "AmmoPanel", AmmoPanel, "Panel" )

