require 'Grid'

TestGrid_Instantiation = {}
    function TestGrid_Instantiation:test_lengthWidth()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertEquals(grid.lenX, 22)
        luaunit.assertEquals(grid.lenY, 5)
    end
    
    function TestGrid_Instantiation:test_defaultCell()
        local grid = Grid:new('tests/Grid/test_default.map')
        
        for xx = 1, grid.lenX do
            for yy = 1, grid.lenY do
                luaunit.assertEquals(getmetatable(grid[xx][yy]), Cell)
                luaunit.assertEquals(grid[xx][yy].blocksMove, true)
                luaunit.assertEquals(grid[xx][yy].blocksSight, true)
                luaunit.assertEquals(grid[xx][yy].blocksAttack, true)  
            end
        end
    end
    
    function TestGrid_Instantiation:test_1_map()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertEquals(grid.lenX, 22)
        luaunit.assertEquals(grid.lenY, 5)
        
        -- check default 'wall' squares
        luaunit.assertEquals(grid[1][1].blocksMove, true)
        luaunit.assertEquals(grid[18][4].blocksMove, true)
        
        -- check altered 'open' squares
        luaunit.assertEquals(grid[6][3].blocksMove, false)
        luaunit.assertEquals(grid[22][3].blocksMove, false)
    end