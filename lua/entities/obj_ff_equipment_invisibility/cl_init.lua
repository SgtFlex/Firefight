include( "shared.lua" )

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