local hudHidden = false

local function enableFriendlyFire()
    -- Enable friendly fire, will need to do it everytime someone loads a model
    SetRelationshipBetweenGroups(3, `PLAYER`, `PLAYER`)
    NetworkSetFriendlyFireOption(true)
end

-- CreateThread(function()
--     while true do
--         Wait(1000)
--         Citizen.InvokeNative(0xF808475FA571D823, true) --enable friendly fire
--         NetworkSetFriendlyFireOption(true)
--         SetCanAttackFriendly(PlayerPedId(), true, true)
--     end
-- end)

RegisterNetEvent("playerSpawned")
AddEventHandler("playerSpawned", function()
    exports.spawnmanager:setAutoSpawn(false)
    enableFriendlyFire()

    exports.player:restoreCores(PlayerPedId())

    -- Reveal map
    Citizen.InvokeNative(0x4B8F743A4A6D2FF8, true)
end)

RegisterNetEvent("onResourceStart")
AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    enableFriendlyFire()
end)

local function spawnPed(model, pos, scale, noLongerNeeded)
    scale = scale or 1
    noLongerNeeded = noLongerNeeded or true

    local hash = GetHashKey(model)
    if not HasModelLoaded(hash) then
        RequestModel(hash, 0)
        local times = 1
        while not HasModelLoaded(hash) do
            RequestModel(hash, 0)
            times = times + 1
            Citizen.Wait(0)

            if times >= 128 then
                print("Could not load model")
                return
            end
        end
    end

    local ped = CreatePed(model, pos.x, pos.y, pos.z, 0, true, true, true, true)

    SetPedScale(ped, scale + 0.0)

    if noLongerNeeded then
        SetModelAsNoLongerNeeded(model)
    end

    return ped
end

RegisterCommand("spawnped", function(source, args)
    -- Basic checks
    local model = args[1]
    if not model then return end

    model = tostring(model)
    local hash = GetHashKey(model)
    if not IsModelValid(hash) then return end

    -- Load model
    if not HasModelLoaded(hash) then
        RequestModel(hash, 0)
        local times = 1
        while not HasModelLoaded(hash) do
            RequestModel(hash, 0)
            times = times + 1
            Citizen.Wait(0)

            if times >= 128 then
                print("Could not load model")
                return
            end
        end
    end

    local pos = GetEntityCoords(PlayerPedId(), false)
    local forwardVector = GetEntityForwardVector(PlayerPedId())
    local spawnPos = pos + forwardVector * 5

    local count = tonumber(args[2]) or 1
    local scale = tonumber(args[3]) or 1

    for i=1, count do
        local ped = CreatePed(model, spawnPos.x, spawnPos.y, spawnPos.z + i, 0, true, true, true, true)

        Citizen.InvokeNative(0x283978A15512B2FE, ped, true) -- _SET_RANDOM_OUTFIT_VARIATION
        Citizen.InvokeNative(0x4111BA46, ped, 1) -- _SET_RANDOM_OUTFIT_VARIATION

        SetPedScale(ped, scale + 0.0)
        SetModelAsNoLongerNeeded(model)
        SetEntityAsNoLongerNeeded(ped)
    end
end)

