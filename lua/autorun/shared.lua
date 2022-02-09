game.AddParticles("particles/halo_particles.pcf")
PrecacheParticleSystem("Gravity_Lift")


local ConVar_Tbl = include("includes/convars.lua")

for equipName, equipConvars in pairs(ConVar_Tbl) do
    for _, equipConvar in pairs(equipConvars) do
        CreateConVar(equipConvar["convar"], equipConvar["default"], FCVAR_ARCHIVE, equipConvar["tooltip"])
    end
end

concommand.Add("h_equip_settings", function(ply)
    net.Start("HaloEquipmentMsg")
    net.Send(ply)
end)

hook.Add("PlayerSay", "swc_settings_chat", function(sender, text, teamChat)
    if (text=="!h_equip_settings") then
        sender:ConCommand("h_equip_settings")
        return ""
    end
end)

if SERVER then
    util.AddNetworkString("HaloEquipmentMsg")
    AddCSLuaFile("client/cl_init.lua")
end