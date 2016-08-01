require 'Grid'

TestGrid_Instantiation = {}
    function TestGrid_Instantiation:test_argument_emptyTable()
        local grid = Grid:new{}
        luaunit.assertEquals(grid.lenX, 10)
        luaunit.assertEquals(grid.lenY, 10)
    end
    
    function TestGrid_Instantiation:test_argument_none()
        local grid = Grid:new()        
        luaunit.assertEquals(grid.lenX, 10)
        luaunit.assertEquals(grid.lenY, 10)
        luaunit.assertEquals(args, nil) -- confirm newly created 'args' is local
    end

    function TestGrid_Instantiation:test_argument_lengthWidth()
        local grid = Grid:new{lenX = 5, lenY = 7}
        luaunit.assertEquals(grid.lenX, 5)
        luaunit.assertEquals(grid.lenY, 7)
    end