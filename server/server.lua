-- JSYS was here! :P

RegisterNetEvent("jsys_doctor_alert:show_info")
AddEventHandler("jsys_doctor_alert:show_info", function()
    local players = GetActivePlayers()
    local curId = 0
    for k,p in pairs(players) do
        -- TODO: find out who is doctor of current coordinates / town
        -- if doctor then
        curId = GetPlayerServerId(p)
        TriggerClientEvent("jsys_doctor_alert:show_info_client", curId)
        -- end
    end
end)
