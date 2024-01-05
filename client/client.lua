-- JSYS was here! :P

function keyPressed(key)
    IsControlJustPressed(0, key)
end

local active = false
function checkPlayerPos()
    active = true
    Citizen.CreateThread(function ()
        local ped = PlayerPedId()
        while active do
            local playerPos = GetEntityCoords(ped)
            for coordx in Config.CoordinatesAll do
                if #(coordsx - playerPos) <= Config.Range then
                    if keyPressed(Config.KeyBinding) then
                        TriggerServerEvent("jsys_doctor_alert:show_info")
                        Citizen.Wait(Config.Cooldown * 1000) -- cooldown 10s
                    end
                end
            end
            Citizen.Wait(Config.TickerCheck)
        end
    end)
end


RegisterNetEvent("jsys_doctor_alert:show_info_client")
AddEventHandler("jsys_doctor_alert:show_info_client", function()
    print("JSYS: Hello Doctor!")
    TriggerEvent('vorp:TipRight', "Someone needs a doctor in the building!", Config.VisibleDuration)
end)


checkPlayerPos()
