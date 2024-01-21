fx_version 'cerulean'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
author 'djaessel'
repository 'https://github.com/djaessel/jsys_doctor_alert'
description 'JSYS - Call doctor per command and coordinates'
version '0.7'

lua54 'yes'

client_scripts {
  'client/client.lua',
  'config/config.lua'
}

