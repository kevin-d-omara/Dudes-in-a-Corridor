require 'Cell'

TestCell_Instantiation = {}
    function TestCell_Instantiation:test_argument_emptyTable()
        local cell = Cell:new{}
    end
    
    function TestCell_Instantiation:test_argument_none()
        local cell = Cell:new()        
        luaunit.assertEquals(args, nil) -- confirm newly created 'args' is local
    end
    
    function TestCell_Instantiation:test_booleans_trueFalse()
        local cell = Cell:new{blocksMove = true}        -- blocksMove
        luaunit.assertEquals(cell.blocksMove, true)
        local cell = Cell:new{}
        luaunit.assertEquals(cell.blocksMove, true)
        local cell = Cell:new()
        luaunit.assertEquals(cell.blocksMove, true)
        local cell = Cell:new{blocksMove = false}
        luaunit.assertEquals(cell.blocksMove, false)
        
        
        local cell = Cell:new{blocksSight = true}       -- blocksSight
        luaunit.assertEquals(cell.blocksSight, true)
        local cell = Cell:new{}
        luaunit.assertEquals(cell.blocksSight, true)
        local cell = Cell:new{blocksSight = false}
        luaunit.assertEquals(cell.blocksSight, false)
        
        local cell = Cell:new{blocksAttack = true}      -- blocksAttack
        luaunit.assertEquals(cell.blocksAttack, true)
        local cell = Cell:new{}
        luaunit.assertEquals(cell.blocksAttack, true)
        local cell = Cell:new{blocksAttack = false}
        luaunit.assertEquals(cell.blocksAttack, false)
    end