--[[
Description:
    - Contains immutable settings for the game.
--]]
function love.conf(t)
    t.version = "0.10.1"                -- The LÖVE version this game was made for (string)
    t.window.title = "Dudes in a Corridor" -- The window title (string)

--[[
    t.window.resizable = false          -- Let the window be user-resizable (boolean)
    t.window.minwidth = 1               -- Minimum window width if the window is resizable (number)
    t.window.minheight = 1              -- Minimum window height if the window is resizable (number)
    t.window.fullscreen = false         -- Enable fullscreen (boolean)
    t.window.fullscreentype = "desktop" -- Choose between "desktop" fullscreen or "exclusive" fullscreen mode (string)
    t.window.x = nil                    -- The x-coordinate of the window's position in the specified display (number)
    t.window.y = nil                    -- The y-coordinate of the window's position in the specified display (number)
--]]
 end