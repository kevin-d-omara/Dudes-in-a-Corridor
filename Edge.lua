--[[
Class - Edge
Description:
    An Edge is the line segment between two orthogonal Cell faces.  It is a
    container for game elements such as a Door or Breach.  It's ray blocking
    properties are defined by both its intrinsic values and the two Cell faces
    perpendicular to it.
Hierarchy:
    Ancestors: none
    Children:  none
Arguments:
    - Cell :: cell_1, cell_2; the two orthogonal Cells sharing this Edge
                            ; note: for 'Grid.edgeX' this is left + right
                            ;       for 'Grid.edgeY' this is top  + bottom
    - table {} :: args; optional arguments (blocksMove, etc.)
Fields:
    - boolean  :: blocksMove, blocksSight, blocksAttack
    - table {} :: intrinsic {}
        - boolean :: blocksMove, blocksSight, blocks
Public API
    - boolean  :: blocksMove, blocksSight, blocksAttack
--]]

Edge = {}
function Edge:new(cell_1, cell_2, args)
    local obj = {}
    
    -- default Edge is 'open' with no contained elements
    if args == nil then args = {} end
    obj.intrinsic = {}
    obj.intrinsic.blocksMove = ((args.blocksMove == nil) and {false} or
        {args.blocksMove})[1]
    obj.intrinsic.blocksSight = ((args.blocksSight == nil) and {false} or
        {args.blocksSight})[1]
    obj.intrinsic.blocksAttack = ((args.blocksAttack == nil) and {false} or
        {args.blocksAttack})[1]

    obj.cell_1 = cell_1
    obj.cell_2 = cell_2
    
    -- public values defined by 'logical or' of all components
    obj.blocksMove = false
    obj.blocksSight = false
    obj.blocksAttack = false
    
    setmetatable(obj, self)
    self.__index = self
    --table.insert(Edge.allEdges, obj)
    obj:updateBooleans()
    return obj
end

--[[
- Keeps 'ray interaction' booleans up to date so that the raycasting algorithm
  is as fast as possible.
- Must be called whenever the Edge's state changes.
--]]
function Edge:updateBooleans()
    -- Each public value is the 'logical or' of all its component values
    -- If any component blocks, then the public value is 'true'
    self.blocksMove = self.intrinsic.blocksMove   or self.cell_1.blocksMove
                                                  or self.cell_2.blocksMove
    self.blocksSight = self.intrinsic.blocksMove  or self.cell_1.blocksSight
                                                  or self.cell_2.blocksSight
    self.blocksAttack = self.intrinsic.blocksMove or self.cell_1.blocksAttack
                                                  or self.cell_2.blocksAttack
end