require 'Cell'

local cellWall = Cell:new{type='wall'}
local cellOpen = Cell:new{type='open'}

TestCell_Instantiation = {}
    function TestCell_Instantiation:test_argument_emptyTable()
        local cell = Cell:new{} -- defaults to 'wall' type
        luaunit.assertEquals(cell.blocksMove, true)
        luaunit.assertEquals(cell.blocksSight, true)
        luaunit.assertEquals(cell.blocksAttack, true)        
    end
    
    function TestCell_Instantiation:test_argument_none()
        local cell = Cell:new() -- defaults to 'wall' type
        luaunit.assertEquals(cell.blocksMove, true)
        luaunit.assertEquals(cell.blocksSight, true)
        luaunit.assertEquals(cell.blocksAttack, true)  
    end
    
    function TestCell_Instantiation:test_type_wall()
        luaunit.assertTrue(cellWall.blocksMove)
        luaunit.assertTrue(cellWall.blocksSight)
        luaunit.assertTrue(cellWall.blocksAttack)
    end
    
    function TestCell_Instantiation:test_type_open()
        luaunit.assertFalse(cellOpen.blocksMove)
        luaunit.assertFalse(cellOpen.blocksSight)
        luaunit.assertFalse(cellOpen.blocksAttack)
    end
