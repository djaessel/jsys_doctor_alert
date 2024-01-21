-- JSYS was here! :P

local active = false
local inRange = {}
local waiting = false

function callCommandNow(index)
    waiting = true

    ExecuteCommand(Config.CoordinatesAll[index].command)
end


function indexInRange()
    local foundIndex = 0
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
    local infoCountX = 0
    local sleepCounter = 0

    for _ in pairs(Config.CoordinatesAll) do
        table.insert(inRange, false)
    end

    while active do
        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed, true, true)
        for k, coordsx in pairs(Config.CoordinatesAll) do
            local rangePos = #(coordsx.coords - playerPos)
            if rangePos <= Config.Radius then
                if !waiting and (infoCountX > Config.KeyInfoVisibleDuration or infoCountX <= 0) then
                    TriggerEvent('vorp:TipRight', Config.KeyInfoText, Config.KeyInfoVisibleDuration)
                    infoCountX = 0
                end
                inRange[k] = true
            else
                inRange[k] = false
            end
        end

        if waiting and Config.Cooldown <= sleepCounter then
            sleepCounter = 0
            waiting = false
        end

        -- wait a little between checks
        Citizen.Wait(Config.TickerCheck)
        infoCountX += Config.TickerCheck
        sleepCounter += Config.TickerCheck
    end

    print("JSYS: Exiting main loop!")
end)


Citizen.CreateThread(function()
    active = true
    local index = 0
    while active do
        index = indexInRange()
        if IsControlPressed(0, Config.KeyBinding) and index > 0 then
            if waiting then
                TriggerEvent('vorp:TipRight', Config.InfoAlreadyCalled, Config.KeyInfoVisibleDuration)
            else
                callCommandNow(index)
            end
            Citizen.Wait(Config.KeyInfoVisibleDuration)
        end
        Citizen.Wait(0)
    end
    print("JSYS: Exiting control loop!")
end)

