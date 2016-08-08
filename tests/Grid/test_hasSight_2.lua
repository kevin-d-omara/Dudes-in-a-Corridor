require 'Grid'
require 'Grid_hasSight'

-- print test_2.map to STDOUT to aid with checking results
local g2 = Grid:new('tests/Grid/test_2.map')
-- blocked squares ~ crates placed at end

TestGrid_hasSight_dxIsZero = {}

    function TestGrid_hasSight_dxIsZero:test_allOpen()
        luaunit.assertTrue(g2:hasSight(13,3 , 13,5))  -- '+' 'slope'
        luaunit.assertTrue(g2:hasSight(13,5 , 13,3))  -- '-' 'slope'
    end
    
    function TestGrid_hasSight_dxIsZero:test_allClosed()
        luaunit.assertFalse(g2:hasSight(25,3 , 25,5)) -- '+' 'slope'
        luaunit.assertFalse(g2:hasSight(25,5 , 25,3)) -- '-' 'slope'
    end
    
    function TestGrid_hasSight_dxIsZero:test_endClosed_2wallsDeep()
        luaunit.assertFalse(g2:hasSight(1,3 , 1,5))   -- '+' 'slope'
        luaunit.assertFalse(g2:hasSight(1,3 , 1,1))   -- '-' 'slope'
    end
    
    function TestGrid_hasSight_dxIsZero:test_endClosed_1wallDeep()
        luaunit.assertFalse(g2:hasSight(1,3 , 1,4))    -- '+' 'slope'
        luaunit.assertFalse(g2:hasSight(1,3 , 1,2))    -- '-' 'slope'
    end
    
--==============================================================================

TestGrid_hasSight_dyIsZero = {}

    function TestGrid_hasSight_dyIsZero:test_allOpen()
        luaunit.assertTrue(g2:hasSight(13,3 , 15,3))  -- forward (right)(east)
        luaunit.assertTrue(g2:hasSight(15,3 , 13,3))  -- aft     (left) (west)
    end
    
    function TestGrid_hasSight_dyIsZero:test_allClosed()
        luaunit.assertFalse(g2:hasSight(25,3 , 27,3)) -- forward
        luaunit.assertFalse(g2:hasSight(27,3 , 25,3)) -- aft
    end
    
    function TestGrid_hasSight_dyIsZero:test_endClosed_2wallsDeep()
        luaunit.assertFalse(g2:hasSight(21,2 , 23,2)) -- forward
        luaunit.assertFalse(g2:hasSight(5,2 , 3,2))   -- aft
    end
    
    function TestGrid_hasSight_dyIsZero:test_endClosed_1wallDeep()
        luaunit.assertFalse(g2:hasSight(21,2 , 22,2))  -- forward
        luaunit.assertFalse(g2:hasSight(5,2 , 4,2))    -- aft
    end

--==============================================================================

TestGrid_hasSight_topCornerOnly = {}
    function TestGrid_hasSight_topCornerOnly:test_1_corner()
        -- 45 degrees
        luaunit.assertTrue(g2:hasSight(18,3 , 19,4))    -- '+' slope
        luaunit.assertTrue(g2:hasSight(21,4 , 22,3))    -- '-' slope
        
        -- < 45 degrees
        luaunit.assertTrue(g2:hasSight(7,3 , 10,4))     -- '+' slope
        luaunit.assertTrue(g2:hasSight(6,4 , 9,3))      -- '-' slope
        
        -- > 45 degrees
        luaunit.assertTrue(g2:hasSight(29,1 , 30,4))    -- '+' slope
        luaunit.assertTrue(g2:hasSight(28,4 , 29,1))    -- '-' slope
    end

    function TestGrid_hasSight_topCornerOnly:test_2_corners()
        -- 45 degrees
        luaunit.assertTrue(g2:hasSight(18,3 , 20,5))    -- '+' slope
        luaunit.assertTrue(g2:hasSight(20,5 , 22,3))    -- '-' slope
    end

    function TestGrid_hasSight_topCornerOnly:test_1_corner_reverse()
        -- 45 degrees
        luaunit.assertTrue(g2:hasSight(18,3 , 17,4))    -- '+' slope
        luaunit.assertTrue(g2:hasSight(19,4 , 18,3))    -- '-' slope
    end

    function TestGrid_hasSight_topCornerOnly:test_2_corners_reverse()
        -- 45 degrees
        luaunit.assertTrue(g2:hasSight(20,5 , 18,3))    -- '+' slope
        luaunit.assertTrue(g2:hasSight(22,3 , 20,5))    -- '-' slope
    end

