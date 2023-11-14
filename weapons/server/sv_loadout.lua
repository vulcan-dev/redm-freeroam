local function getIdentifiers(source)
    local identifiers = {}
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            identifiers.steamid = v
        elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
            identifiers.fivem = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            identifiers.license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            identifiers.xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            identifiers.ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifiers.discord = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            identifiers.liveid = v
        end
    end
    return identifiers
end

RegisterNetEvent("dbyte:weapon:saveloadout")
AddEventHandler("dbyte:weapon:saveloadout", function(name, loadout)
    -- Get all loadouts
    local loadouts = LoadResourceFile("weapons", "loadouts.json")
    if not loadouts then
        loadouts = {}
    else
        loadouts = json.decode(loadouts)
    end

    -- Get out FiveM ID
    local identifiers = getIdentifiers(source)
    local fivem = identifiers.fivem
    if not fivem then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "Cannot save unless you are logged in" },
            color = {255, 0, 0}
        })
        return
    end

    -- Create an empty table for out loadout
    if not loadouts[fivem] then
        loadouts[fivem] = {}
    end

    -- Get the names as a list
    local names = {}
    for loadoutName, _ in pairs(loadout) do
        names[#names+1] = loadoutName
    end

    loadouts[fivem][name] = names

    -- Save the resource
    if SaveResourceFile("weapons", "loadouts.json", json.encode(loadouts), -1) then
        TriggerClientEvent("chat:addMessage", source, {
            color = { 0, 255, 0 },
            args = { "Server", "Saved loadout" }
        })

        TriggerClientEvent("dbyte:weapon:onGetLoadouts", source, loadouts[fivem])
    end
end)

RegisterNetEvent("dbyte:weapon:removeLoadout")
AddEventHandler("dbyte:weapon:removeLoadout", function(name)
    -- Get all loadouts
    local loadouts = LoadResourceFile("weapons", "loadouts.json")
    if not loadouts then
        loadouts = {}
    else
        loadouts = json.decode(loadouts)
    end

    -- Get our FiveM ID
    local identifiers = getIdentifiers(source)
    local fivem = identifiers.fivem
    if not fivem then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "Cannot save unless you are logged in" },
            color = { 255, 0, 0 }
        })
        return
    end

    -- Check if the specified loadout exists
    if not loadouts[fivem] or not loadouts[fivem][name] then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "Loadout not found" },
            color = { 255, 0, 0 }
        })
        return
    end

    -- Remove the loadout
    loadouts[fivem][name] = nil

    -- Save the updated loadouts
    if SaveResourceFile("weapons", "loadouts.json", json.encode(loadouts), -1) then
        TriggerClientEvent("chat:addMessage", source, {
            color = { 0, 255, 0 },
            args = { "Server", "Loadout removed" }
        })

        TriggerClientEvent("dbyte:weapon:onGetLoadouts", source, loadouts[fivem])
    end
end)

RegisterNetEvent("dbyte:weapon:requestLoadouts")
AddEventHandler("dbyte:weapon:requestLoadouts", function()
    -- Get all loadouts
    local loadouts = LoadResourceFile("weapons", "loadouts.json")
    if not loadouts then
        loadouts = {}
    else
        loadouts = json.decode(loadouts)
    end

    -- Get out FiveM ID
    local identifiers = getIdentifiers(source)
    local fivem = identifiers.fivem
    if not fivem then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "Cannot get loadout unless you are logged in" },
            color = {255, 0, 0}
        })
        return
    end

    -- Create an empty table for out loadout
    if not loadouts[fivem] then
        loadouts[fivem] = {}
    end

    TriggerClientEvent("dbyte:weapon:onGetLoadouts", source, loadouts[fivem])
end)