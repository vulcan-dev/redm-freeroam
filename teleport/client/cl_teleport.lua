-- Locations
---------------------------------------

-- https://www.rdr2mods.com/wiki/pages/list-of-rdr2-teleports/
local locations = {
    ["strawberry" ] = { -1731.426,  -412.8995,   154.8678  },
    ["armadillo"  ] = { -3665.947,  -2612.442,   -14.08434 },
    ["tumbleweed" ] = { -5517.375,  -2936.821,   -2.219434 },
    ["stdenis"    ] = { 2209.557,   -1346.319,   45.27962  },
    ["rhodes"     ] = { 1232.205,   -1251.088,   73.67763  },
    ["annesburg"  ] = { 2904.366,   1248.808,    44.87448  },
    ["blackwater" ] = { -798.9842,  -1247.722,   43.42519  },
    ["mexico"     ] = { -2179.264,  -3382.99,    32.82836  },
    ["lagras"     ] = { 2105.414,   -682.1608,   42.2669   },
    ["vanhorn"    ] = { 2983.451,   430.152,     51.17512  },
    ["valentine"  ] = { -231.3357,  703.2683,    113.7415  },
    ["guarmafort" ] = { 999.9134,   -6749.735,   63.12267  },
    ["guarmabeach"] = { 1997.57,    -4499.807,   41.77455  },
    ["theatre"    ] = { 2683.063,   -1365.809,   47.4687   },
    ["manor"      ] = { 1014.1894,  -1377.9666,  53.6058   }
}

-- Teleport Event
---------------------------------------
RegisterNetEvent("dbyte:teleport")
AddEventHandler("dbyte:teleport", function (target)
    local entity = PlayerPedId()
    local horse = GetMount(PlayerPedId())
    if DoesEntityExist(horse) then entity = horse end

    -- https://github.com/kurdt94/k_teleport/blob/3946ed30e0584249ce5d18eae6062f97a6345ddf/client.lua#LL45C1-L64C8
    -- Yes, I may have borrowed this. I lost my old stuff and can't be arsed figuring it out again, I've written similar
    -- code to this so it now counts as mine.

    if target.z == 0.0 then
        DoScreenFadeOut(1000)
        Wait(1000)

        Citizen.InvokeNative(0x65C16D57, entity, true)
        SetEntityCoords(entity, target.x, target.y, 0)

        for height = -50.0, 1000.0 do
            print("checking: ", height)
            repeat Wait(0) until HasCollisionLoadedAroundEntity(entity)

            SetEntityCoords(entity, target.x, target.y, height)
            local foundground = GetGroundZAndNormalFor_3dCoord(target.x + 0.0, target.y + 0.0, height)
            if foundground then
                Citizen.InvokeNative(0x5D1EB123EAC5D071, 0.0, 1065353216) -- SET_GAMEPLAY_CAM_RELATIVE_HEADING
                break
            end
        end

        Citizen.InvokeNative(0x65C16D57, entity, false)
        DoScreenFadeIn(1000)
    else
        SetEntityCoords(entity, target.x, target.y, target.z)
        Citizen.InvokeNative(0x5D1EB123EAC5D071, 0.0, 1065353216) -- SET_GAMEPLAY_CAM_RELATIVE_HEADING
    end
end)

RegisterNetEvent("dbyte:teleportTo")
AddEventHandler("dbyte:teleportTo", function(pos)
    local entity = GetPlayerPed(PlayerId())
    local horse = GetMount(PlayerPedId())
    if DoesEntityExist(horse) then entity = horse end

    SetEntityCoords(entity, pos.x, pos.y, pos.z, true, false, false, false)
end)

-- Commands
---------------------------------------
local function tpWaypoint()
    local pos = GetWaypointCoords()
    TriggerServerEvent("dbyte:requestTeleport", { x = pos.x, y = pos.y, z = pos.z })
end

RegisterCommand("waypoint", tpWaypoint)
RegisterCommand("wp", tpWaypoint)

for locationName, location in pairs(locations) do
    RegisterCommand(locationName, function()
        TriggerServerEvent("dbyte:requestTeleport", { x = location[1], y = location[2], z = location[3] })
    end)
end

TriggerEvent('chat:addSuggestion', '/waypoint', 'Teleports you to your waypoint')
TriggerEvent('chat:addSuggestion', '/wp', 'Teleports you to your waypoint')
TriggerEvent("chat:addSuggestion", "/tp", "Teleport via ID or Partial Name")