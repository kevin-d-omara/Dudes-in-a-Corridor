--[[
Class - Grid
Description:
    A grid is a rectangular collection of cells (i.e. 2d array).
Hierarchy:
    Ancestors: none
    Children:  none
Fields:
    - 
--]]
require 'Cell'

Grid = {}
function Grid:new(args)
    local obj = {}
    
    -- default Grid is 10x10
    if args == nil then args = {} end
    obj.lenX = (args.lenX == nil) and 10 or args.lenX
    obj.lenY = (args.lenY == nil) and 10 or args.lenY
    
    for ii = 1, obj.lenX do
        obj[ii] = {}
        for jj = 1, obj.lenY do
            obj[ii][jj] = Cell:new{}
        end
    end
    
    setmetatable(obj, self)
    self.__index = self
    --table.insert(Grid.allGrids, obj)
    return obj
end

-- define public interface
-- TODO