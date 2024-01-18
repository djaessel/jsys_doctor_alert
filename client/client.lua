-- JSYS was here! :P

local active = false
local inRange = {}

function callCommandNow()
    print("JSYS: execute command", coordsx.coomand)
    ExecuteCommand(coordsx.command)

    print("JSYS: Waiting...", Config.Cooldown, "seconds")
    Citizen.Wait(Config.Cooldown)
    print("JSYS: Done waiting!")
    active = false
end

--function tablelength(T)
--    local count = 0
--    for _ in pairs(T) do count = count + 1 end
--    return count
--end

function isOneInRange()
    local success = false
    if #inRange > 0 then
        for i, _ in pairs(Config.CoordinatesAll) do
            if inRange[i] then
                success = true
            end
        end
    end
    return success
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
                if infoCountX >= Config.KeyInfoVisibleDuration or infoCountX < 0 then
                    TriggerEvent('vorp:TipRight', "[R] um nach dem Arzt schicken zu lassen", Config.KeyInfoVisibleDuration)
                    infoCountX = 0
                end
                inRange[k] = true
            else
                inRange[k] = false
            end
        end
        -- wait a little between checks
        Citizen.Wait(Config.TickerCheck)
        infoCountX += Config.TickerCheck
    end

    print("JSYS: Exiting main loop!")
end)

Citizen.CreateThread(function()
    active = true
    while active do
        if IsControlPressed(0, Config.KeyBinding) and isOneInRange() then
            callCommandNow()
        end
        Citizen.Wait(0)
    end
    print("JSYS: Exiting control loop!")
end)


function createAndRunPrompt()
    active = true

    Citizen.CreateThread(function()
        print("JSYS: Waiting for player spawn...")

        while PlayerPedId() < 0 do
            Citizen.Wait(1000)
        end

        print("JSYS: Player spawned! (?)")

        -----------------------------------------

        print("JSYS: Registering prompts!")

        local prompt = PromptRegisterBegin()
        PromptSetControlAction(prompt, GetHashKey("INPUT_CONTEXT_X")) -- R key
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "[R] um nach dem Arzt schicken zu lassen"))
        
        PromptSetStandardMode(prompt, true)
        PromptSetPriority(prompt, 1);
        PromptSetTransportMode(prompt, 0);
        --PromptSetAttribute(prompt, 18, 1);
        --PromptSetStandardizedHoldMode(prompt, 1704213876);

        local position = Config.CoordinatesAll[1].coords
        local radius = Config.Radius
        -- _UI_PROMPT_CONTEXT_SET_POINT
        Citizen.InvokeNative(0xAE84C5EE2C384FB3, prompt, position.x, position.y, position.z)
        -- _UI_PROMPT_CONTEXT_SET_RADIUS
        Citizen.InvokeNative(0x0C718001B77CA468, prompt, radius)

        PromptRegisterEnd(prompt)

        PromptSetEnabled(prompt, true)
        PromptSetVisible(prompt, true)

        print("JSYS: Prompts successfully registered!")
        print("JSYS: Prompt valid >", PromptIsValid(prompt))
        print("JSYS: Prompt active >", PromptIsActive(prompt))

        -----------------------------------------

        while active do
            if PromptIsActive(prompt) then
                if PromptIsPressed(prompt) then
                    print("JSYS: You pressed R!!!")
                    print("JSYS: execute command", Config.CoordinatesAll[1].coomand)
                    ExecuteCommand(Config.CoordinatesAll[1].command)
                    print("JSYS: Waiting...", Config.Cooldown, "seconds")
                    Citizen.Wait(Config.Cooldown)
                    print("JSYS: Done waiting!")
                    active = false -- deactivate after debugging!!!
                end
            end
            Citizen.Wait(0)
            --Citizen.Wait(Config.TickerCheck)
        end

        -----------------------------------------

        print("JSYS: Exiting loop!!!")
        PromptDelete(prompt)
        print("JSYS: Prompt deactivated!!!")
    end)
end

--createAndRunPrompt()
