RegisterNetEvent("dbyte:requestTeleport")
AddEventHandler("dbyte:requestTeleport", function (pos)
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "No waypoint set" },
            color = {255, 0, 0}
        })
        return
    end

    TriggerClientEvent("dbyte:teleport", source, pos)
end)

RegisterCommand("tp", function(source, args)
    local identifier = args[1]
    if not identifier then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "Invalid player" },
            color = {255, 0, 0}
        })
        return
    end

    local pid = nil
    for _, playerId in ipairs(GetPlayers()) do
        local name = GetPlayerName(playerId)
        local lowercaseIdentifier = string.lower(identifier)
        local lowercaseName = string.lower(name)

        if lowercaseIdentifier == lowercaseName or tonumber(identifier) == tonumber(playerId) or string.find(lowercaseName, lowercaseIdentifier, 1, true) then
            pid = playerId
            break
        end
    end

    if not pid then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "Invalid player" },
            color = {255, 0, 0}
        })
        return
    end

    if tonumber(pid) == source then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "You cannot teleport to yourself" },
            color = {255, 0, 0}
        })
        return
    end

    local pos = GetEntityCoords(GetPlayerPed(pid))
    TriggerClientEvent("dbyte:teleportTo", source, pos)
end)