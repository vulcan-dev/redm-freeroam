-- Not fully functional, still WIP. Just busy.

local doorHashes = exports.general["doorHashes"]()
local doors = {}

local jailDoors = {
    [1878514758] = true,
    [4173092066] = true,
    [4016307508] = true,
    [4235597664] = true,
    [193903155] = true,
    [295355979] = true,
    [535323366] = true,
    [343819720] = true,
    [1502928852] = true,
    [1657401918] = true,
    [831345624] = true,
    [2677989449] = true,
    [2984805596] = true,
    [902070893] = true,
    [1207903970] = true,
    [1711767580] = true,
    [1995743734] = true,
    [2515591150] = true,
    [3365520707] = true,
    [2167775834] = true,
    [2514996158] = true,
    [3173783190] = true,
    [3387994139] = true,
    [1337407471] = true,
    [1744201837] = true,
    [1982006478] = true,
    [2423077218] = true,
    [4192865366] = true
}

local doorStates = {}

local activeDoorHash = nil
local handlePos = nil
local lastWeapon = `WEAPON_UNARMED`

local doorPromp = UipromptGroup:new("Door Options", false)
local lockPrompt = Uiprompt:new(`INPUT_DYNAMIC_SCENARIO`, "Lock", doorPromp, false)
lockPrompt:setHoldMode(true)
lockPrompt:setOnHoldModeJustCompleted(function(prompt)

end)

lockPrompt:setOnHoldModeRunning(function(prompt)
    if not handlePos then return end

    lastWeapon = Citizen.InvokeNative(0x8425C5F057012DAB)
    SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)

    SetIkTarget(
        PlayerPedId(),
        4,
        nil,
        nil,    
        handlePos.x,
        handlePos.y,
        handlePos.z,
        0.0,
        600,
        600
    )
end)

lockPrompt:setOnControlJustReleased(function(prompt)
    if not activeDoorHash or not Citizen.InvokeNative(0xD99229FE93B46286, activeDoorHash) then print("Invalid Door") return end

    local animDict = "script_common@jail_cell@unlock@key"
    RequestAnimDict(animDict)
    repeat Wait(0) until HasAnimDictLoaded(animDict) 
    -- SetPedDesiredrot(PlayerPedId(), 50.0)
    TaskPlayAnim(PlayerPedId(), animDict, "action", 8.0, -8.0, 2550, 10, 0, true, 0, false, 0, false) 
    Wait(1400)

    -- Citizen.InvokeNative(0xCCE219C922737BFA, "Padlock_Impact", GetEntityCoords(PlayerPedId()), "UTP2_Sounds", true, 0, true, 0) 
    Citizen.InvokeNative(0xD9130842D7226045, "Mud5_Sounds", true) -- PREPARE_SOUNDSET

    Citizen.InvokeNative(0xCCE219C922737BFA, "Small_Safe_Unlock", GetEntityCoords(PlayerPedId()), "Mud5_Sounds", true, 0, true, 0)
    
    print("activeDoorHash", activeDoorHash)
    TriggerServerEvent("dbyte:doors:toggleLock", activeDoorHash)
    Citizen.InvokeNative(0x531A78D6BF27014B) -- RELEASE_SOUNDSET

    SetCurrentPedWeapon(PlayerPedId(), lastWeapon, true)
end)

local wasFacing = false

local function setDoorLocked(hash, locked)
    -- if doorStates[hash] == nil then -- DOOR_SYSTEM_GET_DOOR_STATE
    --     print("Added door", hash, locked)
    --     Citizen.InvokeNative(0xD99229FE93B46286, hash, 1, 0, 0, 0, 0, 0) -- _ADD_DOOR_TO_SYSTEM_NEW
    -- end

    Citizen.InvokeNative(0x6BAB9442830C7F53, hash, locked and 1.0 or 0.0) -- DOOR_SYSTEM_SET_DOOR_STATE

    if locked then
        Citizen.InvokeNative(0xB6E6FBA95C7324AC, hash, 0.0, true) -- DOOR_SYSTEM_SET_OPEN_RATIO
    end

    doorStates[hash] = locked
    print(hash, locked)
end

RegisterNetEvent("dbyte:doors:lock", function(hash, locked)
    setDoorLocked(hash, locked)
end)

RegisterNetEvent("dbyte:doors:sync", function(doors)
    for hash, locked in pairs(doors) do
        if not Citizen.InvokeNative(0xD99229FE93B46286, hash) then -- DOOR_SYSTEM_GET_DOOR_STATE
            setDoorLocked(hash, locked)
        end
    end
end)

