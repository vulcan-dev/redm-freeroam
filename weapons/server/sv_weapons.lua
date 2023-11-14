table.contains = function(t, value)
    for _, v in ipairs(t) do
        if v == value then return true end
    end
    return false
end

RegisterNetEvent("dbyte:weapon:request")
AddEventHandler("dbyte:weapon:request", function(name)
    if not name then
        TriggerClientEvent("chat:addMessage", source, {
            args = { "Server", "Invalid weapon model" },
            color = {255, 0, 0}
        })
        return
    end

    TriggerClientEvent("dbyte:weapon:give", source, name)
end)

RegisterCommand("wep", function(source, args)
    local name = tostring(args[1])
    name = "WEAPON_" .. string.upper(name)
    TriggerClientEvent("dbyte:weapon:give", source, name)
end)