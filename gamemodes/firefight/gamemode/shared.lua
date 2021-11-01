GM.Name = "Firefight"
GM.Author = "Sgt Flexxx"
GM.Email = "N/A"
GM.Website = "N/A"

local maxSets = 3
local currentSet = 0
local maxReinforcements = 3
local currentReinforcement = 0
local minSpawnRadius = 1000
local maxSpawnRadius = 1500
local ArmoryPos = nil

local EnemySpawn_Tbl = {
	FodderInfo = {
		Bank = 6,
		BankReinfMult = 1.2,
		NPCs = {
			{NPC = "npc_vj_halo_cov_spv3_grunt_min", Cost = 1},
			{NPC = "npc_vj_halo_cov_spv3_grunt_maj", Cost = 2},
			{NPC = "npc_vj_halo_cov_spv3_grunt_spc", Cost = 4},
			{NPC = "npc_vj_halo_cov_spv3_grunt_ult", Cost = 5},
		}
	},
	Fodder2Info = {
		Bank = 3,
		BankReinfMult = 1.3,
		NPCs = {
			{NPC = "npc_vj_halo_cov_spv3_jackal_min", Cost = 1},
			{NPC = "npc_vj_halo_cov_spv3_jackal_maj", Cost = 3},
			{NPC = "npc_vj_halo_cov_spv3_jackal_spc", Cost = 5},
		}
	},
	EliteInfo = {
		Bank = 3,
		BankReinfMult = 1.4,
		NPCs = {
			{NPC = "npc_vj_halo_cov_spv3_elite_min", Cost = 1},
			{NPC = "npc_vj_halo_cov_spv3_brute_min", Cost = 1},
			{NPC = "npc_vj_halo_cov_spv3_elite_maj", Cost = 2},
			{NPC = "npc_vj_halo_cov_spv3_brute_maj", Cost = 2},
		}
	},
	-- FloodInfo = {
	-- 	Bank = 50,
	-- 	BankReinfMult = 1.1,
	-- 	NPCs = {
	-- 		{NPC = "npc_vj_halo_flood_spv3_infection", Cost = 1},
	-- 	}
	-- },
}
local StartingBanks = {}


local StartReinforcements = {}
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
local StarterWeapons = {
	"drc_dmr",
}
local playerLives = 7
local startReinfStrength = 10
local currentReinfStrength = startReinfStrength

if (SERVER) then
	util.AddNetworkString("DisplayListAdd")
	util.AddNetworkString("DisplayListRemove")
	util.AddNetworkString("UpdateReinforcements")
	util.AddNetworkString("UpdateSet")
	util.AddNetworkString("UpdateLives")
	util.AddNetworkString("GameInfo")
end
function GM:Initialize()
	timer.Simple(10, function()
		StartGame()
	end)
end

function GM:PlayerSpawn(player)
	local startingWeapon = player:Give("drc_dmr")
	player:GiveAmmo(startingWeapon:GetMaxClip1()*3, startingWeapon:GetPrimaryAmmoType())
	player:SetWalkSpeed(175)
	player:SetRunSpeed(300)
	player:SetGravity(0.5)
	player:SetJumpPower(320)
	player:SetMaxHealth(100)
	player:SetModel( "models/player/odessa.mdl" )
	player:SetupHands() -- Create the hands and call GM:PlayerSetHandsModel
end

-- Choose the model for hands according to their player model.
function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

local ExposedSpots = {}
local HidingSpots = {}
local SpawnSpots = {}


local weaponBox
function StartGame()
	if SERVER then
		net.Start("GameInfo")
		net.WriteInt(maxReinforcements, 10)
		net.WriteInt(maxSets, 10)
		net.WriteInt(playerLives, 8)
		net.Broadcast()
		if (ArmoryPos==nil) then
			ArmoryPos = player.GetAll()[1]:GetPos() + Vector(100, 0, 0)
		end
		for k, v in pairs(navmesh.GetAllNavAreas()) do
			v:Draw()
			for i, j in pairs(v:GetExposedSpots()) do
				if (!v:IsClosed() and !v:IsUnderwater() and (v:GetSizeX() > 50 and v:GetSizeY() > 50)) then
					table.insert(ExposedSpots, j)
				end
			end
			for i,j in pairs(v:GetHidingSpots()) do
				if (!v:IsClosed() and !v:IsUnderwater() and (v:GetSizeX() > 50 and v:GetSizeY() > 50)) then
					table.insert(HidingSpots, v:GetCenter())
				end
			end
		end
		
		for i=1, #EnemySpawn_Tbl do
			StartingBanks[k] = EnemySpawn_Tbl[k]["Bank"]
		end
		PrintMessage(3, "Starting game")
		weaponBox = ents.Create("obj_ff_weaponBox")
		weaponBox:SetPos(ArmoryPos)
		weaponBox:Spawn()

		net.Start("DisplayListAdd")
		net.WriteTable({weaponBox, "AMMUNITION", "hud/ammo_marker", Color(0, 200, 255, 255)})
		net.Broadcast()

		for i = 1, 4 do
			local index = table.insert(allHealthPacks, ents.Create("obj_ff_healthPack"))
			allHealthPacks[index]:SetPos(Vector(math.random(-50, 50), math.random(-50, 50), 0) + ArmoryPos)
			allHealthPacks[index]:Spawn()
		end
		StartSet()
	end
