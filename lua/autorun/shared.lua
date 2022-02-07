game.AddParticles("particles/halo_particles.pcf")
PrecacheParticleSystem("Gravity_Lift")


local ConVar_Tbl = include("includes/convars.lua")

for equipName, equipConvars in pairs(ConVar_Tbl) do
    for _, equipConvar in pairs(equipConvars) do
        CreateConVar(equipConvar["convar"], equipConvar["default"], FCVAR_ARCHIVE, equipConvar["tooltip"])
    end
end

if SERVER then
    AddCSLuaFile("client/cl_init.lua")
end