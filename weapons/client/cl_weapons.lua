ADD_REASON_AWARDS = 0xB784AD1E
ADD_REASON_CREATE_CHARACTER = 0xE2C4FF71
ADD_REASON_DEBUG = 0x5C05C64D
ADD_REASON_DEFAULT = 0x2CD419DC
ADD_REASON_GET_INVENTORY = 0xD8188685
ADD_REASON_INCENTIVE = 0x8ADC2E95
ADD_REASON_LOADOUT = 0xCA3454E6
ADD_REASON_LOAD_SAVEGAME = 0x56212906
ADD_REASON_LOOTED = 0xCA806A55
ADD_REASON_MELEE = 0x7B9BDCE7
ADD_REASON_MP_MISSION = 0xEC0E0194
ADD_REASON_NOTIFICATION = 0xC56292D2
ADD_REASON_PICKUP = 0x1A770E22
ADD_REASON_PURCHASED = 0x4A6726C9
ADD_REASON_SET_AMOUNT = 0x4504731E
ADD_REASON_SYNCING = 0x8D4B4FF4
ADD_REASON_USE_FAILED = 0xD385B670

RegisterNetEvent("dbyte:weapon:give")
AddEventHandler("dbyte:weapon:give", function (name)
    local hash = GetHashKey(name)
    if not IsWeaponValid(hash) then
        print("Invalid weapon: " .. tostring(name))
        return
    end

    GiveWeaponToPed_2(
        PlayerPedId(),
        hash,
        999,      -- ammo
        true,  -- forceInHand
        true,  -- forceInHolster
        0,      -- attachPoint
        true,  -- allowMultipleCopies
        0.5,    -- unknown, keep at 0.5
        1.0,    -- same as above
        ADD_REASON_DEFAULT, -- addReason
        false, -- ignoreUnlocks
        0, -- permanentDegredation
        false -- p12
    )
end)

RegisterCommand("wep", function(source, args)
    if not args[1] then return end
    local name = tostring(args[1])
    name = "WEAPON_" .. string.upper(name)
    TriggerServerEvent("dbyte:weapon:request", name)
end)

RegisterCommand("removeweps", function(source, args)
    RemoveAllPedWeapons(PlayerPedId(), true, true)
end)

RegisterCommand("ammo", function()
    local ped = PlayerPedId()
    local myWeapons = GetMyWeapons()
    for hash, _ in pairs(myWeapons) do
        SetPedAmmo(ped, hash, 999999)
        SetAmmoInClip(ped, hash, 999999)
    end
end)

TriggerEvent("chat:addSuggestion", "/wep", "Gives a weapon", { { name = "name", "model name, example: WEAPON_BOW" } })
TriggerEvent("chat:addSuggestion", "/removeweps", "Removes all weapons")