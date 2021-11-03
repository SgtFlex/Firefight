
local AmmoPanel = {}
local pos = {x = ScrW()*.75, y = ScrH()*.1}
local size = {w = ScrW()*.15, h = ScrH()*.3}
local ply = LocalPlayer()


local columnMax = 10
local rowMax = 3
local rowBreak = 15
local primWep = ply:GetActiveWeapon()
local primWepMat = nil
local secWep = ply:GetPreviousWeapon()
local secWepMat = nil
local bulletMat = Material("hud/bullet_icon")
local bulletSize = {x = 10, y = 20}
local bulletSpacing = 5


hook.Add("Think", "MyIdentifier", function()
    if (ply:GetActiveWeapon()!=nil and ply:GetActiveWeapon().WepSelectIcon!=nil) then
        primWep = ply:GetActiveWeapon()
        primWepMat = Material(primWep.WepSelectIcon)
    end
    if (ply:GetPreviousWeapon()!=nil and ply:GetPreviousWeapon().WepSelectIcon!=nil) then
        secWep = ply:GetPreviousWeapon()
        secWepMat = Material(secWep.WepSelectIcon) --Need to find the hooks that allow us to change this
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

function AmmoPanel:DrawBullets()
    if (!primWep) then return end
    surface.SetMaterial(bulletMat)
    
    local maxRow = 1
    if (ply:GetActiveWeapon():GetMaxClip1() > 15) then
        maxRow = GetLowestDivisor(ply:GetActiveWeapon():GetMaxClip1())
    end
    bulletSize.x = 10*(15/math.min(15, primWep:GetMaxClip1()))
    bulletSize.y = 20*(15/math.min(15, primWep:GetMaxClip1()))

    --Draw the outline
    surface.SetDrawColor(0, 0, 0, 150)
    for col = 1, primWep:GetMaxClip1() do
        surface.DrawTexturedRect(size.w*0.2 + col*(bulletSpacing+bulletSize.x), size.h*0.5 + 1*25, bulletSize.x, bulletSize.y)
    end
    --Draw the fill
    surface.SetDrawColor(0, 255, 255, 150)
    for col = 1, primWep:Clip1() do
        for row = 1, primWep:Clip1() do

        end
        surface.DrawTexturedRect(size.w*0.2 + col*(bulletSpacing+bulletSize.x), size.h*0.5 + 1*25, bulletSize.x, bulletSize.y)
    end
end

function AmmoPanel:DrawPrimaryInfo()
    if (!primWep or !primWepMat) then return end
    --Draw primary weapon info
    surface.SetFont("ChatFont")
    surface.SetTextPos( size.w*.65, size.h*.3 ) 
    surface.SetTextColor(0, 200, 255)
    surface.DrawText(ply:GetAmmoCount(primWep:GetPrimaryAmmoType()))
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(primWepMat)
    surface.DrawTexturedRect(size.w*0.2, size.h*0.1, size.w/1.5, size.h/1.5)
end

function AmmoPanel:DrawSecondaryInfo()
    if (!secWep or !secWepMat) then return end
    --Draw secondary weapon info
    surface.SetFont("ChatFont")
    surface.SetTextPos( size.w*.8, size.h*0.1 ) 
    surface.SetTextColor(0, 200, 255)
    surface.DrawText(ply:GetAmmoCount(secWep:GetPrimaryAmmoType()))
    surface.SetMaterial(secWepMat)
    surface.DrawTexturedRect(size.w*0.5, size.h*0.02, size.w/2.5, size.h/3)
end

vgui.Register( "AmmoPanel", AmmoPanel, "Panel" )