local doorData = {}

-- function dot(v1, v2)
--     local result = 0
--     result = result + v1.x * v2.x
--     result = result + v1.y * v2.y
--     result = result + v1.z * v2.z
-- 
--     return result
-- end

function RotationToDirection(rotation)
    local z = math.rad(rotation.z)
    local x = math.rad(rotation.x)
    local num = math.abs(math.cos(x))

    local direction = vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
    return direction
end

function DrawText2D(x, y, text)
	SetTextScale(0.35, 0.35)
	SetTextColor(255, 255, 255, 255)
	SetTextDropshadow(1, 0, 0, 0, 200)
	SetTextFontForCurrentCommand(0)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

function DrawText3D(x, y, z, text)
	local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(x, y, z)
	SetTextScale(0.35, 0.35)
	SetTextFontForCurrentCommand(1)
	SetTextColor(255, 255, 255, 223)
	SetTextCentre(1)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), screenX, screenY)
end

AddEventHandler("onResourceStop", function(res)
    if GetCurrentResourceName() ~= res then return end

    print("Unlocking all locked doors")
    for hash, locked in pairs(doorStates) do
        if locked then
            setDoorLocked(hash, false)
            Citizen.InvokeNative(0x464D8E1427156FE4, hash) -- REMOVE_DOOR_FROM_SYSTEM
        end

        doorStates[hash] = false
        print("Unlocking", hash)
    end

    for hash, door in pairs(doorHashes) do
        Citizen.InvokeNative(0x464D8E1427156FE4, hash) -- REMOVE_DOOR_FROM_SYSTEM
    end
end)

local firstLoad = true

AddEventHandler("onClientResourceStart", function(res)
    if GetCurrentResourceName() ~= res then return end
    doors = DoorSystemGetActive()
    for k, v in pairs(doors) do
        print(k)
    end

    print("Syncing Doors")
    TriggerServerEvent("dbyte:doors:requestSync")

    for i, door in pairs(doors) do
        local entity = Citizen.InvokeNative(0xF7424890E4A094C0, door[1], 0) -- Get door entity from hash
        table.insert(doorData, { door[1], entity })
    end

    for hash, door in pairs(doorHashes) do
        Citizen.InvokeNative(0xD99229FE93B46286, hash, 1, 0, 0, 0, 0, 0) -- _ADD_DOOR_TO_SYSTEM_NEW
    end
end)
-- 
-- RegisterNetEvent("playerSpawned")
-- AddEventHandler("playerSpawned", function()
--     -- print("firstLoad", firstLoad)
--     -- if not firstLoad then return end
--     -- for hash, door in pairs(doorHashes) do
--     --     Citizen.InvokeNative(0xD99229FE93B46286, hash, 1, 0, 0, 0, 0, 0) -- Add door to system
--     -- end
-- 
--     doors = DoorSystemGetActive()
--     for k, v in pairs(doors) do
--         print(k)
--     end
-- 
--     print("Syncing Doors")
--     TriggerServerEvent("dbyte:doors:requestSync")
-- 
--     for i, door in pairs(doors) do
--         local entity = Citizen.InvokeNative(0xF7424890E4A094C0, door[1], 0) -- Get door entity from hash
--         table.insert(doorData, { door[1], entity })
--     end
-- 
--     firstLoad = false
-- end)