RegisterCommand("attack", function(source, args)
    local amount = args[1] or 8

    local _, peds = AddRelationshipGroup("madPeds")
    SetRelationshipBetweenGroups(0, peds, peds)

    local _, players = AddRelationshipGroup("players")
    SetRelationshipBetweenGroups(5, peds, players)
    SetRelationshipBetweenGroups(5, players, peds)
    SetPedRelationshipGroupHash(PlayerPedId(), players)

    local radius = 15

    for i=1,amount do
        math.randomseed(i)
        local pos = GetEntityCoords(PlayerPedId())
        local offsetX = math.random(-radius, radius)
        local offsetY = math.random(-radius, radius)
        local newPos = vec(pos.x + offsetX, pos.y + offsetY, pos.z)
        local ped = spawnPed("RE_RALLYSETUP_MALES_01", newPos, 1, false)
        print(ped, newPos)

        if Citizen.InvokeNative(0xB417689857646F61, PlayerPedId()) == 0 and Citizen.InvokeNative(0xB417689857646F61, ped) ~= 0 then -- GET_INTERIOR_FROM_ENTITY
            SetEntityCoords(ped, target.x, target.y, groundZ)
        end

        if Citizen.InvokeNative(0xB417689857646F61, PlayerPedId()) == 0 then
            local interior = Citizen.InvokeNative(0xB417689857646F61, ped) -- Get spawned peds interior

            while interior ~= 0 do
                offsetX = math.random(-radius, radius)
                offsetY = math.random(-radius, radius)
                local target = vector3(pos.x + offsetX, pos.y + offsetY, pos.z)
                local found, groundZ, _ = GetGroundZAndNormalFor_3dCoord(target.x, target.y, height + 0.0)
                SetEntityCoords(ped, target.x, target.y, found and groundZ or pos.z)
                interior = Citizen.InvokeNative(0xB417689857646F61, ped)

                print(target)
            end
        end

        Citizen.InvokeNative(0x283978A15512B2FE, ped, true) -- _SET_RANDOM_OUTFIT_VARIATION
        GiveWeaponToPed_2(
            ped,
            `WEAPON_MELEE_MACHETE`,
            999,      -- ammo
            true,  -- forceInHand
            true,  -- forceInHolster
            0,      -- attachPoint
            false,  -- allowMultipleCopies
            0.5,    -- unknown, keep at 0.5
            1.0,    -- same as above
            ADD_REASON_DEFAULT, -- addReason
            false, -- ignoreUnlocks
            0, -- permanentDegredation
            false -- p12
        )

        ClearPedTasks(ped)
        SetPedRelationshipGroupHash(ped, peds)

        TaskCombatPed(
            ped,
            PlayerPedId(),
            0,
            16
        )

        SetPedCombatAbility(ped, 100)
        SetPedCombatRange(ped, 2)
        SetPedCombatAttributes(ped, 46, 1)
        SetPedCombatAttributes(ped, 5, 1)

        SetEntityAsNoLongerNeeded(ped)
    end

    SetModelAsNoLongerNeeded("RE_RALLYSETUP_MALES_01")
end)

RegisterCommand("spawnveh", function(source, args)
    -- Basic checks
    local model = args[1]
    if not model then return end

    model = tostring(model)
    local hash = GetHashKey(model)
    if not IsModelValid(hash) then return end

    -- Load model
    if not HasModelLoaded(hash) then
        RequestModel(hash, 0)
        local times = 1
        while not HasModelLoaded(hash) do
            RequestModel(hash, 0)
            times = times + 1
            Citizen.Wait(0)

            if times >= 128 then
                print("Could not load model")
                return
            end
        end
    end

    local pos = GetEntityCoords(PlayerPedId(), false)
    local forwardVector = GetEntityForwardVector(PlayerPedId())
    local spawnPos = pos + forwardVector * 5

    local ped = CreateVehicle(model, spawnPos.x, spawnPos.y, spawnPos.z, 0, true, true, true, true)

    Citizen.InvokeNative(0x283978A15512B2FE, ped, true) -- _SET_RANDOM_OUTFIT_VARIATION
    Citizen.InvokeNative(0x4111BA46, ped, 1) -- _SET_RANDOM_OUTFIT_VARIATION

    SetModelAsNoLongerNeeded(model)
    SetEntityAsNoLongerNeeded(ped)
end)

RegisterCommand("hud", function()
    hudHidden = not hudHidden
    DisplayHud(hudHidden)
    Citizen.InvokeNative(0x50C803A4CD5932C5, hudHidden) -- _SHOW_PLAYER_CORES
    Citizen.InvokeNative(0xD4EE21B7CC7FD350, hudHidden) -- _SHOW_HORSE_CORES
end)

RegisterNetEvent("dbyte:general:enableff")
AddEventHandler("dbyte:general:enableff", enableFriendlyFire)

RegisterNetEvent("dbyte:general:throw")
AddEventHandler("dbyte:general:throw", function(x, y, z)
    x = x + 0.0
    y = y + 0.0
    z = z + 0.0

    local horse = GetMount(PlayerPedId())
    if DoesEntityExist(horse) then
        SetEntityVelocity(horse, x, y, z)
    else
        SetEntityVelocity(PlayerPedId(), x, y, z)
    end
end)

TriggerEvent('chat:addSuggestion', '/spawnped', 'Spawns a ped into the world', {
    { name = "model" },
    { name = "(amount)" },
    { name = "(scale)" }
})

AddEventHandler("onClientResourceStart", function(res)
    if GetCurrentResourceName() ~= res then return end

    print("Resource Started!")
end)