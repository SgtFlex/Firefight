include( "shared.lua" )
include ("entities/obj_ff_baseEquipment/cl_init.lua")

ENT.IconMat = Material( "icons/active_camo" )

net.Receive("Cloak", function()
    local viewmodel = LocalPlayer():GetViewModel(0)
    local hands = LocalPlayer():GetHands()
    if (net.ReadBool()==true) then
        print("cloak")
        viewmodel.oldMat = viewmodel:GetMaterial()
        hands.oldMat = hands:GetMaterial()
        viewmodel:SetMaterial("effects/spv3/cloak")
        hands:SetMaterial("effects/spv3/cloak")
    else
        print("uncloak")
        viewmodel:SetMaterial(viewmodel.oldMat)
        hands:SetMaterial(hands.oldMat)
    end
end)