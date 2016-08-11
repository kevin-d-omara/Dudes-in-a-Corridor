--[[
Class - Edge
Description:
    An Edge is the line segment between two orthogonal Cell faces.  It is a
    container for game entities such as a Door or Breach.
Hierarchy:
    Ancestors: none
    Children:  none
Arguments:
    - table {} :: args; optional arguments (type, etc.)
Fields:
    - table {} :: type
        {boolean :: blocksMove, blocksSight, blocks}
    - boolean  :: blocksMove, blocksSight, blocksAttack
Public API
    - boolean  :: blocksMove, blocksSight, blocksAttack
--]]

Edge = {}

Edge.types =
{
    wall = {blocksMove=true , blocksSight=true , blocksAttack=true},
    open = {blocksMove=false, blocksSight=false, blocksAttack=false}
}

function Edge:new(args)
    local edge = {}
    
    -- default Edge is a 'open' with no entities
    if args == nil then args = {} end
    edge.type = ((args.type == nil) and {self.types.open}
                                     or {self.types[args.type]})[1]
    edge.blocksMove   = edge.type.blocksMove
    edge.blocksSight  = edge.type.blocksSight
    edge.blocksAttack = edge.type.blocksAttack
    
    setmetatable(edge, self)
    self.__index = self
    --table.insert(Edge.allEdges, edge)
    edge:updateBooleans()
    return edge
end

--[[
- Keeps 'ray interaction' booleans up to date so that the raycasting algorithm
  is as fast as possible.
- Must be called whenever the Edge's state changes.
--]]
function Edge:updateBooleans()
    -- Each public value is the 'logical or' of all its component values
    self.blocksMove   = self.type.blocksMove -- or entity.blocksMove or ...
    self.blocksSight  = self.type.blocksSight
    self.blocksAttack = self.type.blocksAttack
end












