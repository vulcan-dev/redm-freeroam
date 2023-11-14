local showMenu = false

local sndSelectName = "PURCHASE"
local sndScrollName = "NAV_DOWN"
local soundRef = "Ledger_Sounds"

local function playScrollSound()
    Citizen.CreateThread(function()
        Citizen.InvokeNative(0x67C540AA08E4A6F5, sndScrollName, soundRef, true, 0) -- PlaySoundFrontend

        local sndId = GetSoundId()
        Citizen.InvokeNative(0xCE5D0FFE83939AF1, sndId, sndScrollName, soundRef, true, 0) -- PlaySoundFrontendWithSoundId
        Citizen.InvokeNative(0x353FC880830B88FA, sndId) -- ReleaseSoundId

        Citizen.Wait(200)

        Citizen.InvokeNative(0x3210BCB36AF7621B, sndId) -- _STOP_SOUND_WITH_ID
    end)
end

local KEY_UP = 0x911CB09E
local KEY_DOWN = 0x4403F97F
local KEY_LEFT = 0xAD7FCC5B
local KEY_RIGHT = 0x65F9EC5B
local KEY_SELECT = 0xC7B5340A
local KEY_BACK = 0x308588E6

local function DrawGameText(x, y, text, r, g, b, a, scaleX, scaleY)
    SetTextScale(scaleX, scaleY)
    SetTextColor(r, g, b, a)
    local str = CreateVarString(10, "LITERAL_STRING", text)
    DisplayText(str, x, y)
end

local weaponOptionsPrompts = UipromptGroup:new("Weapon Options", false)
local removeAllPrompt = Uiprompt:new(`INPUT_OPEN_SATCHEL_MENU`, "Remove all weapons", weaponOptionsPrompts, false)
removeAllPrompt:setHoldMode(true)
removeAllPrompt:setOnHoldModeJustCompleted(function(prompt)
    RemoveAllPedWeapons(PlayerPedId(), true, true)
end)

local reloadAllPrompt = Uiprompt:new(0x760A9C6F, "Refill all ammo", weaponOptionsPrompts, false) -- G
reloadAllPrompt:setHoldMode(true)
reloadAllPrompt:setOnHoldModeJustCompleted(function(prompt)
    local ped = PlayerPedId()
    local myWeapons = GetMyWeapons()
    for hash, _ in pairs(myWeapons) do
        SetPedAmmo(ped, hash, 999999)
        SetAmmoInClip(ped, hash, 999999)
    end
end)

RegisterCommand("weps", function()
    showMenu = true
    removeAllPrompt:setEnabledAndVisible(true)
    reloadAllPrompt:setEnabledAndVisible(true)
    weaponOptionsPrompts:setActive(true)
end)

