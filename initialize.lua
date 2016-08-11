local ini = require 'settings'

-- Apply Window Settings
love.window.setMode(ini.width, ini.height, ini.flags)






















--[[ future reference material
math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
--rng = love.math.newRandomGenerator() -- see API online
--love.math.random() -- same seed across platforms?
--]]