local debug = true
CreateThread(function()
    local hasDoors = false

    while true do
        Wait(0)

        if not hasDoors then
            doors = DoorSystemGetActive()
            if doors and doors[1] then
                hasDoors = true
                for k, v in pairs(doors) do
                    print(k)
                end
    
                print("Syncing Doors")
                TriggerServerEvent("dbyte:doors:requestSync")
            
                for i, door in pairs(doors) do
                    local entity = Citizen.InvokeNative(0xF7424890E4A094C0, door[1], 0) -- Get door entity from hash
                    table.insert(doorData, { door[1], entity })
                end
            end

            goto continue
        end

        local ply = PlayerPedId()
        if not ply then goto continue end

        doorPromp:handleEvents()
        
        local plyPos = GetEntityCoords(ply)
        local shouldShowPrompt = false

        for _, door in ipairs(doorData) do
            local hash = door[1]
            local entity = door[2]

            local coords = GetWorldPositionOfEntityBone(entity, 1)
            local doorCoords = GetEntityCoords(entity)

            -- local pos = { x = coords.x, y = coords.y, z = coords.z }
            local diff = #(plyPos - coords)

            if diff <= 1.5 then
                local is_jail = jailDoors[door[1]]
                local is_valid = false

                -- local doorEntity = Citizen.InvokeNative(0xF7424890E4A094C0, hash, 0)
            
                --local is_facing = Citizen.InvokeNative(0xE88F19660651D566, ply, doorEntity, 0) -- HAS_ENTITY_CLEAR_LOS_TO_ENTITY_IN_FRONT
                --local is_facing = Citizen.InvokeNative(0xD3151E53134595E5, ply, plyPos, doorCoords, 0.1, false, false, 0)
                --print("is_facing", is_facing)

                local camRot = GetGameplayCamRot(2)
                local forwardVector = RotationToDirection(camRot)

                -- print("forwardVector", forwardVector)
                -- print("GetEntityForwardVector(ply)", GetEntityForwardVector(ply))

                local endl = plyPos + GetEntityForwardVector(ply) * 4.0

                local r = Citizen.InvokeNative(0x377906D8A31E5586, plyPos.x, plyPos.y, plyPos.z, endl.x, endl.y, endl.z, 16, PlayerPedId(), 4)
                local ret, hit, endCoords, n, entHit = GetShapeTestResult(r)
                if debug then DrawText2D(0.01, 0.01, string.format("%d %d %f,%f,%f %f,%f,%f", ret, hit, endCoords.x, endCoords.y, endCoords.z, n.x, n.y, n.z)) end
                -- print(hit)

                -- local p = GetEntityCoords(hit)
                local is_facing = hit == 1

                local entity_forward = GetEntityForwardVector(entity)
                local ply_forward = GetEntityForwardVector(ply)
                local plyRot = GetEntityRotation(ply)

                local dp_ply = dot(entity_forward, ply_forward)
                local dp_cam = dot(forwardVector, ply_forward)

                if debug then
                    DrawText2D(0.01, 0.13, "dpPly: " .. tostring(dp_ply))
                    DrawText2D(0.01, 0.16, "dpCam: " .. tostring(dp_cam))
                    DrawText2D(0.01, 0.19, "plyRot: " .. string.format("%f %f %f", camRot.x, camRot.y, camRot.z))
                    DrawText2D(0.01, 0.21, "camRot: " .. string.format("%f %f %f", camRot.x, camRot.y, camRot.z))
                end

                if hit == 1 and entHit == entity then
                    local d = #(endCoords - endl)

                    --Citizen.InvokeNative(0x2A32FAA57B937173, 0x94FDAE17, endCoords, 0.0, 0.0, 0.0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, false, false, false) 
                    if debug then
                        Citizen.InvokeNative(0x2A32FAA57B937173, 0x94FDAE17, endl - d, 0.0, 0.0, 0.0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 255, false, false, false, false) 
                        Citizen.InvokeNative(0x2A32FAA57B937173, 0x94FDAE17, GetEntityCoords(entHit), 0.0, 0.0, 0.0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 0, 255, false, false, false, false) 

                        DrawText2D(0.01, 0.04, "Active Door: " .. tostring(door[1]))
                        DrawText2D(0.01, 0.07, "State: " .. (doorStates[door[1]] == true and "locked" or "unlocked"))
                        DrawText2D(0.01, 0.10, "Normal: " .. string.format("%f %f %f", n.x, n.y, n.z))
                    end
                    
                    -- SetPedDesiredHeading(ply, GetEntityHeading(entHit))

                    if not is_jail then
                        is_valid = true
                    else
                        -- We want to make sure we are only facing the front of the door. Cannot lock/unlock from behind
                        if dp_ply > 0 then
                            is_valid = true
                        end
                    end

                    if is_valid then
                        shouldShowPrompt = true
                        handlePos = coords

                        activeDoorHash = door[1]
                        if doorStates[activeDoorHash] then
                            lockPrompt:setText("Unlock")
                        else
                            lockPrompt:setText("Lock")
                        end

                        lockPrompt:setEnabledAndVisible(true)
                    else
                        shouldShowPrompt = false
                        activeDoorHash = nil
                    end
                end
            end

            -- shouldShowPrompt is now false, but if I put it before the "end" above, it's true
            -- print("shouldShowPrompt", shouldShowPrompt)
            if shouldShowPrompt then
                -- print("bone", GetWorldPositionOfEntityBone(entity, 1))
                -- print("coords", coords)

                -- print(door[1], doorStates[door[1]])

                doorPromp:setActive(true)
            else
                doorPromp:setActive(false)
            end
        end

        ::continue::
    end
end)