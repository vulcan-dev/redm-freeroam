local doors = {}

RegisterNetEvent("dbyte:doors:toggleLock", function(doorHash)
    print(doorHash)
    if not doors[doorHash] then
        doors[doorHash] = true -- Unlocked by default, so lock
    else
        doors[doorHash] = not doors[doorHash]
    end

    TriggerClientEvent("dbyte:doors:lock", -1, doorHash, doors[doorHash])
end)

RegisterNetEvent("dbyte:doors:requestSync", function()
    print("Syncing Doors for", source)
    TriggerClientEvent("dbyte:doors:sync", source, doors)
end)