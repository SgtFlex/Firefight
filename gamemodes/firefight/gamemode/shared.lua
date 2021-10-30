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
local StarterWeapons = {
	"drc_dmr",
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
	local startingWeapon = player:Give("drc_dmr")
	player:GiveAmmo(startingWeapon:GetMaxClip1()*3, startingWeapon:GetPrimaryAmmoType())
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
			startPosition = Vector(math.random(-500, 500), math.random(-500, 500),200)
			endPosition = startPosition + Vector(math.random(-1000, 1000), math.random(-1000, 1000), 10000)
			trace = util.TraceLine({
				start = startPosition,
				endpos = endPosition,
			})
			debugoverlay.Line(startPosition, endPosition, 5, Color(255,255,255))
			ordnancePod:SetPos(trace.HitPos + trace.HitNormal*200)
			--ordnancePod:SetWeapons(OrdnanceWeapons)
			ordnancePod:Spawn()
			ordnancePod:GetPhysicsObject():SetVelocity((startPosition-endPosition):GetNormalized()*4000)
			ordnancePod:SetAngles(ordnancePod:GetPhysicsObject():GetVelocity():GetNormalized():Angle() + Angle(-90,0,0))
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
