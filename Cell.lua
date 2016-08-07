--[[
Class - Cell
Description:
    A Cell represents a single square on the game board.  It is a container for
    all game elements which are "placed on" and "moved around" the board.
Hierarchy:
    Ancestors: none
    Children:  none
Arguments:
    - table {} :: args; optional arguments (blocksMove, etc.)
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
    local cell = {}
    
    -- default Cell is a 'wall' with no contained elements
    if args == nil then args = {} end
    cell.blocksMove = (args.blocksMove == nil) and true or args.blocksMove
    cell.blocksSight = (args.blocksSight == nil) and true or args.blocksSight
    cell.blocksAttack = (args.blocksAttack == nil) and true or args.blocksAttack
    
    setmetatable(cell, self)
    self.__index = self
    --table.insert(Cell.allCells, cell)
    cell:updateBooleans()
    return cell
end

--[[
- Keeps 'ray interaction' booleans up to date so that the raycasting algorithm
  is as fast as possible.
- Must be called whenever the Cell's state changes.
--]]
function Cell:updateBooleans()
    -- Each public value is the 'logical or' of all its component values
    -- If any component blocks, then the public value is 'true'
        -- ^ each component must implement 'sightBlocking', 'moveBlocking', etc.
        -- composition > inheritance, i.e. 'quackable', 'flyable', etc.
    -- TODO: implement + test
    -- Update Edges when self updated (!)
end