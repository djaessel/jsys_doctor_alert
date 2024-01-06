-- JSYS was here! :P

function keyPressed(key)
    IsControlJustPressed(0, key)
end

local active = false
function checkPlayerPos()
    active = true
    Citizen.CreateThread(function ()
        local ped = PlayerPedId()
        local infoCountX = -1
        while active do
            local playerPos = GetEntityCoords(ped)
            for _, coordx in pairs(Config.CoordinatesAll) do
                if #(coordsx.cord - playerPos) <= Config.Range then
                    if math.floor(infoCountX / 1000) >= Config.KeyInfoVisibleDuration or infoCountX < 0 then
                        TriggerEvent('vorp:TipRight', "[E] (INPUT_CONTEXT_Y) um nach dem Arzt schicken zu lassen", Config.KeyInfoVisibleDuration)
                        infoCountX = 0
                    end
                    if keyPressed(Config.KeyBinding) then
                        --TriggerServerEvent("jsys_doctor_alert:show_info")
                        print("JSYS: execute command", coordsx.coomand)
                        ExecuteCommand(coordsx.command)

                        local cooldown = Config.Cooldown * 1000 -- convert to seconds
                        print("JSYS: Waiting...", cooldown, "seconds")
                        Citizen.Wait(cooldown)
                        print("JSYS: Done waiting!")
                    end
                end
            end
            -- wait a little between checks
            Citizen.Wait(Config.TickerCheck)
            infoCountX += Config.TickerCheck
        end
    end)
end


--RegisterNetEvent("jsys_doctor_alert:show_info_client")
--AddEventHandler("jsys_doctor_alert:show_info_client", function()
--    print("JSYS: Hello Doctor!")
--    TriggerEvent('vorp:TipRight', "Someone needs a doctor in the building!", Config.VisibleDuration)
--end)


checkPlayerPos()
