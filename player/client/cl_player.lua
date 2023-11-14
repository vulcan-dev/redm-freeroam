-- Helper Functions
---------------------------------------
function restoreCores(ped, horse)
    horse = horse or false
    print("horse", horse)

    local buf1 = DataView.ArrayBuffer(8 * 12)
    local buf2 = DataView.ArrayBuffer(8 * 12)
    for j=1, 12-1 do
        buf1:SetInt32(j * 8, 0)
        buf2:SetInt32(j * 8, 0)
    end

    Citizen.InvokeNative(0xCB5D11F9508A928D, 1, buf1:Buffer(), buf2:Buffer(), `UPGRADE_HEALTH_TANK_1`, 0x1084182731, 12, 0x752097756)
    Citizen.InvokeNative(0xCB5D11F9508A928D, 1, buf1:Buffer(), buf2:Buffer(), `UPGRADE_STAMINA_TANK_1`, 0x1084182731, 12, 0x752097756)

    if not horse then
        Citizen.InvokeNative(0xCB5D11F9508A928D, 1, buf1:Buffer(), buf2:Buffer(), `UPGRADE_DEADEYE_TANK_1`, 0x1084182731, 12, 0x752097756)
    end

    Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, 100) -- _SET_ATTRIBUTE_CORE_VALUE
    Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, 100) -- _SET_ATTRIBUTE_CORE_VALUE

    if not horse then
        Citizen.InvokeNative(0xC6258F41D86676E0, ped, 2, 100) -- _SET_ATTRIBUTE_CORE_VALUE
        Citizen.InvokeNative(0x2498035289B5688F, PlayerId(), 180.0) -- SPECIAL_ABILITY_RESTORE_OUTER_RING
        Citizen.InvokeNative(0x95EE1DEE1DCD9070, ped, true) -- _ENABLE_CUSTOM_DEADEYE_ABILITY

        SetEntityHealth(ped, GetPedMaxHealth(ped))
        Citizen.InvokeNative(0xA9EC16C7, pid, Citizen.InvokeNative(0xD014AB79, pid)) -- SetPlayerStamina & GetPlayerMaxStamina
        Citizen.InvokeNative(0x675680D089BFA21F, ped, 100.0) 
    else
        Citizen.InvokeNative(0x5DA12E025D47D4E5, ped, 0, 100) -- SetAttributeBaseRank
        Citizen.InvokeNative(0x5DA12E025D47D4E5, ped, 1, 100) -- SetAttributeBaseRank

        local maxHealth = Citizen.InvokeNative(0xC7AE6AA1, ped)
        Citizen.InvokeNative(0xAC2767ED8BDFAB15, ped, maxHealth, 0) -- SetEntityMaxHealth
        Citizen.InvokeNative(0x675680D089BFA21F, ped, 100.0) -- RestorePedStamina
        Citizen.InvokeNative(0x345C9F993A8AB4A4, ped, 100.0)
    end
end; exports("restoreCores", restoreCores)

-- RedM Events
---------------------------------------
RegisterNetEvent("playerSpawned")
AddEventHandler("playerSpawned", function()
    restoreCores(PlayerPedId())
end)

-- DByte Events
---------------------------------------
RegisterNetEvent("dbyte:player:setModel")
AddEventHandler("dbyte:player:setModel", function(model)
    local hash = GetHashKey(model)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        repeat Wait(0) until HasModelLoaded(hash)
    end

    SetPlayerModel(PlayerId(), hash, true)
    SetModelAsNoLongerNeeded(hash)
end)

RegisterNetEvent("dbyte:player:strike")
AddEventHandler("dbyte:player:strike", function(pos)
    ForceLightningFlashAtCoords(pos)
end)

