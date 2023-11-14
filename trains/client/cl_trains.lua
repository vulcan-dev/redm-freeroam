local trainHashes = {
    -1464742217,
    -577630801,
    -1901305252,
    -1719006020,
    519580241,
    1495948496,
    1365127661,
    -1083616881,
    1030903581,
    -2006657222,
    1285344034,
    -156591884,
    987516329,
    -1740474560,
    -651487570,
    -593637311,
    1094934838,
    1054492269,
    1216031719,
}

local currentTrain = nil

local function performRequest(hash)
    print("requesting model " .. hash)
    
    if HasModelLoaded(hash) == 1 then return end

    Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0) -- RequestModel

    local times = 1
    while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do -- HasModelLoaded
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0) -- RequestModel

        times = times + 1
        Citizen.Wait(0)
        
        if times >= 100 then break end
    end
end
 
local function spawnTrain(n, speed)
    local trainHash = trainHashes[n]
    local trainWagons = N_0x635423d55ca84fc8(trainHash)
    for wagonIndex = 0, trainWagons - 1 do
        local trainWagonModel = N_0x8df5f6a19f99f0d5(trainHash, wagonIndex)
        performRequest(trainWagonModel)
    end

    local train = N_0xc239dbd9a57d2a71(trainHash, GetEntityCoords(PlayerPedId()), 0, 0, 1, 1)
    -- SetTrainSpeed(train, 0.0)
    -- TaskWarpPedIntoVehicle(PlayerPedId(), train, -1)
    currentTrain = train
    SetTrainSpeed(train, speed)
end

local function clearTrains()
    local vehicles = GetGamePool("CVehicle")
    for _, v in pairs(vehicles) do
        local carriage_idx = Citizen.InvokeNative(0x4B8285CF, v) -- GET_TRAIN_CARRIAGE_INDEX
        if carriage_idx then
            DeleteEntity(carriage_idx)
        end
    end
end

RegisterCommand("train", function(source, args)
    local n = tonumber(args[1])
    local speed = (tonumber(args[2]) or 10) + 0.0
    if currentTrain then
        DeleteEntity(currentTrain)
    end

    spawnTrain(n, speed)
end)

RegisterCommand("clearTrains", clearTrains)