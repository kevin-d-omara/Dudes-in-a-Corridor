math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
--rng = love.math.newRandomGenerator() -- see API online
--love.math.random() -- same seed across platforms?

window = {}
window.width, window.height, window.flags = love.window.getMode()