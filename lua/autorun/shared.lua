game.AddParticles("particles/halo_particles.pcf")
PrecacheParticleSystem("Gravity_Lift")

if SERVER then
    AddCSLuaFile("client/cl_init.lua")
end