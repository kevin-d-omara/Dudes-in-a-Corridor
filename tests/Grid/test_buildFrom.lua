require 'Grid'

TestGrid_function_buildFrom = {}
    function TestGrid_function_buildFrom:test_1_map()
        local grid = Grid:buildFrom('tests/Grid/test_1.map')
        luaunit.assertEquals(grid.lenX, 22)
        luaunit.assertEquals(grid.lenY, 5)
        
        -- check default 'wall' squares
        luaunit.assertEquals(grid[1][1].blocksMove, true)
        luaunit.assertEquals(grid[18][4].blocksMove, true)
        
        -- check modified 'open' squares
        luaunit.assertEquals(grid[6][3].blocksMove, false)
        luaunit.assertEquals(grid[22][3].blocksMove, false)
    end