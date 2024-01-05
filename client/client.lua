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
            for _, coordx in pairs(Config.CoordinatesAll) do
                if #(coordsx.cord - playerPos) <= Config.Range then
                    TriggerEvent('vorp:TipRight', "[E] um nach dem Arzt schicken zu lassen", Config.KeyInfoVisibleDuration)
                    if keyPressed(Config.KeyBinding) then
                        --TriggerServerEvent("jsys_doctor_alert:show_info")
                        print("JSYS: execute command", coordsx.coomand)
                        ExecuteCommand(coordsx.command)
                        print("JSYS: Waiting...", Config.Cooldown * 1000, "seconds")
                        Citizen.Wait(Config.Cooldown * 1000) -- cooldown 10s
                        print("JSYS: Done waiting!")
                    end
                end
            end
            Citizen.Wait(Config.TickerCheck)
        end
    end)
end


--RegisterNetEvent("jsys_doctor_alert:show_info_client")
--AddEventHandler("jsys_doctor_alert:show_info_client", function()
--    print("JSYS: Hello Doctor!")
--    TriggerEvent('vorp:TipRight', "Someone needs a doctor in the building!", Config.VisibleDuration)
--end)


checkPlayerPos()
