ENT.Type = "anim"
ENT.Base = "obj_ff_equipment_base"
ENT.Category = "Halo Equipment"
ENT.Author = "Sgt Flexxx"
ENT.Contact = "https://steamcommunity.com/id/sgtflexxx/"
ENT.Purpose = "To give the user Invisibility."
ENT.Instructions = "Press the activate key to be temporarily invisible."
ENT.Spawnable = true
ENT.PrintName = "Invisibility Equipment"

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