end


function StartSet()
	if SERVER then
		currentSet = currentSet + 1
		currentReinforcement = 0
		PrintTable(ExposedSpots)
		net.Start("UpdateSet")
		net.WriteInt(currentSet, 10)
		net.Broadcast()
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
		
		PrintMessage(3, "Set Start: "..currentSet)
		OrdananceDrop()
		timer.Simple(10, function()
			setStarted = true
			StartReinforcement()
		end)
	end
end

function EndSet()
	for i=1, #EnemySpawn_Tbl do
		EnemySpawn_Tbl[k]["Bank"] = StartingBanks[k]
	end
	setStarted = false	
	PrintMessage(3, "Set Completed")
	timer.Simple(10, function() 
		StartSet()
	end)
end


local bank = nil
local maxCost = 1
function StartReinforcement()
	if SERVER then
		if (setStarted == false) then return end
		PrintMessage(3, "Reinforcements. Wave: "..currentReinforcement+1)
		StartedReinforcement = true
		net.Start("UpdateReinforcements")
		net.WriteInt(currentReinforcement+1, 10)
		net.Broadcast()
		for i=1, 8 do
			table.insert(SpawnSpots, GetSpawnablePosition())
		end
		timer.Simple(5, function()
			currentReinforcement = currentReinforcement + 1
			StartReinforcements = {}
			for k, v in pairs(AliveReinforcements) do
				table.insert(StartReinforcements, v) --Reset our StartReinforcements, but keep the alive members
			end
			for k, v in pairs(EnemySpawn_Tbl) do
				bank = v["Bank"]
				while (bank >= v["NPCs"][1]["Cost"]) do --Spawn as long as our bank is bigger than the smallest unit cost
					local chosenNPC = v["NPCs"][math.random(1, #v["NPCs"])]
					while chosenNPC["Cost"] > maxCost do --deplete the bank as much as we can
						chosenNPC = v["NPCs"][math.random(1, #v["NPCs"])]
					end
					local npc = ents.Create(chosenNPC["NPC"])
					

					npc:SetPos(GetSpawnablePosition())
					npc:Spawn()
					local weaponTable = list.Get("NPC")[npc:GetClass()].Weapons
					if (weaponTable!= nil and #weaponTable > 0) then
						npc:Give(weaponTable[math.random(1, #weaponTable)])
					end
					npc:SetCollisionGroup(3)
					table.insert(StartReinforcements, npc)
					table.insert(AliveReinforcements, npc)
					bank = bank - chosenNPC["Cost"]
				end
				v["Bank"] = v["Bank"] * v["BankReinfMult"]
			end
			maxCost = maxCost + 1
			StartedReinforcement = false
		end)
	end
end

local validPos = true
local LosTest
function GetSpawnablePosition()
	local position = nil
	local nearestNavArea
	repeat
		validPos = true
		for k, v in pairs(player.GetAll()) do
			repeat
				position = HidingSpots[math.random(1, #HidingSpots)]
			until position:Distance(v:GetPos()) < maxSpawnRadius
			LosTest = util.TraceLine({
				start = position + Vector(0,0,50),
				endpos = (v:GetPos() + v:OBBCenter()),
			})
			if (LosTest.Hit) then
				if (IsValid(LosTest.Entity) and LosTest.Entity:GetClass()=="player") then
					print("find another position")
					validPos = false
				end
			end
			debugoverlay.Line(position + Vector(0,0,50), v:GetPos() + v:OBBCenter(), 60, Color(255, 255, 255))
		end
	until (validPos==true)

	return position
end


local ordnancePod = nil
local startPosition = nil
local endPosition = nil
local trace = nil


function OrdananceDrop()
	if (SERVER) then
		PrintMessage(3, "Ordnance Drop")
		local players = ents.FindByClass("player")
		for i = 1, 2 do
			ordnancePod = ents.Create("obj_ff_ordnance_pod")
			startPosition = ExposedSpots[math.random(1, #ExposedSpots)] + Vector(0,0,100)
			endPosition = startPosition + Vector(math.random(-1000, 1000), math.random(-1000, 1000), 10000)
			trace = util.TraceLine({
				start = startPosition,
				endpos = endPosition,
			})
			debugoverlay.Line(startPosition, endPosition, 5, Color(255,255,255))
			ordnancePod:SetPos(trace.HitPos + trace.HitNormal*200)
			--ordnancePod:SetWeapons(OrdnanceWeapons)
			ordnancePod:Spawn()
			
			net.Start("DisplayListAdd")
			net.WriteTable({ordnancePod, "ORDNANCE", "hud/ordnance_marker", Color(0, 255, 0, 255)})
			net.Broadcast()
			ordnancePod:GetPhysicsObject():SetVelocity((startPosition-endPosition):GetNormalized()*4000)
			ordnancePod:SetAngles(ordnancePod:GetPhysicsObject():GetVelocity():GetNormalized():Angle() + Angle(-90,0,0))
		end
	end
end

function GM:EntityRemoved(ent)
	if (table.HasValue(AliveReinforcements, ent)) then
		table.RemoveByValue(AliveReinforcements, ent)
		if (currentReinforcement == maxReinforcements) then
			if (#AliveReinforcements == 5) then
				for k, v in pairs(AliveReinforcements) do
					net.Start("DisplayListAdd")
					net.WriteTable({v, "ENEMY", "hud/enemy_marker", Color(150, 0, 0, 255)})
					net.Broadcast()
				end
				PrintMessage(3, ("5 enemies remaining"))
			elseif (#AliveReinforcements == 2) then
				PrintMessage(3, ("2 enemies remaining"))
			elseif (#AliveReinforcements == 1) then
				PrintMessage(3, ("Last enemy"))
			elseif (#AliveReinforcements <= 0) then
				EndSet()
			end
		end
		if (#AliveReinforcements <= (#StartReinforcements*0.2) && StartedReinforcement==false and currentReinforcement!= maxReinforcements) then
			StartReinforcement()
		end
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
	net.Start("UpdateLives")
	net.WriteInt(playerLives, 8)
	net.Broadcast()
	PrintMessage(3, tostring(playerLives).." lives left.")
	if (playerLives < 0) then
		FinishGame(false)
	end
end

function GM:DoPlayerDeath(ply, attacker, dmg)
	ply:CreateRagdoll()
	for k, weapon in pairs(ply:GetWeapons()) do
		for ammoType, ammoCount in pairs(ply:GetAmmo()) do
			if (ammoType == weapon:GetPrimaryAmmoType()) then
				weapon.ReserveAmmo = ammoCount
				break
			end
		end
		ply:DropWeapon(v)
	end
	ply:StripAmmo()
end

-- function GM:PlayerAmmoChanged(ply,ammoID,oldCount,newCount)
-- 	for k,v in pairs(ply:GetWeapons()) do
-- 		if (v:GetPrimaryAmmoType()==ammoID) and (newCount > (v:GetMaxClip1()*3)) then
-- 			ply:SetAmmo(v:GetMaxClip1()*3, ammoID)
-- 		end
-- 	end
-- end

--Don't need players hogging all weapons and ammo to themselves. Limit players to 2 weapons and 4 clips reserve!
local requestPickup = nil
function GM:PlayerCanPickupWeapon(ply, wep) 
	if (ply:HasWeapon(wep:GetClass())) then --If we have a matching weapon, pickup as much ammo as we can from it
		local totalAmmo = ply:GetAmmoCount(wep:GetPrimaryAmmoType()) + ply:GetWeapon(wep:GetClass()):Clip1()
		local totalMaxAmmo = wep:GetMaxClip1()*4 --4 full clips of ammo is the max for any weapon
		local totalAmmoNeeded = totalMaxAmmo - totalAmmo
		if totalAmmoNeeded > 0 then
			local amountGiven = 0
			if (wep.ReserveAmmo and wep.ReserveAmmo > 0) then
				amountGiven = amountGiven + math.min(wep.ReserveAmmo, totalAmmoNeeded)
				totalAmmoNeeded = totalAmmoNeeded - amountGiven
				wep.ReserveAmmo = wep.ReserveAmmo - amountGiven
			end
			if (wep:Clip1() > 0) then
				amountGiven = amountGiven + math.min(wep:Clip1(), totalAmmoNeeded)
				wep:SetClip1(wep:Clip1() - totalAmmoNeeded) --fill this in
			end
			ply:GiveAmmo(amountGiven, wep:GetPrimaryAmmoType())
			if (wep.ReserveAmmo) then
				if (wep:Clip1() <= 0 and wep.ReserveAmmo <= 0) then
					wep:Remove() --Remove the weapon if it has nothing left
				end
			else
				if (wep:Clip1() <= 0) then
					wep:Remove() --Remove the weapon if it has nothing left
				end
			end
		end
	elseif (IsValid(requestPickup) and requestPickup:IsWeapon()) then
		if (#ply:GetWeapons() >= 2) then
			local droppedWeapon = ply:GetActiveWeapon()
			--Set the dropped weapon's reserve ammo
			droppedWeapon.ReserveAmmo = ply:GetAmmoCount(droppedWeapon:GetPrimaryAmmoType())
			ply:RemoveAmmo(ply:GetAmmoCount(droppedWeapon:GetPrimaryAmmoType()), droppedWeapon:GetPrimaryAmmoType())
			ply:DropWeapon(droppedWeapon)
			timer.Simple(0.2, function()
				requestPickup = nil --Need a small timer here to prevent auto pickups of the weapon that was just dropped
			end)
		end
		return true
	elseif (#ply:GetWeapons()<2) then
		return true --force a gun to be picked up if we're unarmed
	end
	return false
end

function GM:WeaponEquip(weapon, owner)
	if (weapon.ReserveAmmo) then
		owner:GiveAmmo(weapon.ReserveAmmo, weapon:GetPrimaryAmmoType())
	end
end

function GM:PlayerUse(ply, ent)
	requestPickup = ent
end