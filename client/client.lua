-- JSYS was here! :P



local active = false
function createAndRunPrompt()
    active = true

    Citizen.CreateThread(function()
        Citizen.Wait(60000) -- wait 60 seconds
        
        -----------------------------------------

        print("JSYS: Registering prompts!")

        local prompt = PromptRegisterBegin()
        PromptSetControlAction(prompt, GetHashKey("INPUT_CONTEXT_X")) -- R key
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "[R] um nach dem Arzt schicken zu lassen"))

        local position = Config.CoordinatesAll[0].coords
        local radius = Config.Radius
        -- _UI_PROMPT_CONTEXT_SET_POINT
        Citizen.InvokeNative(0xAE84C5EE2C384FB3, prompt, position.x, position.y, position.z)
        -- _UI_PROMPT_CONTEXT_SET_RADIUS
        Citizen.InvokeNative(0x0C718001B77CA468, prompt, radius)

        PromptRegisterEnd(prompt)

        print("JSYS: Prompts successfully registered!")

        -----------------------------------------

        while active do
            if PromptIsActive(prompt) then
                if PromptIsPressed(prompt) then
                    print("JSYS: You pressed R!!!")
                    print("JSYS: execute command", Config.CoordinatesAll[0].coomand)
                    ExecuteCommand(Config.CoordinatesAll[0].command)
                    print("JSYS: Waiting...", Config.Cooldown, "seconds")
                    Citizen.Wait(Config.Cooldown)
                    print("JSYS: Done waiting!")
                    active = false -- deactivate after debugging!!!
                end
            end
            Citizen.Wait(Config.TickerCheck)
        end

        -----------------------------------------

        print("JSYS: Exiting loop!!!")
        PromptDelete(prompt)
        print("JSYS: Prompt deactivated!!!")
    end)
end

createAndRunPrompt()
