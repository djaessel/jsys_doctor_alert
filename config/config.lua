-- JSYS was here! :P

Config = {
    KeyBinding = 0xE30CD707, -- R
    KeyInfoText = "[R] um nach dem Arzt schicken zu lassen", -- set to correct key in text
    InfoAlreadyCalled = "Du hast gerade schon den Arzt gerufen!", -- when key was already pressed
    Radius = 3, -- meters
    Cooldown = 60000, -- milliseconds
    TickerCheck = 1000, -- milliseconds -- only change if you know what you are doing
    KeyInfoVisibleDuration = 5000, -- milliseconds -- will be also used for other things -- only change if you know what you are doing

    -- Warning: Check if command has a duplicate, if it is not called correctly!
    CoordinatesAll = {
        {
            -- Doctor SD
            coords = vector3(2724.02, -1236.5, 49.95), -- x, y, z
            command = "doctorsdalert2", -- set to coorect command from bcc-job-alerts
        },
        {
            -- Doctor RD
            coords = vector3(1369.23, -1310.75, 77.94), -- x, y, z
            command = "doctorrdalert2", -- set to coorect command from bcc-job-alerts
        },
        -- below can be activated and changed, but unused at the moment!
--        {
--            -- Doctor xy
--            coords = vector3(40, 50, 6), -- x, y, z
--            command = "doctorxyalert"
--        },
    } -- CoordinatesAll end
} -- Config end
