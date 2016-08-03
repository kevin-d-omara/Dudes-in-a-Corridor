require 'Grid'
require 'Grid_hasSight'

TestGrid_hasSight = {}
    function TestGrid_hasSight:test_allOpenSquares()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertTrue(grid:hasSight(9,2 , 10,3))
        luaunit.assertTrue(grid:hasSight(9,2 , 11,4))
        luaunit.assertTrue(grid:hasSight(9,2 , 11,3))
        luaunit.assertTrue(grid:hasSight(9,2 , 15,4))
    end
    
    function TestGrid_hasSight:test_allBlockedSquares()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertFalse(grid:hasSight(1,1 , 2,2))
        luaunit.assertFalse(grid:hasSight(1,1 , 3,2))
    end
    
    function TestGrid_hasSight:test_sightIsBlocked()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertFalse(grid:hasSight(9,2 , 10,5))
        luaunit.assertFalse(grid:hasSight(8,3 , 13,5))
        luaunit.assertFalse(grid:hasSight(8,3 , 19,4))
        luaunit.assertFalse(grid:hasSight(8,3 , 20,5))
    end

    function TestGrid_hasSight:test_error()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertFalse(grid:hasSight(9,2 , 13,5 , true))
    end
--[[
    function TestGrid_hasSight:test_passTopCorner()
        local grid = Grid:new('tests/Grid/test_1.map')
        --luaunit.assertTrue(grid:hasSight(9,2 , 10,5))
    end

    function TestGrid_hasSight:test_passBottomCorner()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertTrue(grid:hasSight(?,? , ?,?))
    end

    function TestGrid_hasSight:test_passBothCorners()
        local grid = Grid:new('tests/Grid/test_1.map')
        luaunit.assertFalse(grid:hasSight(?,? , ?,?))
    end
--]]

local g1 = Grid:new('tests/Grid/test_1.map'); g1:pprint()   -- print test_1.map