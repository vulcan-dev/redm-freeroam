-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

version "1.0.0"
description "An example money system using KVS."
repository "https://github.com/citizenfx/cfx-server-data"
author "Cfx.re <root@cfx.re>"

fx_version "bodacious"
game "rdr3"

client_script {
    "@uiprompt/uiprompt.lua",
    "client/cl_weapons.lua",
    "client/cl_weaponMenu.lua",
    "client/cl_loadout.lua",
    "shared.lua"
}
server_script {
    "server/sv_weapons.lua",
    "server/sv_loadout.lua",
    "shared.lua"
}
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

--dependency "cfx.re/playerData.v1alpha1"
lua54 "yes"
