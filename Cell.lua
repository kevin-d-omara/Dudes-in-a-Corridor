--[[
Class - Cell
Description:
    A Cell represents a single square on the game board.  It is a container for
    all game entities which are "placed on" and "moved around" the board.
Hierarchy:
    Ancestors: none
    Children:  none
Arguments:
    - table {} :: args; optional arguments (type, blocksMove, etc.)
Fields:
    - table {} :: type
        {boolean :: blocksMove, blocksSight, blocks}
    - boolean  :: blocksMove, blocksSight, blocksAttack
Public API
    - boolean  :: blocksMove, blocksSight, blocksAttack
--]]

Cell = {}

Cell.types =
{
    wall = {blocksMove=true , blocksSight=true , blocksAttack=true},
    open = {blocksMove=false, blocksSight=false, blocksAttack=false}
}

function Cell:new(args)
    local cell = {}
    
    -- default Cell is a 'wall' with no entities
    if args == nil then args = {} end
    cell.type = (args.type == nil) and self.types.wall or self.types[args.type]
    cell.blocksMove   = cell.type.blocksMove
    cell.blocksSight  = cell.type.blocksSight
    cell.blocksAttack = cell.type.blocksAttack
    
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
    self.blocksMove   = self.type.blocksMove -- or entity.blocksMove or ...
    self.blocksSight  = self.type.blocksSight
    self.blocksAttack = self.type.blocksAttack
end
