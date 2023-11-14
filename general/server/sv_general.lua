RegisterCommand("throw", function(source, args)
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

    local x = args[2] or 0
    local y = args[3] or 0
    local z = args[4] or 100

    if (args[2] or args[3]) and not args[4] then z = 0 end

    TriggerClientEvent("dbyte:general:throw", pid, x, y, z)
end)