Citizen.CreateThread(function()
    local activeCategory = nil
    local lastCategory = nil

    local numCategories = #WEAPON_CATEGORIES
    local startIndex = 1
    local weaponStartIndex = 1
    local displayCount = 5

    local weapons = nil
    local numWeapons = 0
    local weapon = nil

    local topText = "1/" .. tostring(numCategories)

    while true do
        Citizen.Wait(showMenu and 0 or 100)
        if not showMenu then goto continue end

        local startY = 0.4 - ((displayCount * 0.1) / 2)

        -- Draw top text (current/maxItems)
        DrawRect(0.077, 0.20, 0.11, 0.003, 255, 255, 255, 255, true, true)
        SetTextFontForCurrentCommand(1)
        DrawGameText(0.02, 0.15, topText, 255, 255, 255, 255, 0.7, 0.7)

        if not activeCategory then
            -- Draw the category selection wheeel
            topText = tostring(startIndex) .. "/" .. tostring(numCategories)

            if IsDisabledControlJustPressed(0, KEY_DOWN) then
                playScrollSound()

                startIndex = startIndex + 1
                if startIndex > numCategories then
                    startIndex = 1
                end
            elseif IsDisabledControlJustPressed(0, KEY_UP) then
                playScrollSound()

                startIndex = startIndex - 1
                if startIndex < 1 then
                    startIndex = numCategories
                end
            elseif IsDisabledControlJustPressed(0, KEY_SELECT) or IsDisabledControlJustPressed(0, KEY_RIGHT) then
                playScrollSound()

                activeCategory = WEAPON_CATEGORIES[startIndex]

                -- If we select the same category, don't reset the last hovered index
                if lastCategory ~= activeCategory then
                    weaponStartIndex = 1
                end

                weapons = activeCategory.weapons
                numWeapons = #weapons
            elseif IsDisabledControlJustPressed(0, KEY_BACK) or IsDisabledControlJustPressed(0, KEY_LEFT) then
                playScrollSound()
                removeAllPrompt:setEnabledAndVisible(false)
                reloadAllPrompt:setEnabledAndVisible(false)
                weaponOptionsPrompts:setActive(false)
                showMenu = false
            end

            local middleIndex = startIndex -- Get the index of the middle item

            -- Display the categories
            for i = startIndex - math.floor(displayCount / 2), startIndex + math.floor(displayCount / 2) do
                local index = (i - 1) % numCategories + 1
                local displayIndex = i - startIndex + math.floor(displayCount / 2) + 1
                local color = { 255, 255, 255, 255 }

                if i == middleIndex then
                    color = { 255, 0, 0, 255 }
                    DrawRect(0.196, startY + (displayIndex * 0.117), 0.35, 0.003, color[1], color[2], color[3], color[4], true, true)
                end

                SetTextFontForCurrentCommand(1)
                DrawGameText(0.02, startY + (displayIndex * 0.1), CATEGORY_NAME[index], color[1], color[2], color[3], color[4], 0.7, 0.7)
            end
        else
            -- Draw the wheel selection wheel

            if IsDisabledControlJustPressed(0, KEY_DOWN) then
                playScrollSound()

                weaponStartIndex = weaponStartIndex + 1
                if weaponStartIndex > #activeCategory.weapons then
                    weaponStartIndex = 1
                end
            elseif IsDisabledControlJustPressed(0, KEY_UP) then
                playScrollSound()

                weaponStartIndex = weaponStartIndex - 1
                if weaponStartIndex < 1 then
                    weaponStartIndex = #activeCategory.weapons
                end
            elseif IsDisabledControlJustPressed(0, KEY_BACK) or IsDisabledControlJustPressed(0, KEY_LEFT) then
                playScrollSound()

                lastCategory = activeCategory
                activeCategory = nil
                goto continue
            end

            local startIndex = weaponStartIndex
            local middleIndex = startIndex -- Get the index of the middle item

            local myWeapons = GetMyWeapons()

            for i = startIndex - math.floor(displayCount / 2), startIndex + math.floor(displayCount / 2) do
                local index = (i - 1) % numWeapons + 1
                weapon = weapons[index]

                local name
                local dict = "multiwheel_weapons"

                if type(weapon) == "table" then
                    dict = weapon[2]
                    name = string.lower(weapon[3])
                    weapon = string.lower(weapon[1])
                else
                    name = string.lower(weapon)
                end

                local displayIndex = i - startIndex + math.floor(displayCount / 2) + 1
                local color = { 255, 255, 255, 75 }

                if myWeapons[weapon] then
                    color = { 217, 207, 119, 255 }
                end

                -- This is the weapon we're currently selecting
                if i == middleIndex then
                    if not myWeapons[weapon] then
                        color = { 255, 255, 255, 255 }
                    end

                    -- Select weapon
                    if IsDisabledControlJustPressed(0, KEY_SELECT) or IsDisabledControlJustPressed(0, KEY_RIGHT) then
                        if not myWeapons[weapon] then
                            Citizen.InvokeNative(0x67C540AA08E4A6F5, sndSelectName, soundRef, true, 0)
                            TriggerServerEvent("dbyte:weapon:request", weapon)
                        else
                            Citizen.InvokeNative(0x67C540AA08E4A6F5, sndSelectName, soundRef, true, 0)
                            RemoveWeaponFromPed(PlayerPedId(), GetHashKey(weapon), true, 0xEC7FB5D5)
                        end
                    end

                    -- Weapon text & underline
                    SetTextFontForCurrentCommand(1)
                    DrawGameText(0.17, startY + (displayIndex * 0.092), GetLabelText(weapon), color[1], color[2], color[3], color[4], 0.7, 0.7)
                    DrawRect(0.196, startY + (displayIndex * 0.117), 0.35, 0.003, color[1], color[2], color[3], color[4], true, true)
                    topText = tostring(i) .. "/" .. tostring(numWeapons)
                end

                -- Weapon icon
                HasStreamedTextureDictLoaded(dict)
                DrawSprite(dict, name, 0.09, startY + (displayIndex * 0.1), 0.15, 0.1, 0.1, color[1], color[2], color[3], color[4], 0)
            end
        end

        weaponOptionsPrompts:handleEvents()

        ::continue::
    end
end)