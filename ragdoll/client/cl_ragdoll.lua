-- Key reference: https://www.rdr2mods.com/forums/topic/1575-list-of-keyboard-enums/

local ragdoll = false
local lastTimePressed = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if ragdoll then
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
        end

        local time = GetGameTimer()

        if IsControlJustPressed(1, 0xd9d0e1c0) then -- Space
            if ragdoll then
                ragdoll = false
            end

            lastTimePressed = GetGameTimer()
        end

        if IsControlJustPressed(1, 0xe30cd707) then -- Reload
            if time - lastTimePressed < 500 then
                ragdoll = true
            end
        end
    end
end)