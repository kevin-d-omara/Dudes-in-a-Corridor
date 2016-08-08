require 'Edge'

local edgeWall = Edge:new{type = 'wall'}
local edgeOpen = Edge:new{type = 'open'}

TestEdge_Instantiation = {}
    function TestEdge_Instantiation:test_args_empty()
        local edge = Edge:new{} -- defaults to 'open' type
        luaunit.assertFalse(edge.blocksMove)
        luaunit.assertFalse(edge.blocksSight)
        luaunit.assertFalse(edge.blocksAttack) 
    end
    
    function TestEdge_Instantiation:test_args_none()
        local edge = Edge:new() -- defaults to 'open' type
        luaunit.assertFalse(edge.blocksMove)
        luaunit.assertFalse(edge.blocksSight)
        luaunit.assertFalse(edge.blocksAttack) 
    end
    
    function TestEdge_Instantiation:test_type_wall()
        luaunit.assertTrue(edgeWall.blocksMove)
        luaunit.assertTrue(edgeWall.blocksSight)
        luaunit.assertTrue(edgeWall.blocksAttack)
    end
    
    function TestEdge_Instantiation:test_type_open()
        luaunit.assertFalse(edgeOpen.blocksMove)
        luaunit.assertFalse(edgeOpen.blocksSight)
        luaunit.assertFalse(edgeOpen.blocksAttack)
    end