-- JSYS was here! :P

local active = false
local inRange = {}
local waiting = false

function callCommandNow(index)
    waiting = true

    print("JSYS: execute command", Config.CoordinatesAll[index].command)
    ExecuteCommand(Config.CoordinatesAll[index].command)

    --active = false
end


function indexInRange()
    local foundIndex = -1
    if #inRange > 0 then
        for i, _ in pairs(Config.CoordinatesAll) do
            if inRange[i] then
                foundIndex = i
            end
        end
    end
    return foundIndex
end


Citizen.CreateThread(function ()
    active = true
    local infoCountX = -1

    for i, _ in pairs(Config.CoordinatesAll) do
        table.insert(inRange, false)
    end

    while active do
        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed, true, true)
        for k, coordsx in pairs(Config.CoordinatesAll) do
            local rangePos = #(coordsx.coords - playerPos)
            if rangePos <= Config.Radius then
                if infoCountX > Config.KeyInfoVisibleDuration or infoCountX < 0 then
                    TriggerEvent('vorp:TipRight', "[R] um nach dem Arzt schicken zu lassen", Config.KeyInfoVisibleDuration)
                    infoCountX = 0
                end
                inRange[k] = true
            else
                inRange[k] = false
            end
        end

        if waiting then
            print("JSYS: Waiting main loop...", Config.Cooldown, "ms")
            Citizen.Wait(Config.Cooldown)
            waiting = false
            print("JSYS: Done waiting main loop!")
        end

        -- wait a little between checks
        Citizen.Wait(Config.TickerCheck)
        infoCountX += Config.TickerCheck
    end

    print("JSYS: Exiting main loop!")
end)


Citizen.CreateThread(function()
    active = true
    local index = -1
    while active do
        index = indexInRange()
        if IsControlPressed(0, Config.KeyBinding) and index > 0 then
            if waiting then
                TriggerEvent('vorp:TipRight', "Du hast gerade schon den Arzt gerufen!", Config.KeyInfoVisibleDuration)
            else
                callCommandNow(index)
            end
            Citizen.Wait(Config.KeyInfoVisibleDuration)
        end
        Citizen.Wait(0)
    end
    print("JSYS: Exiting control loop!")
end)