--==============================================================================

TestGrid_hasSight_bottomCornerOnly = {}
    function TestGrid_hasSight_bottomCornerOnly:test_1_corner()
        -- 45 degrees
        luaunit.assertTrue(g2:hasSight(21,2 , 22,3))    -- '+' slope
        luaunit.assertTrue(g2:hasSight(18,3 , 19,2))    -- '-' slope
        
        -- < 45 degrees
        luaunit.assertTrue(g2:hasSight(6,2 , 9,3))      -- '+' slope
        luaunit.assertTrue(g2:hasSight(7,3 , 10,2))     -- '-' slope
        
        -- > 45 degrees
        luaunit.assertTrue(g2:hasSight(28,2 , 29,5))    -- '+' slope
        luaunit.assertTrue(g2:hasSight(29,5 , 30,2))    -- '-' slope
    end
    
    function TestGrid_hasSight_bottomCornerOnly:test_2_corners()
        -- 45 degrees
        luaunit.assertTrue(g2:hasSight(22,3 , 20,1))    -- '+' slope
        luaunit.assertTrue(g2:hasSight(18,3 , 20,1))    -- '-' slope
    end

    function TestGrid_hasSight_bottomCornerOnly:test_1_corner_reverse()
        -- 45 degrees
        luaunit.assertTrue(g2:hasSight(18,3 , 17,2))    -- '+' slope
        luaunit.assertTrue(g2:hasSight(18,3 , 17,4))    -- '-' slope
    end

    function TestGrid_hasSight_bottomCornerOnly:test_2_corners_reverse()
        -- 45 degrees
        luaunit.assertTrue(g2:hasSight(20,1 , 22,3))    -- '+' slope
        luaunit.assertTrue(g2:hasSight(20,1 , 18,3))    -- '-' slope
    end

--==============================================================================

TestGrid_hasSight_bothCorners = {}
    function TestGrid_hasSight_bothCorners:test_bothCorners()
        -- 45 degrees
        luaunit.assertFalse(g2:hasSight(17,2 , 19,4))   -- '+' slope
        luaunit.assertFalse(g2:hasSight(17,4 , 19,2))   -- '-' slope
        
        -- > 45 degrees
        luaunit.assertFalse(g2:hasSight(28,2 , 34,4))    -- '+' slope
        luaunit.assertFalse(g2:hasSight(28,4 , 34,2))    -- '-' slope
    end

    function TestGrid_hasSight_bothCorners:test_cornerOnly_openOnBack()
        -- 45 degrees
        -- distance 1
        luaunit.assertFalse(g2:hasSight(31,1 , 32,2))   -- '+' slope
        luaunit.assertFalse(g2:hasSight(30,2 , 31,1))   -- '-' slope
        -- distance 2; start inside wall
        luaunit.assertFalse(g2:hasSight(31,1 , 33,3))   -- '+' slope
        luaunit.assertFalse(g2:hasSight(29,3 , 31,1))   -- '-' slope

    end

--==============================================================================

TestGrid_hasSight_diagonalThroughBlock = {}
    function TestGrid_hasSight_diagonalThroughBlock:test_throughCorner()
        luaunit.assertFalse(g2:hasSight(28,2 , 30,4))   -- '+' slope
        luaunit.assertFalse(g2:hasSight(28,2 , 31,5))   -- '+' slope
        luaunit.assertFalse(g2:hasSight(28,4 , 30,2))   -- '-' slope
    end

--==============================================================================