RegisterNetEvent("dbyte:player:kill")
AddEventHandler("dbyte:player:kill", function()
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent("dbyte:player:god")
AddEventHandler("dbyte:player:god", function(positions, god)
    ForceLightningFlashAtCoords(pos, -1.0)
end)

-- Commands
---------------------------------------
-- RegisterCommand("face", function(source, args)
--     local model = 0x3625908B
--     local category = N_0x5ff9a878c3d115b8(model, false, true)
--     N_0x59bd177a1a48600a(ped, category)
--     N_0xd3a7b003ed343fd9(ped, model, false, true, false)
-- end)

local cigar = nil
local alcohol = nil

RegisterCommand("whiskey", function()
    SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    alcohol = CreateObject(GetHashKey('p_bottleJD01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    TaskItemInteraction_2(PlayerPedId(), -1199896558, alcohol, `p_bottleJD01x_ph_r_hand`, `DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_UNCORK`, 1, 0, -1.0)
end)

RegisterCommand("beer", function()
    SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    alcohol = CreateObject(GetHashKey('p_bottleBeer01a'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    TaskItemInteraction_2(PlayerPedId(), -1199896558, alcohol, `p_bottleBeer01x_PH_R_HAND`, `DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_UNCORK`, 1, 0, -1.0)
end)

RegisterCommand("stew", function()
    SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    local bowl = CreateObject("p_bowl04x_stew", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
    local spoon = CreateObject("p_spoon01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)

    Citizen.InvokeNative(0x669655FFB29EF1A9, bowl, 0, "Stew_Fill", 1.0)
    Citizen.InvokeNative(0xCAAF2BCCFEF37F77, bowl, 20)

    Citizen.InvokeNative(0xCAAF2BCCFEF37F77, spoon, 82)

    TaskItemInteraction_2(PlayerPedId(), 599184882, bowl, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
    TaskItemInteraction_2(PlayerPedId(), 599184882, spoon, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)

    Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
end)

RegisterCommand("coffee", function()
    SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    local propEntity = CreateObject(GetHashKey('p_mugCoffee01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_COFFEE"), propEntity, GetHashKey("P_MUGCOFFEE01X_PH_R_HAND"), GetHashKey("DRINK_COFFEE_HOLD"), 1, 0, -1)
end)

local useAnimDict = "amb_rest@world_human_smoke_cigar@male_a@idle_a"
local useAnim = "idle_c"
-- local useAnimDict = "script_mp@emotes@smoke_cigar@male@unarmed@upper"
-- local useAnim = "action"

RegisterCommand("cigar", function()
    -- SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    -- local propEntity = CreateObject(GetHashKey('p_matchstick01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)

    -- CreateThread(function()
    --     TaskItemInteraction_2(
    --         PlayerPedId(),
    --         GetHashKey("CONSUMABLE_COFFEE"), -- prop name
    --         propEntity, -- prop
    --         GetHashKey("p_matchstick01x_XH_L_HAND"), -- prop id
    --         GetHashKey("QUICK_SMOKE_CIGAR_LEFT_HAND"), -- interaction state
    --         1, -- p5
    --         0, -- p6
    --         -1 -- p7
    --     )
    --     Wait()
    -- end)

    CreateThread(function()
        local playing = IsEntityPlayingAnim(PlayerPedId(), useAnimDict, useAnim, 51)
        if playing then
            DeleteEntity(cigar)
            cigar = nil
            ExecuteCommand("stoptask")
            return
        end

        SetPedResetFlag(PlayerPedId(), 202, true)

        RequestModel(`p_cigar02x`, true)
        repeat Wait(0) until HasModelLoaded(`p_cigar02x`)

        cigar = CreateObject(`p_cigar02x`, GetEntityCoords(PlayerPedId()), true, true, true, true, true)
        Citizen.InvokeNative(0x3BBDD6143FF16F98, PlayerPedId(), cigar, "p_cigar01x_PH_R_HAND", "WORLD_HUMAN_SMOKE_CIGAR", 0, 1) -- _GIVE_PED_SCENARIO_PROP
        SetModelAsNoLongerNeeded(`p_cigar02x`)

        -- put into mouth
        local dict = "script_mp@emotes@smoke_cigar@male@unarmed@full"
        RequestAnimDict(dict)
        repeat Wait(0) until HasAnimDictLoaded(dict)

        print("playing start")
        TaskPlayAnim(
            PlayerPedId(),
            dict,
            "fullbody",
            1.0,
            1.0,
            -1, -- infinite because we manually cancel it and replace it
            27,
            0,
            0,
            0,
            0
        )

        Wait(2000)

        local boneIndexPalm = GetPedBoneIndex(PlayerPedId(), 44799)
        print("boneIndexPalm", boneIndexPalm)

        local boneIndexFinger = GetPedBoneIndex(PlayerPedId(), 16733)
        print("boneIndexFinger", boneIndexFinger)

        local matches = CreateObject(`p_matches01x`, GetEntityCoords(PlayerPedId()), false, true, false, false, true)
        AttachEntityToEntity(matches, PlayerPedId(), boneIndexPalm, 0, 0, 0, 0, 0, 0, true, false, false, false, vec(60, 60, 0), true, true, true)

        local matchStick = CreateObject(`p_matchstick01x`, GetEntityCoords(PlayerPedId()), false, true, false, false, true)
        AttachEntityToEntity(matchStick, PlayerPedId(), boneIndexFinger, 0.03, 0.04, 0, 0, 0, 0, true, false, false, false, vec(0, 0, 0), false, true, true)

        Wait(1400)
        SetModelAsNoLongerNeeded(`p_matches01x`)
        SetModelAsNoLongerNeeded(`p_matchstick01x`)
        DeleteEntity(matches)
        DeleteEntity(matchStick)

        print("stopping playback")
        StopAnimPlayback(PlayerPedId(), true, true)

        local pos = GetEntityCoords(PlayerPedId())
        local rot = GetEntityRotation(PlayerPedId())

        -- use
        RequestAnimDict(useAnimDict)
        repeat Wait(0) until HasAnimDictLoaded(useAnimDict)
        -- TaskPlayAnim(
        --     PlayerPedId(),
        --     useAnimDict,
        --     useAnim,
        --     1.0,
        --     1.0,
        --     -1,
        --     27,
        --     1,
        --     0,
        --     0,
        --     0
        -- )

        TaskPlayAnimAdvanced(
            PlayerPedId(),
            useAnimDict,
            useAnim,
            pos.x, -- px
            pos.y, -- py
            pos.z, -- pz
            rot.x, -- rx
            rot.y, -- ry
            rot.z, -- rz
            1.0, -- enterSpeed
            1.0, -- exitSpeed
            -1, -- duration
            27, -- flag
            0.2,
            0,
            0
        )
    end)
end)

local wasPlaying = false
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local playing = IsEntityPlayingAnim(ped, useAnimDict, useAnim, 51)
        if playing and IsPedSprinting(ped) then
            playing = false
        end

        if wasPlaying ~= playing then
            wasPlaying = playing

            if not playing then
                -- RequestAnimDict("mp_mech_inventory@smoking@cigar@mp_male@outro")
                -- repeat Wait(0) until HasAnimDictLoaded("mp_mech_inventory@smoking@cigar@mp_male@outro")
                -- TaskPlayAnim(
                --     PlayerPedId(),
                --     "mp_mech_inventory@smoking@cigar@mp_male@outro",
                --     "outro",
                --     1.0,
                --     1.0,
                --     -1,
                --     27,
                --     1,
                --     0,
                --     0,
                --     0
                -- )

                -- Wait(5000)

                DeleteEntity(cigar)
                cigar = nil
                ExecuteCommand("stoptask")
            end
        end

        Wait(100)

        -- if cigar then
        --     Citizen.InvokeNative(0x433083750C5E064A, PlayerPedId(), 0.3) --SET_PED_MAX_MOVE_BLEND_RATIO
        -- end
    end
end)

local prevWeapon = `WEAPON_UNARMED`
RegisterCommand("task", function(source, args)
    local name = args[1]
    if not name then
        TriggerEvent("chat:addMessage", {
            color = { 255, 0, 0 },
            args = { "Server", "No task provided" }
        })
        return
    end

    prevWeapon = Citizen.InvokeNative(0x8425C5F057012DAB) -- _GET_PED_CURRENT_HELD_WEAPON

    ClearPedTasks(PlayerPedId())
    SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey(name), 0, true, 1, GetEntityHeading(PlayerPedId()), false) -- TaskStartScenarioInPlaceHash
end)

RegisterCommand("stoptask", function(_, _)
    ClearPedTasks(PlayerPedId())
    SetCurrentPedWeapon(PlayerPedId(), prevWeapon, true)
end)

RegisterCommand("trumpet", function(_, _)
    ExecuteCommand("task WORLD_HUMAN_TRUMPET")
end)

RegisterCommand("pee", function(_, _)
    ExecuteCommand("task WORLD_HUMAN_PEE")
end)

RegisterCommand("sitguitar", function(_, args)
    local style = tostring(args[1]) or "regular"

    if style == "regular" then
        ExecuteCommand("task WORLD_HUMAN_SIT_GUITAR")
    elseif style == "upbeat" then
        ExecuteCommand("task WORLD_HUMAN_SIT_GUITAR_UPBEAT")
    elseif style == "downbeat" then
        ExecuteCommand("task WORLD_HUMAN_SIT_GUITAR_DOWNBEAT")
    elseif style == "blues" then
        ExecuteCommand("task WORLD_HUMAN_SIT_GUITAR_BLUES")
    else
        ExecuteCommand("task WORLD_HUMAN_SIT_GUITAR")
    end
end); TriggerEvent("chat:addSuggestion", "/sitguitar", "Plays the guitar", {{ name = "style", help = "regular, upbeat, downbeat, blues" }})

RegisterCommand("clipboard", function(_, _)
    ExecuteCommand("task WORLD_HUMAN_CLIPBOARD")
end)

RegisterCommand("outfit", function(source, args)
    local outfit = args[1]
    if not outfit then return end

    SetPedOutfitPreset(PlayerPedId(), tonumber(outfit), 1)
end)

RegisterCommand("clean", function()
    local ped = PlayerPedId()
    ClearPedBloodDamage(ped)
    SetPedWetnessHeight(ped, 0.0)
    ClearPedEnvDirt(ped)
    ClearPedDecorations(ped)
end)

RegisterCommand("restore", function()
    CreateThread(function()
        local propEntity = CreateObject(GetHashKey('s_inv_syringe01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
        TaskItemInteraction_2(PlayerPedId(), GetHashKey("Consumable"), propEntity, GetHashKey("s_inv_syringe01x"), GetHashKey("USE_STIMULANT_INJECTION_QUICK_LEFT_HAND"), 1, 0, -1)
        Wait(1000)
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 0, 1.0, true) -- _ENABLE_ATTRIBUTE_CORE_OVERPOWER
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 1, 1.0, true) -- _ENABLE_ATTRIBUTE_CORE_OVERPOWER
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 3, 1.0, true) -- _ENABLE_ATTRIBUTE_CORE_OVERPOWER
        restoreCores(PlayerPedId())
        
        local horse = GetMount(PlayerPedId())
        if horse then
            Citizen.InvokeNative(0x4AF5A4C7B9157D14, horse, 0, 1.0, true) -- _ENABLE_ATTRIBUTE_CORE_OVERPOWER
            Citizen.InvokeNative(0x4AF5A4C7B9157D14, horse, 1, 1.0, true) -- _ENABLE_ATTRIBUTE_CORE_OVERPOWER
            Citizen.InvokeNative(0x4AF5A4C7B9157D14, horse, 3, 1.0, true) -- _ENABLE_ATTRIBUTE_CORE_OVERPOWER
            restoreCores(horse, true)
        end
    end)
end)

RegisterCommand("pomade", function()
    local playerPed = PlayerPedId()
    if Citizen.InvokeNative(0xFB4891BD7578CDC1, playerPed, tonumber(0x9925C067)) then   -- _IS_METAPED_USING_COMPONENT
        TaskItemInteraction(playerPed, 0, GetHashKey("APPLY_POMADE_WITH_HAT"), 1, 0, -1082130432)
    else
        TaskItemInteraction(playerPed, 0, GetHashKey("APPLY_POMADE_WITH_NO_HAT"), 1, 0, -1082130432)
    end
    Wait(1500)
    Citizen.InvokeNative(0x66B957AAC2EAAEAB, playerPed, GetCurrentPedComponent(playerPed, "hair"), GetHashKey("POMADE"), 0, true, 1) -- _UPDATE_SHOP_ITEM_WEARABLE_STATE
    Citizen.InvokeNative(0xCC8CA3E88256E58F, playerPed, false, true, true, true, false) -- _UPDATE_PED_VARIATION
end)

TriggerEvent("chat:addSuggestion", "/model", "Sets the playermodel", { { name = "name", help = "player model" } })
TriggerEvent("chat:addSuggestion", "/outfit", "Changes your outfit", {{ name = "type", help = "id of the outfit" }})

local slowWalk = false
local drunkness = 0
local drunknessFactor = 0.02
local lastDrinkTime = 0
local fallTime = 0
local maxFallTime = math.random(3000, 6000) -- 3-6 seconds we do a random check to fall
-- local drunkEffect = "PlayerDrunk01"

CreateThread(function()
    while true do
        Wait(slowWalk and 0 or 1)

        -- Cigar health damage stuff
        if DoesEntityExist(cigar) and IsEntityAttached(cigar) then
            print(Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()))
        end

        -- print(drunkness)

        -- Drunk stuff
        if DoesEntityExist(alcohol) and IsEntityAttached(alcohol) then
            local interactionState = Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) -- GET_ITEM_INTERACTION_STATE
            if interactionState == 1204708816 or interactionState == -316468467 then
                                   -- whiskey                        -- beer

                if drunkness > 1 then
                    drunkness = 1
                else
                    drunkness = drunkness + GetFrameTime() * drunknessFactor
                end

                lastDrinkTime = GetGameTimer()
                Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), true, drunkness) -- _SET_PED_DRUNKNESS
            end
        end

        -- if drunkness > 0.6 then
        --     AnimpostfxStop(drunkEffect)
        --     AnimpostfxPlay(drunkEffect)
        --     Citizen.InvokeNative(0xCAB4DD2D5B2B7246, drunkness) -- _ANIMPOSTFX_SET_STRENGTH
        -- end

        if drunkness > 0 and ((GetGameTimer() - lastDrinkTime) > 60000 * drunkness) then -- Check if 60 seconds have passed
            drunkness = drunkness - GetFrameTime() * drunknessFactor
            if drunkness < 0 then
                drunkness = 0
                Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), false, 0) -- _SET_PED_DRUNKNESS
                -- AnimpostfxStop(drunkEffect)
            else
                Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), true, drunkness) -- _SET_PED_DRUNKNESS
            end
        end

        if (GetGameTimer() - fallTime) > maxFallTime then
            fallTime = GetGameTimer()
            maxFallTime = math.random(6000, 13000)

            local fallChance = (drunkness - 0.7) / 0.3
            if fallChance > 0 and math.random() <= fallChance then
                local ragdollDuration = math.random(1000, 3000)
                SetPedToRagdoll(PlayerPedId(), ragdollDuration, ragdollDuration, 0, false, false, false)
            end
        end

        -- Slow Walk
        if IsControlJustPressed(0, 0x8CC9CD42) then -- X
            slowWalk = not slowWalk
            if not slowWalk then
                Citizen.InvokeNative(0x433083750C5E064A, PlayerPedId(), 1.0) --SET_PED_MAX_MOVE_BLEND_RATIO
            end
        end

        if slowWalk then
            Citizen.InvokeNative(0x433083750C5E064A, PlayerPedId(), 0.3) --SET_PED_MAX_MOVE_BLEND_RATIO
        end
    end
end)