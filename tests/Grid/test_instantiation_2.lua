require 'Grid'
require 'tests/Grid/prepare_test_2_map'

local g2 = Grid:new('tests/Grid/test_2.map')
prepareMap2(g2)
--g2:pprint() -- print test_2.map to STDOUT to aid with checking results

TestGrid_Instantiation = {}
    function TestGrid_Instantiation:test_lengthWidth()
        luaunit.assertEquals(g2.lenX, 36)
        luaunit.assertEquals(g2.lenY, 5)
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
    
    function TestGrid_Instantiation:test_crateCells()
        -- check altered 'wall' (crate) Cells
        luaunit.assertTrue(g2[ 1][1].blocksSight)
        luaunit.assertTrue(g2[18][4].blocksSight)
    end

--==============================================================================

TestGrid_Instantiation_Edges = {}
    function TestGrid_Instantiation_Edges:test_noEdgesWithinBoundary()
        -- 'open' edges (default)
        luaunit.assertFalse(g2.edgeX[11][3].blocksSight)
        luaunit.assertFalse(g2.edgeY[11][3].blocksSight)
        
        -- 'open' edges (would be 'wall', but map 2 only uses crates)
        luaunit.assertFalse(g2.edgeX[ 3][4].blocksSight)
        luaunit.assertFalse(g2.edgeY[ 4][3].blocksSight)
        luaunit.assertFalse(g2.edgeX[25][3].blocksSight)
        luaunit.assertFalse(g2.edgeY[25][3].blocksSight)
        
        -- 'wall' edges (set by EdgeX & EdgeY)
        luaunit.assertTrue(g2.edgeX[35][3].blocksSight)
        luaunit.assertTrue(g2.edgeX[35][5].blocksSight)
        luaunit.assertTrue(g2.edgeY[35][5].blocksSight)
    end
    
    function TestGrid_Instantiation_Edges:test_boundaryEdges()
        -- 'wall' edges set by BUFFER
        -- bottom left corner
        luaunit.assertTrue(g2.edgeX[1][1].blocksSight)
        luaunit.assertTrue(g2.edgeY[1][1].blocksSight)
        
        -- bottom right corner
        luaunit.assertTrue(g2.edgeX[37][1].blocksSight)
        luaunit.assertTrue(g2.edgeY[36][1].blocksSight)
        
        -- top left corner
        luaunit.assertTrue(g2.edgeX[1][5].blocksSight)
        luaunit.assertTrue(g2.edgeY[1][6].blocksSight)
        
        -- top right corner
        luaunit.assertTrue(g2.edgeX[37][5].blocksSight)
        luaunit.assertTrue(g2.edgeY[36][6].blocksSight)
    end
