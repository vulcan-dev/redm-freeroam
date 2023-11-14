local myLoadouts = {}

RegisterCommand("saveloadout", function(source, args)
    local weapons = GetMyWeapons()
    local count = 0
    for k, v in pairs(weapons) do
        count = count + 1
    end

    if count == 0 then
        TriggerEvent("chat:addMessage", {
            color = { 255, 0, 0 },
            args = { "Server", "You have no weapons to save" }
        })
        return
    end

    local name = args[1]
    if not name then
        TriggerEvent("chat:addMessage", {
            color = { 255, 0, 0 },
            args = { "Server", "Invalid loudout name" }
        })
        return
    end
    name = string.lower(tostring(name))

    TriggerServerEvent("dbyte:weapon:saveloadout", name, weapons)
end)

RegisterNetEvent("playerSpawned")
AddEventHandler("playerSpawned", function()
    TriggerServerEvent("dbyte:weapon:requestLoadouts")
end)

RegisterNetEvent("onResourceStart")
AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    TriggerServerEvent("dbyte:weapon:requestLoadouts")
end)

RegisterNetEvent("dbyte:weapon:onGetLoadouts")
AddEventHandler("dbyte:weapon:onGetLoadouts", function(loadouts)
    myLoadouts = loadouts

    local str = "Loadouts: "
    local suggestions = {{name = "name"}}
    local count = 0
    for name, _ in pairs(loadouts) do
        count = count + 1
        str = str .. name .. ", "
    end

    if count == 0 then
        suggestions[1].help = str .. "None"
    else
        suggestions[1].help = string.sub(str, 1, -3)
    end

    TriggerEvent("chat:addSuggestion", "/loadout", "Loads a saved loadout", suggestions)
    TriggerEvent("chat:addSuggestion", "/removeloadout", "Removes a saved loadout", suggestions)
end)

RegisterCommand("loadout", function(source, args)
    -- Get the loadout name
    local name = args[1]
    if not name then
        TriggerEvent("chat:addMessage", {
            color = { 255, 0, 0 },
            args = { "Server", "No loadout provided" }
        })
        return
    end
    name = tostring(name)

    -- Get the loadout from our table
    TriggerServerEvent("dbyte:weapon:requestLoadouts")
    if not myLoadouts[name] then
        TriggerEvent("chat:addMessage", {
            color = { 255, 0, 0 },
            args = { "Server", "No loadout found" }
        })
        return
    end

    -- Laod the weapons
    RemoveAllPedWeapons(PlayerPedId(), true, true)

    for _, weapon in ipairs(myLoadouts[name]) do
        TriggerEvent("dbyte:weapon:give", weapon)
    end
end)

RegisterCommand("removeloadout", function(source, args)
    -- Get the loadout name
    local name = args[1]
    if not name then
        TriggerEvent("chat:addMessage", {
            color = { 255, 0, 0 },
            args = { "Server", "No loadout provided" }
        })
        return
    end
    name = tostring(name)

    TriggerServerEvent("dbyte:weapon:removeLoadout", name)
end)