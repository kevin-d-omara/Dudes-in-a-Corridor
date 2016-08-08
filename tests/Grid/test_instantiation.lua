require 'Grid'

-- print test_1.map to STDOUT to aid with checking results
local g1 = Grid:new('tests/Grid/test_1.map')
g1:pprint()   -- print test_1.map

TestGrid_Instantiation = {}
    function TestGrid_Instantiation:test_lengthWidth()
        luaunit.assertEquals(g1.lenX, 36)
        luaunit.assertEquals(g1.lenY, 5)
    end
    
    function TestGrid_Instantiation:test_defaultCell()
        local grid = Grid:new('tests/Grid/test_default.map')
        
        for xx = 1, grid.lenX do
            for yy = 1, grid.lenY do
                luaunit.assertEquals(getmetatable(grid[xx][yy]), Cell)
                luaunit.assertFalse(grid[xx][yy].blocksMove)
                luaunit.assertFalse(grid[xx][yy].blocksSight)
                luaunit.assertFalse(grid[xx][yy].blocksAttack)
            end
        end
    end
    
    function TestGrid_Instantiation:test_1_map()
        luaunit.assertEquals(g1.lenX, 36)
        luaunit.assertEquals(g1.lenY, 5)
        
        -- check default 'wall' squares
        luaunit.assertEquals(g1[1][1].blocksMove, true)
        luaunit.assertEquals(g1[18][4].blocksMove, true)
        
        -- check altered 'open' squares
        luaunit.assertEquals(g1[6][3].blocksMove, false)
        luaunit.assertEquals(g1[22][3].blocksMove, false)
    end

--==============================================================================

TestGrid_Instantiation_Edges = {}
    function TestGrid_Instantiation_Edges:test_trueFalse()
        -- 'open' edges (default)
        luaunit.assertFalse(g1.edgeX[11][3].blocksMove)
        luaunit.assertFalse(g1.edgeY[11][3].blocksMove)
        
        -- 'wall' edges (set by Cells)
        luaunit.assertTrue(g1.edgeX[3][4].blocksMove)
        luaunit.assertTrue(g1.edgeY[4][3].blocksMove)
        
        -- 'wall' edges (set by EdgeX & EdgeY)
        luaunit.assertTrue(g1.edgeX[35][3].blocksMove)
        luaunit.assertTrue(g1.edgeX[35][5].blocksMove)
        luaunit.assertTrue(g1.edgeY[35][5].blocksMove)
    end
