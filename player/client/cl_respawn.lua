---@diagnostic disable: lowercase-global
local alreadyDead = false

local effect = "MP_Downed"
local frontendSoundsetName =  "Ready_Up_Flash"
local frontendSoundsetRef = "RDRO_In_Game_Menu_Sounds"

function processDeathEvent()
	while true do
		Wait (0)

		if IsPedDeadOrDying(PlayerPedId()) == 1 then
			if alreadyDead == false then
				alreadyDead = true
				Citizen.CreateThread(onPlayerDead)
			end
		end

		if IsPedDeadOrDying(PlayerPedId()) == false then
			if alreadyDead == true then
				alreadyDead = false
				Citizen.CreateThread(onPlayerNotDeadAnymore)
			end
		end
	end
end

function processScreenFilter()
	ClearTimecycleModifier()
	SetTimecycleModifier("dying")
	while true do
		Wait(500)

		local player = PlayerPedId()
		local maxh = GetEntityMaxHealth(player)
		local h = GetEntityHealth(player)
		local float = 1.0-h/maxh

		if float >= 1.0 then float = 0.5 end

		SetTimecycleModifierStrength(float*2)
	end
end

Citizen.CreateThread(processDeathEvent)
Citizen.CreateThread(processScreenFilter)

function StartMusicEvent(event)
	PrepareMusicEvent(event)
	return TriggerMusicEvent(event) == 1
end

function onPlayerDead()
	AnimpostfxPlay(effect)
	Citizen.InvokeNative(0x67C540AA08E4A6F5, frontendSoundsetName, frontendSoundsetRef, true, 0)

	local killer = GetPedSourceOfDeath(PlayerPedId())
	if killer and IsEntityAPed(killer) and killer ~= PlayerPedId() then
		SetGameplayEntityHint(killer, 0.0, 0.0, 1.0, true, -1, 1000, 1000, 1)
	end
	Wait(1000)

	repeat Wait(0)
		if IsControlJustPressed(0, "INPUT_ENTER") then
			if killer and IsEntityAPed(killer) and killer ~= PlayerPedId() then
				DoScreenFadeOut(250)
				Wait(250)
				NetworkSetInSpectatorMode(true, killer)
				DoScreenFadeIn(250)
			end
		end
	until IsControlJustPressed(0, "INPUT_ATTACK") or IsControlJustPressed(0, "INPUT_JUMP")

	DoScreenFadeOut(1500)
	Wait(1500+500)

	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))

	x = x + math.random(-50, 50)
	y = y + math.random(-50, 50)

	local success, vec3, heading = GetRandomVehicleNode(x,y,z, 50.0, 1, true, true)

	if success then x, y, z = table.unpack(vec3) end

	local _, vec3 = GetSafeCoordForPed(x, y, z, false, 16)
	x, y, z = table.unpack(vec3)

	exports.player:restoreCores(PlayerPedId())

	AnimpostfxStop(effect)
	Citizen.InvokeNative(0x9D746964E0CF2C5F, frontendSoundsetName, frontendSoundsetRef)

	NetworkResurrectLocalPlayer(x, y, z-1.0, heading, true, true, true)

	ClearTimecycleModifier()
	NetworkSetInSpectatorMode(false, killer)
	StopGameplayHint(1000)

	ShakeGameplayCam("JUMPCUT_SHAKE",  1.0)
	DoScreenFadeIn(250)
	Wait(250)
end