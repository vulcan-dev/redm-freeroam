RegisterCommand("model", function(source, args)
    local model = args[1]
    if not model then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "No model specified" },
            color = {255, 0, 0}
        })
        return
    end

    TriggerClientEvent("dbyte:player:setModel", source, tostring(model))
end)

RegisterCommand("strike", function(source, args)
    local id = tonumber(args[1]) or source

    local found = false
    for _, pid in ipairs(GetPlayers()) do
        if tonumber(id) == tonumber(pid) then
            found = true
            break
        end
    end

    if not found then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "Invalid player id" },
            color = {255, 0, 0}
        })
        return
    end

    local ped = GetPlayerPed(id)
    -- print(GetPlayerPed(id))

    CreateThread(function()
        TriggerClientEvent("dbyte:player:strike", -1, GetEntityCoords(ped))
        Wait(100)
        TriggerClientEvent("dbyte:player:kill", id)
    end)
end)

RegisterCommand("god", function(source, args)
    function randomFloat(lower, greater)
        return lower + math.random()  * (greater - lower);
    end

    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local n = 100

    local x = randomFloat(coords.x - n, coords.x + n)
    local y = randomFloat(coords.y - n, coords.y + n)

    for _, pid in ipairs(GetPlayers()) do
        TriggerClientEvent("dbyte:player:god", pid, { x, y, coords.z }, pid == source)
    end
end)