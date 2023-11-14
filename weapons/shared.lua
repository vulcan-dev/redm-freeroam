CATEGORY_NAME = {
    "Pistols",
    "Melee",
    "Shotguns",
    "Rifles",
    "Repeaters",
    "Thrown",
    "Other"
}

-- TODO: Find missing textures

WEAPON_CATEGORIES = { -- https://www.rdr2mods.com/wiki/pages/list-of-rdr2-weapon-models/
    {
        index = 1,
        weapons = {
            "WEAPON_REVOLVER_CATTLEMAN",
            "WEAPON_REVOLVER_CATTLEMAN_JOHN",
            "WEAPON_REVOLVER_CATTLEMAN_MEXICAN",
            "WEAPON_REVOLVER_CATTLEMAN_PIG",
            "WEAPON_REVOLVER_DOUBLEACTION_MICAH",
            "WEAPON_REVOLVER_DOUBLEACTION_GAMBLER",
            "WEAPON_REVOLVER_DOUBLEACTION_EXOTIC",
            "WEAPON_REVOLVER_SCHOFIELD_CALLOWAY",
            "WEAPON_REVOLVER_SCHOFIELD_GOLDEN",
            "WEAPON_REVOLVER_DOUBLEACTION",
            "WEAPON_REVOLVER_SCHOFIELD",
            "WEAPON_REVOLVER_LEMAT",
            "WEAPON_PISTOL_VOLCANIC",
            "WEAPON_PISTOL_M1899",
            "WEAPON_PISTOL_MAUSER",
            "WEAPON_PISTOL_MAUSER_DRUNK",
            "WEAPON_PISTOL_SEMIAUTO"
        }
    },
    {
        index = 2,
        weapons = {
            "WEAPON_MELEE_KNIFE",
            "WEAPON_MELEE_KNIFE_JAWBONE",
            "WEAPON_MELEE_KNIFE_MINER",
            "WEAPON_MELEE_KNIFE_VAMPIRE",
            "WEAPON_MELEE_KNIFE_CIVIL_WAR",
            "WEAPON_MELEE_KNIFE_BEAR",
            "WEAPON_MELEE_BROKEN_SWORD",
            "WEAPON_MELEE_CLEAVER",
            "WEAPON_MELEE_HATCHET",
            "WEAPON_MELEE_MACHETE",
            "WEAPON_MELEE_TORCH",
            "WEAPON_MELEE_ANCIENT_HATCHET",
            "WEAPON_MELEE_HATCHET_VIKING",
            "WEAPON_MELEE_HATCHET_HEWING",
            "WEAPON_MELEE_HATCHET_HUNTER",
            "WEAPON_MELEE_HATCHET_HUNTER_RUSTED",
            "WEAPON_MELEE_HATCHET_DOUBLE_BIT",
            "WEAPON_MELEE_HATCHET_DOUBLE_BIT_RUSTED"
        }
    },
    {
        index = 3,
        weapons = {
            "WEAPON_SHOTGUN_DOUBLEBARREL",
            "WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC",
            "WEAPON_SHOTGUN_SAWEDOFF",
            "WEAPON_SHOTGUN_REPEATING",
            "WEAPON_SHOTGUN_PUMP",
            "WEAPON_SHOTGUN_SEMIAUTO"
        }
    },
    {
        index = 4,
        weapons = {
            "WEAPON_RIFLE_VARMINT",
            "WEAPON_RIFLE_SPRINGFIELD",
            "WEAPON_RIFLE_BOLTACTION",
            "WEAPON_SNIPERRIFLE_ROLLINGBLOCK",
            "WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC",
            "WEAPON_SNIPERRIFLE_CARCANO",
        }
    },
    {
        index = 5,
        weapons = {
            "WEAPON_REPEATER_CARBINE",
            "WEAPON_REPEATER_WINCHESTER",
            "WEAPON_REPEATER_HENRY",
            "WEAPON_REPEATER_EVANS"
        }
    },
    {
        index = 5,
        weapons = {
            "WEAPON_THROWN_DYNAMITE",
            "WEAPON_THROWN_MOLOTOV",
            "WEAPON_THROWN_THROWING_KNIVES",
            "WEAPON_THROWN_TOMAHAWK",
            { -- WEAPON_THROWN_TOMAHAWK_ANCIENT uses a different texture
                "WEAPON_THROWN_TOMAHAWK_ANCIENT",
                "menu_textures",
                "cross"
            }
        }
    },
    {
        index = 6,
        weapons = {
            "WEAPON_BOW",
            "WEAPON_LASSO",
            "WEAPON_FISHINGROD",
            "WEAPON_MOONSHINEJUG",
            "WEAPON_KIT_CAMERA",
            {
                "WEAPON_MELEE_LANTERN",
                "menu_textures",
                "cross"
            },
            "WEAPON_MELEE_DAVY_LANTERN"
        }
    }
}

function GetMyWeapons()
    local weapons = {}
    for _, category in ipairs(WEAPON_CATEGORIES) do
        for _, weapon in ipairs(category.weapons) do
            local name = weapon
            if type(weapon) == "table" then
                name = weapon[1]
            end
            if Citizen.InvokeNative(0xDBC4B552B2AE9A83, PlayerPedId(), GetHashKey("SLOT_" .. name:sub(8, #name))) then -- GetPedWeaponInSlot
                weapons[name] = true
            end
        end
    end
    return weapons
end