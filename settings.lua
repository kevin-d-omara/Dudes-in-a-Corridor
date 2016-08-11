--[[
Description:
    - Contains all game settings (Window, MapBuilder, etc.).
    - Can be modified manually or in-game through the 'settings' menu.
    - Values are saved between runs of the game.
    - Used by 'initialize.lua'
--]]
local settings =
{
    -- Window Settings
    width = 1024,
    height = 768,
    flags =
    {
        fullscreen = false,
        xCoord = nil,
        yCoord = nil
    }
}

return settings