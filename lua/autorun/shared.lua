game.AddParticles("particles/halo_particles.pcf")
PrecacheParticleSystem("Gravity_Lift")


local ConVar_Tbl = include("includes/convars.lua")

-- for nodeName, nodeInfo in pairs(ConVar_Tbl) do
--     for _, control in pairs(nodeInfo["controls"]) do
--         CreateConVar(control["convar"], control["default"], FCVAR_ARCHIVE, control["desc"])
--     end
-- end


function SetupDefaultConvars(tbl_nodes)
	for k, node in pairs(tbl_nodes) do
        if (node["controls"]!=nil) then
            for j, control in pairs(node["controls"]) do
                if (control["convar"]!=nil) then
                    CreateConVar(control["convar"], control["default"], FCVAR_ARCHIVE, control["desc"])
                end
            end
        end
        if (node["subtree"]!=nil) then
            SetupDefaultConvars(node["subtree"])
        end
	end
end

SetupDefaultConvars(ConVar_Tbl)

concommand.Add("settings_panel", function(ply)
    net.Start("SettingsPanel")
    net.Send(ply)
end)

hook.Add("PlayerSay", "settings_panel", function(sender, text, teamChat)
    if (text=="!settings_panel") then
        sender:ConCommand("settings_panel")
        return ""
    end
end)

if SERVER then
    util.AddNetworkString("SettingsPanel")
    AddCSLuaFile("client/cl_init.lua")
end