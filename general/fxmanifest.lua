-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

version "1.0.0"
description ""
repository ""
author ""

fx_version "bodacious"
game "rdr3"

client_script {
    "@uiprompt/uiprompt.lua",
    "client/cl_general.lua",
    "client/cl_horse.lua",
    "client/cl_door_hashes.lua",
    "client/cl_doors.lua"
}

server_script {
    "server/sv_general.lua",
    "server/sv_doors.lua"
}

rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

--dependency "cfx.re/playerData.v1alpha1"
lua54 "yes"
