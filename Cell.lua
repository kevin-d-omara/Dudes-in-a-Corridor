--[[
Class - Cell
Description:
    A Cell represents a single square on the game board.  It is a container for
    all game elements which are "placed on" and "moved around" the board.
Hierarchy:
    Ancestors: none
    Children:  none
Fields:
    - boolean  :: blocksMove, blocksSight, blocksAttack
    - table {} :: intrinsic
        - boolean :: blocksMove, blocksSight, blocks
      TODO need duplicate fields for square itself (i.e. wall vs token)
Public API
    - boolean  :: blocksMove, blocksSight, blocksAttack
--]]

Cell = {}
function Cell:new(args)
    local obj = {}
    
    -- default Cell is a 'wall' with no contained elements
    if args == nil then args = {} end
    obj.blocksMove = (args.blocksMove == nil) and true or args.blocksMove
    obj.blocksSight = (args.blocksSight == nil) and true or args.blocksSight
    obj.blocksAttack = (args.blocksAttack == nil) and true or args.blocksAttack
    
    setmetatable(obj, self)
    self.__index = self
    --table.insert(Cell.allCells, obj)
    obj:updateBooleans()
    return obj
end

--[[
- Keeps 'ray interaction' booleans up to date so that the raycasting algorithm
  is as fast as possible.
- Must be called whenever the Cell's state changes.
--]]
function Cell:updateBooleans()
    -- Each public value is the 'logical or' of all its component values
    -- If any component blocks, then the public value is 'true'
    
    -- TODO: implement + test
end