fx_version 'cerulean'
game 'gta5'

author 'Marcos Gomez Alvarez'
description 'A script where a suitcase is put on hand if player have an amount of money'
version '1.0.0'

client_script {
    'client/client.lua',
    'config.lua',
    '@mysql-async/lib/MySQL.lua'
}
server_script {
    'server/server.lua',
    'config.lua',
    '@mysql-async/lib/MySQL.lua'
}

shared_script '@es_extended/imports.lua'
