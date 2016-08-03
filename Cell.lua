--[[
Class - Cell
Description:
    A Cell represents a single square on the game board.  It is a container for
    all game elements which are "placed on" and "moved around" the board.
Hierarchy:
    Ancestors: none
    Children:  none
Fields:
    - boolean blocksMove, blocksSight, blocks
      TODO need duplicate fields for square itself (i.e. wall vs token)
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

--[[ Define public API
boolean Cell.blocksMove
boolean Cell.blocksSight
boolean Cell.blocksAttack
It is the Cell's job to keep these updated, so that raycasts/LoS checks are as
fast as possible.  i.e. when a Token/Unit, etc. is inserted/removed, these
values should be updated.
--]]