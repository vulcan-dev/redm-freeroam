local WEATHERTYPE_SNOW = 0xEFB6EFF6
local WEATHERTYPE_GROUNDBLIZZARD = 0x7F622122
local WEATHERTYPE_WHITEOUT = 0x2B402288
local WEATHERTYPE_BLIZZARD = 0x27EA2814

local currentHash = nil
local ignoreSnowCheck = false

local function isSnowy()
    return currentHash == WEATHERTYPE_SNOW or
           currentHash == WEATHERTYPE_GROUNDBLIZZARD or
           currentHash == WEATHERTYPE_WHITEOUT or
		   currentHash == WEATHERTYPE_BLIZZARD
end

RegisterNetEvent("dbyte:env:setWeather")
AddEventHandler("dbyte:env:setWeather", function(weatherHash)
    currentHash = weatherHash
    Citizen.InvokeNative(0x59174F1AFE095B5A, weatherHash, true, true, false, 0, false) -- SET_WEATHER_TYPE
    Citizen.InvokeNative(0xBE83CAE8ED77A94F, weatherHash) -- ADVANCE_CLOCK_TIME_TO

	if ignoreSnowCheck then return end

    if isSnowy() then
        Citizen.InvokeNative(0xE6E16170, true) -- FORCE_SNOW_PASS
        Citizen.InvokeNative(0xF02A9C330BBFC5C7, 2) -- _SET_SNOW_COVERAGE_TYPE
        Citizen.InvokeNative(0xF6BEE7E80EC5CA40, 100) -- _SET_SNOW_LEVEL
    else
        Citizen.InvokeNative(0xE6E16170, false) -- FORCE_SNOW_PASS
        Citizen.InvokeNative(0xF02A9C330BBFC5C7, 0) -- _SET_SNOW_COVERAGE_TYPE
        Citizen.InvokeNative(0xF6BEE7E80EC5CA40, 0) -- _SET_SNOW_LEVEL
    end
end)

RegisterNetEvent("dbyte:env:setTime")
AddEventHandler("dbyte:env:setTime", function(h, m, s)
    Citizen.InvokeNative(0x669E223E64B1903C, h, m, s, 3000, false) -- _NETWORK_CLOCK_TIME_OVERRIDE
end)

RegisterNetEvent("dbyte:env:setSnow")
AddEventHandler("dbyte:env:setSnow", function(enabled, amount)
	enabled = enabled
	amount = amount
	ignoreSnowCheck = enabled

	if enabled then
        Citizen.InvokeNative(0xE6E16170, true) -- FORCE_SNOW_PASS
        Citizen.InvokeNative(0xF02A9C330BBFC5C7, 2) -- _SET_SNOW_COVERAGE_TYPE
        Citizen.InvokeNative(0xF6BEE7E80EC5CA40, amount) -- _SET_SNOW_LEVEL
	else
        Citizen.InvokeNative(0xE6E16170, false) -- FORCE_SNOW_PASS
        Citizen.InvokeNative(0xF02A9C330BBFC5C7, 0) -- _SET_SNOW_COVERAGE_TYPE
        Citizen.InvokeNative(0xF6BEE7E80EC5CA40, 0) -- _SET_SNOW_LEVEL
	end
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("dbyte:env:requestSync")
end)

local serverTime = 0
local clientTime = 0
local freezeTime = 0

RegisterNetEvent('dbyte:env:updateTime')
AddEventHandler('dbyte:env:updateTime', function(base, offset, freeze)
	freezeTime = freeze
	serverTime = base + offset
end)

local function timeToHMS(time)
	local hour = math.floor(((time)/60)%24)
	local minute = math.floor((time)%60)
	local second = math.floor((time-math.floor(time))*60)

	return hour, minute, second
end

Citizen.CreateThread(function()
	local hour = 0
	local minute = 0
	local second = 0
	local timer = GetGameTimer()

	while true do
		Citizen.Wait(0)
		local newClientTime = clientTime
		local deltaTime = 0

		if GetGameTimer() > timer and not freezeTime then
			deltaTime = (GetGameTimer() - timer) / 1000.0
			timer = GetGameTimer()
		end

		serverTime = serverTime + deltaTime

		-- instant change for large amounts of time
		if math.abs(serverTime - clientTime) > 10.0 then
			clientTime = serverTime
		end

		-- time adjust for small changes
		if clientTime > serverTime then
			clientTime = clientTime + deltaTime*0.5
		else
			clientTime = clientTime + deltaTime
		end

		-- x2 speedup for medium range changes
		if (clientTime < serverTime-1) then
			clientTime = clientTime + deltaTime
		end

		hour, minute, second = timeToHMS(clientTime)
        -- print(hour, minute, second)

		-- NetworkOverrideClockTime(hour, minute, second)
        Citizen.InvokeNative(0x669E223E64B1903C, hour, minute, second, 0, true)
	end
end)

TriggerEvent("chat:addSuggestion", "/weather", "Sets the weather", { { name = "type", help = "blizzard, clouds, drizzle, fog, groundblizzard, hail, highpressure, hurricane, misty, overcast, overcastdark, rain, sandstorm, shower, sleet, snow, snowlight, sunny, thunder, thunderstorm, whiteout" } })