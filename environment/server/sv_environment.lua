local weatherTypes = {
    ["BLIZZARD"] = 0x27EA2814,
    ["CLOUDS"] = 0x30FDAF5C,
    ["DRIZZLE"] = 0x995C7F44,
    ["FOG"] = 0xD61BDE01,
    ["GROUNDBLIZZARD"] = 0x7F622122,
    ["HAIL"] = 0x75A9E268,
    ["HIGHPRESSURE"] = 0xF5A87B65,
    ["HURRICANE"] = 0x320D0951,
    ["MISTY"] = 0x5974E8E5,
    ["OVERCAST"] = 0xBB898D2D,
    ["OVERCASTDARK"] = 0x19D4F1D9,
    ["RAIN"] = 0x54A69840,
    ["SANDSTORM"] = 0xB17F6111,
    ["SHOWER"] = 0xE72679D5,
    ["SLEET"] = 0x0CA71D7C,
    ["SNOW"] = 0xEFB6EFF6,
    ["SNOWLIGHT"] = 0x23FB812B,
    ["SUNNY"] = 0x614A1F91,
    ["THUNDER"] = 0xB677829F,
    ["THUNDERSTORM"] = 0x7C1C4A13,
    ["WHITEOUT"] = 0x2B402288
}

local environment = {
    weather = weatherTypes["SUNNY"],
    time = {
        hour = 12,
        minute = 0,
        second = 0
    }
}

local timeOffset = 0
local baseTime = 0
local freezeTime = false

local function shiftToHour(hour)
	timeOffset = timeOffset - (( math.floor((baseTime+timeOffset) / 60) % 24) - hour) * 60
end

local function shiftToMinute(minute)
	timeOffset = timeOffset - (( math.floor(baseTime+timeOffset) % 60) - minute)
end

local function shiftToSecond(second)
    timeOffset = timeOffset - ((math.floor((baseTime + timeOffset) / 60) % 60) - second) * 60
end

RegisterServerEvent("dbyte:env:requestSync", function()
    TriggerClientEvent("dbyte:env:setWeather", -1, environment.weather)
    -- TriggerClientEvent("dbyte:env:setTime", source, environment.time.hour, environment.time.minute, environment.time.second)
    TriggerClientEvent('dbyte:env:updateTime', -1, baseTime, timeOffset, freezeTime)
end)

RegisterCommand("weather", function(source, args)
    local weatherType = args[1]
    if not weatherType then return end

    weatherType = string.upper(tostring(weatherType))
    if not weatherTypes[weatherType] then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "Invalid weather type" }, color = {255, 0, 0}
        })
        return
    end

    environment.weather = weatherTypes[weatherType]
    TriggerClientEvent("dbyte:env:setWeather", -1, environment.weather)
end)

RegisterCommand("time", function(source, args)
    local timeStr = args[1]
    if not timeStr then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "Invalid time provided" }, color = {255, 0, 0}
        })
        return
    end

    local splitTime = split(timeStr, ":")
    local h = tonumber(splitTime[1])
    if not h then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "Invalid time provided" }, color = {255, 0, 0}
        })
        return
    end

    environment.time.hour = h
    environment.time.minute = tonumber(splitTime[2]) or environment.time.minute
 
    shiftToHour(environment.time.hour)
    shiftToMinute(environment.time.minute)

    TriggerEvent("dbyte:env:requestSync")
end)

RegisterCommand("snow", function(source, args)
    local enabled = args[1]
    local amount = args[2] or 100
    amount = tonumber(amount)

    local function to_bool(s)
        if not s then return false end
        return s == "true" or s == "1"
    end
    enabled = to_bool(enabled)

    TriggerClientEvent("dbyte:env:setSnow", -1, enabled, amount)
end)

local function timeToHMS(time)
	local hour = math.floor(((time)/60)%24)
	local minute = math.floor((time)%60)
	local second = math.floor((time-math.floor(time))*60)

	return hour, minute, second
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local newBaseTime = os.time(os.date("!*t"))/2 + 360

		if freezeTime then
			timeOffset = timeOffset + baseTime - newBaseTime
		end

		local h1 = timeToHMS(baseTime+timeOffset)
		local h2 = timeToHMS(newBaseTime+timeOffset)

		if h2 ~= h1 then
			TriggerEvent('es_wsync:hour_started', h2)
			TriggerClientEvent('es_wsync:hour_started', -1, h2)
		end

		baseTime = newBaseTime
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		TriggerClientEvent('dbyte:env:updateTime', -1, baseTime, timeOffset, freezeTime)
	end
end)