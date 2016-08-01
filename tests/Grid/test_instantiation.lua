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
        local grid = Grid:new{lenX = 7, lenY = 3}
        luaunit.assertEquals(grid.lenX, 7)
        luaunit.assertEquals(grid.lenY, 3)
        
        luaunit.assertEquals(ii, nil)   -- confirm loop variables are local
        luaunit.assertEquals(jj, nil)
    end
    
    function TestGrid_Instantiation:test_elementsHaveDefaultCell()
        local grids = {}
        grids[1] = Grid:new()
        grids[2] = Grid:new{}
        grids[3] = Grid:new{lenX = 22, lenY = 5}
        
        for _, grid in ipairs(grids) do
            for xx = 1, grid.lenX do
                for yy = 1, grid.lenY do
                    luaunit.assertEquals(getmetatable(grid[xx][yy]), Cell)
                    luaunit.assertEquals(grid[xx][yy].blocksMove, true)
                    luaunit.assertEquals(grid[xx][yy].blocksSight, true)
                    luaunit.assertEquals(grid[xx][yy].blocksAttack, true)  
                end
            end
        end
    end