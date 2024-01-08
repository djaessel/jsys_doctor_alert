-- JSYS was here! :P

function keyPressed(key)
    IsControlJustPressed(0, key)
end

local active = false
function checkPlayerPos()
    active = true
    Citizen.CreateThread(function ()
        local infoCountX = -1
        while active do
            local playerPed = PlayerPedId()
            local playerPos = GetEntityCoords(playerPed, true, true)
            for _, coordsx in pairs(Config.CoordinatesAll) do
                local rangePos = #(coordsx.coords - playerPos)
                if rangePos <= Config.Range then
                    if math.floor(infoCountX / 1000) >= Config.KeyInfoVisibleDuration or infoCountX < 0 then
                        TriggerEvent('vorp:TipRight', "[R] um nach dem Arzt schicken zu lassen", Config.KeyInfoVisibleDuration)
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
                        active = false
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