TestGrid_hasSight_Edges = {}
    function TestGrid_hasSight_Edges:test_throughIntrinsicWall_surrounginOpen()
        -- 'wall' edge is only gap between both squares
        luaunit.assertFalse(g2:hasSight(35,5 , 35,4))   -- dx = 0; '-' slope
        luaunit.assertFalse(g2:hasSight(34,3 , 35,3))   -- dy = 0
        
        -- more than just 1 edge gap
        luaunit.assertFalse(g2:hasSight(34,3 , 36,3))   -- dy = 0
        
    end

--==============================================================================

TestGrid_hasSight_randomAttempts = {}
    function TestGrid_hasSight_randomAttempts:test_sight_false()
        -- starting point adjacent
        luaunit.assertFalse(g2:hasSight(28,3 , 32,4))   -- '+' slope
        luaunit.assertFalse(g2:hasSight(28,4 , 33,1))   -- '-' slope
    end

    function TestGrid_hasSight_randomAttempts:test_sight_true()
        -- starting point adjacent
        luaunit.assertTrue(g2:hasSight(29,2 , 33,4))   -- '+' slope
        luaunit.assertTrue(g2:hasSight(28,5 , 33,2))   -- '-' slope
    end

--==============================================================================

TestGrid_hasSight_theta45_throughTwoEdgeCorners = {}
    function TestGrid_hasSight_theta45_throughTwoEdgeCorners:test_sight_false()
        luaunit.assertFalse(g2:hasSight(34,4 , 35,5))   -- start adjacent
        -- start non-adjacent; start inside wall
        luaunit.assertFalse(g2:hasSight(33,3 , 35,5))
    end
        

