--[[
Class - Cell
Description:
    A Cell represents a single square on the game board.  It is a container for
    all game elements which are "placed on" and "moved around" the board.
Hierarchy:
    Ancestors: none
    Children:  none
Fields:
    - 
--]]

Cell = {}
function Cell:new(args)
    local obj = {}
    
    -- default Cell is a wall with no contained elements
    if args == nil then args = {} end
    obj.blocksMove = (args.blocksMove == nil) and true or args.blocksMove
    obj.blocksSight = (args.blocksSight == nil) and true or args.blocksSight
    obj.blocksAttack = (args.blocksAttack == nil) and true or args.blocksAttack
    
    setmetatable(obj, self)
    self.__index = self
    --table.insert(Cell.allCells, obj)
    return obj
end

-- define public interface
-- TODO