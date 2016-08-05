require 'Cell'
require 'Edge'

TestEdge_Instantiation = {}
    function TestEdge_Instantiation:setUp()
        -- 'open' Cells; thus don't interfere with 'pure' Edge
        cell_open = Cell:new{blocksMove = false, blocksSight = false, blocksAttack = false}
        cell_wall = Cell:new{blocksMove = true, blocksSight = true, blocksAttack = true}
    end

    function TestEdge_Instantiation:test_args_empty()
        local edge = Edge:new(cell_open, cell_open, {})
        luaunit.assertFalse(edge.intrinsic.blocksMove)
        luaunit.assertFalse(edge.intrinsic.blocksSight)
        luaunit.assertFalse(edge.intrinsic.blocksAttack) 
    end
    
    function TestEdge_Instantiation:test_args_none()
        local edge = Edge:new(cell_open, cell_open)
        luaunit.assertFalse(edge.intrinsic.blocksMove)
        luaunit.assertFalse(edge.intrinsic.blocksSight)
        luaunit.assertFalse(edge.intrinsic.blocksAttack) 
    end
    
    function TestEdge_Instantiation:test_args_booleans_trueFalse()
        local edge = Edge:new(cell_open, cell_open, {blocksMove = true})  -- blocksMove
        luaunit.assertTrue(edge.intrinsic.blocksMove)
        edge = Edge:new(cell_open, cell_open, {blocksMove = false})
        luaunit.assertFalse(edge.intrinsic.blocksMove)
        
        edge = Edge:new(cell_open, cell_open, {blocksSight = true} )      -- blocksSight
        luaunit.assertTrue(edge.intrinsic.blocksSight)
        edge = Edge:new(cell_open, cell_open, {blocksSight = false})
        luaunit.assertFalse(edge.intrinsic.blocksSight)
        
        edge = Edge:new(cell_open, cell_open, {blocksAttack = true})      -- blocksAttack
        luaunit.assertTrue(edge.intrinsic.blocksAttack)
        edge = Edge:new(cell_open, cell_open, {blocksAttack = false})
        luaunit.assertFalse(edge.intrinsic.blocksAttack)
    end

    function TestEdge_Instantiation:test_cell_1_wall()
        local edge = Edge:new(cell_wall, cell_open)
        luaunit.assertTrue(edge.blocksMove)
        luaunit.assertTrue(edge.blocksSight)
        luaunit.assertTrue(edge.blocksAttack)
    end

    function TestEdge_Instantiation:test_cell_2_wall()
        local edge = Edge:new(cell_open, cell_wall)
        luaunit.assertTrue(edge.blocksMove)
        luaunit.assertTrue(edge.blocksSight)
        luaunit.assertTrue(edge.blocksAttack)
    end

    function TestEdge_Instantiation:test_cell_12_wall()
        local edge = Edge:new(cell_wall, cell_wall)
        luaunit.assertTrue(edge.blocksMove)
        luaunit.assertTrue(edge.blocksSight)
        luaunit.assertTrue(edge.blocksAttack)
    end

-- final 'tear down'
cell_open = nil; cell_open = nil