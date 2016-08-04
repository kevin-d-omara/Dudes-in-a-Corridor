require 'Grid'
require 'Grid_hasSight'

TestGrid_hasSight_dxIsZero = {}

    function TestGrid_hasSight_dxIsZero:test_allOpen()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertTrue(grid:hasSight(13,3 , 13,5))  -- positive 'slope'
        luaunit.assertTrue(grid:hasSight(13,5 , 13,3))  -- negative 'slope'
    end
    
    function TestGrid_hasSight_dxIsZero:test_allClosed()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertFalse(grid:hasSight(25,3 , 25,5)) -- positive 'slope'
        luaunit.assertFalse(grid:hasSight(25,5 , 25,3)) -- negative 'slope'
    end
    
    function TestGrid_hasSight_dxIsZero:test_endClosed_2wallsDeep()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertFalse(grid:hasSight(1,3 , 1,5))   -- positive 'slope'
        luaunit.assertFalse(grid:hasSight(1,3 , 1,1))   -- negative 'slope'
    end
    
    function TestGrid_hasSight_dxIsZero:test_endClosed_1wallDeep()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertTrue(grid:hasSight(1,3 , 1,4))    -- positive 'slope'
        luaunit.assertTrue(grid:hasSight(1,3 , 1,2))    -- negative 'slope'
    end
    
--==============================================================================

TestGrid_hasSight_dyIsZero = {}

    function TestGrid_hasSight_dyIsZero:test_allOpen()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertTrue(grid:hasSight(13,3 , 15,3))
        luaunit.assertTrue(grid:hasSight(15,3 , 13,3))
    end
    
    function TestGrid_hasSight_dyIsZero:test_allClosed()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertFalse(grid:hasSight(25,3 , 27,3))
        luaunit.assertFalse(grid:hasSight(27,3 , 25,3))
    end
    
    function TestGrid_hasSight_dyIsZero:test_endClosed_2wallsDeep()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertFalse(grid:hasSight(21,2 , 23,2)) -- positive 'slope'
        luaunit.assertFalse(grid:hasSight(5,2 , 3,2))   -- negative 'slope'
    end
    
    function TestGrid_hasSight_dyIsZero:test_endClosed_1wallDeep()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertTrue(grid:hasSight(21,2 , 22,2))  -- positive 'slope'
        luaunit.assertTrue(grid:hasSight(5,2 , 4,2))    -- negative 'slope'
    end

local g1 = Grid:new('tests/Grid/test_1.map'); g1:pprint()   -- print test_1.map

--==============================================================================

TestGrid_hasSight_topCornerOnly = {}

    function TestGrid_hasSight_topCornerOnly:setUp()
        g1 = Grid:new('tests/Grid/test_1.map')
    end
    
    function TestGrid_hasSight_topCornerOnly:tearDown()
        g1 = nil
    end

    function TestGrid_hasSight_topCornerOnly:test_1_corner()
        luaunit.assertTrue(g1:hasSight(18,3 , 19,4))
    end

    function TestGrid_hasSight_topCornerOnly:test_2_corners()
        luaunit.assertTrue(g1:hasSight(18,3 , 20,5))
    end

    function TestGrid_hasSight_topCornerOnly:test_1_corner_reverse()
        luaunit.assertTrue(g1:hasSight(18,3 , 17,4))
    end

--==============================================================================

TestGrid_hasSight_bottomCornerOnly = {}

    function TestGrid_hasSight_bottomCornerOnly:setUp()
        g1 = Grid:new('tests/Grid/test_1.map')
    end
    
    function TestGrid_hasSight_bottomCornerOnly:tearDown()
        g1 = nil
    end

    function TestGrid_hasSight_bottomCornerOnly:test_1_corner()
        luaunit.assertTrue(g1:hasSight(18,3 , 19,2))
    end

    function TestGrid_hasSight_bottomCornerOnly:test_2_corners()
        luaunit.assertTrue(g1:hasSight(18,3 , 20,1))
    end

    function TestGrid_hasSight_bottomCornerOnly:test_1_corner_reverse()
        luaunit.assertTrue(g1:hasSight(18,3 , 17,2))
    end

--==============================================================================

TestGrid_hasSight_bothCorners = {}

    function TestGrid_hasSight_bothCorners:setUp()
        g1 = Grid:new('tests/Grid/test_1.map')
    end
    
    function TestGrid_hasSight_bothCorners:tearDown()
        g1 = nil
    end

    function TestGrid_hasSight_bothCorners:test_bothCorners()
        luaunit.assertFalse(g1:hasSight(17,2 , 19,4))
    end







