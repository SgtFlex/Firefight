ENT.Type = "anim"
ENT.Base = "obj_ff_equipment_base"
ENT.Category = "Halo Equipment"
ENT.Author = "Sgt Flexxx"
ENT.Contact = "https://steamcommunity.com/id/sgtflexxx/"
ENT.Purpose = "To cloak the user."
ENT.Instructions = "Press the activate key to cloak the user. Press the activate key again to decloak the user."
ENT.Spawnable = true
ENT.PrintName = "Active Camo Equipment"

ENT.ConVarName = "active_camo"
ENT.IconMat = Material( "icons/active_camo" )
ENT.RenderGroup = RENDERGROUP_BOTH

if (CLIENT) then
    net.Receive("Cloak", function()
        local viewmodel = LocalPlayer():GetViewModel(0)
        local hands = LocalPlayer():GetHands()
        if (net.ReadBool()==true) then
            viewmodel.oldMat = viewmodel:GetMaterial()
            hands.oldMat = hands:GetMaterial()
            viewmodel:SetMaterial("effects/spv3/cloak")
            hands:SetMaterial("effects/spv3/cloak")
        else
            viewmodel:SetMaterial(viewmodel.oldMat)
            hands:SetMaterial(hands.oldMat)
        end
    end)
end