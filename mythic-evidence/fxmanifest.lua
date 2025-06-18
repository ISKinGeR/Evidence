fx_version 'cerulean'
games {'gta5'} -- 'gta5' for GTAv / 'rdr3' for Red Dead 2, 'gta5','rdr3' for both
lua54 'yes'

client_script "@mythic-base/components/cl_error.lua"
client_script "@mythic-pwnzor/client/check.lua"
server_script "@oxmysql/lib/MySQL.lua"

description 'mythic Evidence System'
name 'mythic-Evidence'
author 'Dr Nick'
version 'v1.0.0'


server_scripts {
    'shared/**/*.lua',
    'server/**/*.lua',
}

client_scripts {
    'shared/**/*.lua',
    'client/**/*.lua',
}