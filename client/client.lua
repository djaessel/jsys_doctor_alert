-- JSYS was here! :P



local active = false
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

createAndRunPrompt()
