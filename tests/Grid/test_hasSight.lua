require 'Grid'
require 'Grid_hasSight'

TestGrid_hasSight = {}
    function TestGrid_hasSight:test_allOpenSquares()
        local grid = Grid:new('tests/Grid/test_1.map')
        --luaunit.assertTrue(grid:hasSight(10,2 , 13,5))
    end
    
    function TestGrid_hasSight:test_dx_isZero()
        local grid = Grid:new('tests/Grid/test_1.map')
        -- open squares
        luaunit.assertTrue(grid:hasSight(13,3 , 13,5))    -- positive 'slope'
        luaunit.assertTrue(grid:hasSight(13,5 , 13,3))    -- negative 'slope'
        
        -- closed squares
        luaunit.assertFalse(grid:hasSight(25,3 , 25,5))    -- positive 'slope'
        luaunit.assertFalse(grid:hasSight(25,5 , 25,3))    -- negative 'slope'
        
    end
    
    function TestGrid_hasSight:test_dy_isZero()
        local grid = Grid:new('tests/Grid/test_1.map')
        -- open squares
        luaunit.assertTrue(grid:hasSight(13,3 , 15,3))
        luaunit.assertTrue(grid:hasSight(15,3 , 13,3))
        
        -- closed squares
        luaunit.assertFalse(grid:hasSight(25,3 , 27,3))
        luaunit.assertFalse(grid:hasSight(27,3 , 25,3))
    end

local g1 = Grid:new('tests/Grid/test_1.map'); g1:pprint()   -- print test_1.map