--==============================================================================
--[[ [ERROR] - These tests will fail.
The first and last edge/corner checked will ALWAYS be "blocked" by the unit
occupying that square.  I.e. the source or target unit will always block it's
own edges.

TestGrid_hasSight_targetIsUnit = {}
    function TestGrid_hasSight_targetIsUnit:test_ERROR()
        luaunit.assertTrue(#,# , #+2,#+2)   -- target is a unit
    end
    
TestGrid_hasSight_sourceIsUnit = {}
    function TestGrid_hasSight_sourceIsUnit:test_ERROR()
        luaunit.assertFalse(g2:hasSight(33,3 , 34,4))   -- source is a unit
    end
--]]
--==============================================================================
--[[    Useful print statements for testing Grid:hasSight()

    -- THETA
    if test then print(' ------ START ------ ') end
    if test then print('pt1('..x1..','..y1..')') end
    if test then print('pt2('..x2..','..y2..')') end
    if test then print('dx: '..dx..'; dy: '..dy) end
    if test then print('m : '..m) end
    if test then print('b : '..b) end
    if test then print('theta : '..theta) end

    -- EPS
    if test then print('X--------------------------') end
    if test then print('x: '..x) end
    if test then print('y: '..y) end
    if test then print('numStepsX: '..numStepsX) end
    if test then print('shiftTop: '..shiftTop) end
    if test then print('shiftBot: '..shiftBot) end

    -- X LOOP
    if test then print('('..math.floor(x)..','..math.floor(y+eps)..')') end

    -- Check Corners
    if test then print('corner') end
    if test then print('top:') end
    if test then print('-> edgeX('..math.floor(x)..','..math.floor(y+eps)..')') end
    if test then print('-> edgeY('..(math.floor(x)+shiftTop)..','..math.floor(y+eps)..')') end
    if test then print('bot:') end
    if test then print('-> edgeX('..math.floor(x)..','..(math.floor(y+eps)-1)..')') end
    if test then print('-> edgeY('..(math.floor(x)+shiftBot)..','..math.floor(y+eps)..')') end
    -- actual check
    if test then print('-> top: '..tostring(topCornerBlocked)) end
    if test then print('-> bot: '..tostring(bottomCornerBlocked)) end

    -- PRE Y LOOP
    if test then print('Y--------------------------') end
    if test then print('x: '..x) end
    if test then print('y: '..y) end
    if test then print('numStepsY: '..numStepsY) end
    if test then print('stepX: '..stepX) end
    if test then print('stepY: '..stepY) end
    
    -- Y LOOP
    if test then print('('..math.floor(x+eps)..','..(math.floor(y))..')') end

--]]

--[[
Fills the grid with blocked Cells.  This is equivalent to placing a Crate or
closed Door in each Cell.  Note: the Edges are not transformed to 'wall' type.
--]]
function test_2_mapBuilder(grid)
    grid[ 1][5].blocksSight = true
    grid[ 2][5].blocksSight = true
    grid[ 3][5].blocksSight = true
    grid[ 4][5].blocksSight = true
    grid[ 5][5].blocksSight = true
    grid[ 6][5].blocksSight = true
    grid[ 7][5].blocksSight = true
    grid[ 8][5].blocksSight = true
    grid[ 9][5].blocksSight = true
    grid[10][5].blocksSight = true
    grid[11][5].blocksSight = true
    grid[12][5].blocksSight = true
    grid[14][5].blocksSight = true
    grid[15][5].blocksSight = true
    grid[16][5].blocksSight = true
    grid[17][5].blocksSight = true
    grid[18][5].blocksSight = true
    grid[19][5].blocksSight = true
    grid[21][5].blocksSight = true
    grid[22][5].blocksSight = true
    grid[23][5].blocksSight = true
    grid[24][5].blocksSight = true
    grid[25][5].blocksSight = true
    grid[26][5].blocksSight = true
    grid[27][5].blocksSight = true
    grid[ 1][4].blocksSight = true
    grid[ 2][4].blocksSight = true
    grid[ 3][4].blocksSight = true
    grid[ 4][4].blocksSight = true
    grid[ 8][4].blocksSight = true
    grid[18][4].blocksSight = true
    grid[22][4].blocksSight = true
    grid[23][4].blocksSight = true
    grid[24][4].blocksSight = true
    grid[25][4].blocksSight = true
    grid[26][4].blocksSight = true
    grid[27][4].blocksSight = true
    grid[23][3].blocksSight = true
    grid[24][3].blocksSight = true
    grid[25][3].blocksSight = true
    grid[26][3].blocksSight = true
    grid[27][3].blocksSight = true
    grid[ 1][2].blocksSight = true
    grid[ 2][2].blocksSight = true
    grid[ 3][2].blocksSight = true
    grid[ 4][2].blocksSight = true
    grid[ 8][2].blocksSight = true
    grid[18][2].blocksSight = true
    grid[22][2].blocksSight = true
    grid[23][2].blocksSight = true
    grid[24][2].blocksSight = true
    grid[25][2].blocksSight = true
    grid[26][2].blocksSight = true
    grid[27][2].blocksSight = true
    grid[27][2].blocksSight = true
    grid[ 1][1].blocksSight = true
    grid[ 2][1].blocksSight = true
    grid[ 3][1].blocksSight = true
    grid[ 4][1].blocksSight = true
    grid[ 5][1].blocksSight = true
    grid[ 6][1].blocksSight = true
    grid[ 7][1].blocksSight = true
    grid[ 8][1].blocksSight = true
    grid[ 9][1].blocksSight = true
    grid[10][1].blocksSight = true
    grid[11][1].blocksSight = true
    grid[12][1].blocksSight = true
    grid[14][1].blocksSight = true
    grid[15][1].blocksSight = true
    grid[16][1].blocksSight = true
    grid[17][1].blocksSight = true
    grid[18][1].blocksSight = true
    grid[19][1].blocksSight = true
    grid[21][1].blocksSight = true
    grid[22][1].blocksSight = true
    grid[23][1].blocksSight = true
    grid[24][1].blocksSight = true
    grid[25][1].blocksSight = true
    grid[26][1].blocksSight = true
    grid[27][1].blocksSight = true
    grid[29][3].blocksSight = true
    grid[33][3].blocksSight = true
    grid[31][2].blocksSight = true
    grid[30][1].blocksSight = true
    grid[32][1].blocksSight = true
end
test_2_mapBuilder(g2); g2:pprint()   -- print test_1.map