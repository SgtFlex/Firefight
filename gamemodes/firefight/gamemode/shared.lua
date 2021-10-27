GM.Name = "Firefight"
GM.Author = "Sgt Flexxx"
GM.Email = "N/A"
GM.Website = "N/A"

local maxSets = 3
local currentSet = 0
local maxReinforcements = 3
local currentReinforcement = 0
local allNPCs = {
	{Unit = "npc_vj_halo_cov_spv3_grunt_min", Cost = 1},
	{Unit = "npc_vj_halo_cov_spv3_grunt_maj", Cost = 2},
	{Unit = "npc_vj_halo_cov_spv3_grunt_spc", Cost = 4},
	{Unit = "npc_vj_halo_cov_spv3_grunt_ult", Cost = 6},

}
local Reinforcements = {
	"npc_vj_halo_cov_spv3_grunt_min",
	"npc_vj_halo_cov_spv3_grunt_min",
	"npc_vj_halo_cov_spv3_grunt_min",
	"npc_vj_halo_cov_spv3_grunt_min",
	"npc_vj_halo_cov_spv3_grunt_maj",
}
local AliveReinforcements = {}
local StartedReinforcement = false
local allHealthPacks = {}
local setStarted = false
local OrdnanceWeapons = {
	"drc_srs99am",
	"drc_spnkr",
	"drc_m45",
	"drc_splaser",
	"drc_m139",
	"drc_m739",
}
local playerLives = 7
local startReinfStrength = 10
local currentReinfStrength = startReinfStrength


function GM:Initialize()
	timer.Simple(10, function()
		StartGame()
	end)
end

function GM:PlayerSpawn(player)
	player:Give("drc_dmr")
	player:SetWalkSpeed(175)
	player:SetRunSpeed(300)
	player:SetGravity(0.5)
	player:SetJumpPower(320)
	player:SetMaxHealth(100)
	player:SetupHands()
end

function StartGame()
	if SERVER then
		PrintMessage(3, "Starting game")
		local weaponBox = ents.Create("obj_ff_weaponBox")
		weaponBox:SetPos(Vector(0,0,0))
		weaponBox:Spawn()
		for i = 1, 4 do
			local healthPack = ents.Create("obj_ff_healthPack")
			healthPack:SetPos(Vector(math.random(-50, 50), math.random(-50, 50), 0))
			healthPack:Spawn()
			table.insert(allHealthPacks, healthPack)
		end
		StartSet()
	end
end


function StartSet()
	if SERVER then
		if (currentSet >= maxSets) then
			FinishGame(true)
			return
		end
		for k,v in pairs(ents.FindByClass("prop_ragdoll")) do
			v:Remove()
		end
		for k, v in pairs(allHealthPacks) do
			v:SetUsable(true)
		end
		currentSet = currentSet + 1
		currentReinforcement = 0
		PrintMessage(3, "Set Start: "..currentSet)
		OrdananceDrop()
		timer.Simple(10, function()
			setStarted = true
			StartReinforcement()
		end)
	end
end

function EndSet()
	setStarted = false	
	PrintMessage(3, "Set Completed")
	timer.Simple(10, function() 
		StartSet()
	end)
end



function StartReinforcement()
	if SERVER then
		if (setStarted == false) then return end
		if (currentReinforcement >= maxReinforcements) then
			EndSet()
			return
		end
		currentReinforcement = currentReinforcement + 1
		PrintMessage(3, "Reinforcements. Wave: "..currentReinforcement)
		StartedReinforcement = true
		timer.Simple(5, function()
			for k, v in pairs(Reinforcements) do
				local npc = ents.Create(v)
				npc:SetPos(Vector(math.random(-100, 100), math.random(-100, 100), 0))
				npc:Spawn()
				local weaponTable = list.Get("NPC")[npc:GetClass()].Weapons
				npc:Give(weaponTable[math.random(1, #weaponTable)])
				npc:SetCollisionGroup(3)
				table.insert(AliveReinforcements, npc)
			end
			StartedReinforcement = false
		end)
	end
end



function OrdananceDrop()
	if (SERVER) then
		PrintMessage(3, "Ordnance Drop")
		local players = ents.FindByClass("player")
		for i = 1, 2 do
			local weapon = ents.Create(OrdnanceWeapons[math.random(1, #OrdnanceWeapons)])
			weapon:SetPos(Vector(0,0,0))
			weapon:Spawn()
		end
	end
end

function GM:EntityRemoved(ent)
	if (table.HasValue(AliveReinforcements, ent)) then
		table.RemoveByValue(AliveReinforcements, ent)
	end
	if (#AliveReinforcements <= (#Reinforcements*0.2) && StartedReinforcement==false) then
		StartReinforcement()
	end
end

function FinishGame(bVictory)
	if (bVictory) then
		PrintMessage(3, "Game Won!")
	else
		PrintMessage(3, "Game Over.")
	end
end


function GM:PlayerDeath(victim, inflictor, attacker)
	playerLives = playerLives - 1
	PrintMessage(3, tostring(playerLives).." lives left.")
	if (playerLives < 0) then
		FinishGame(false)
	end
end