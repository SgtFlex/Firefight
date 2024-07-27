CreateClientConVar("halo_hud", 1, true, false, "Enables/disables Flex's halo hud")
if (GetConVar("halo_hud"):GetInt()==0) then return end
include ("hud/cl_hud.lua") 

