fx_version 'cerulean'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
author 'djaessel'
repository 'https://github.com/djaessel/jsys_doctor_alert'
description 'Doctor alert for RedM'

lua54 'yes'

shared_scripts {
  'config/*.lua'
}

client_scripts {
  'client/*.lua',
}

--server_scripts {
--  'server/*.lua',
--}

--files { 'html/**/*' }

-- version
version '0.3'

