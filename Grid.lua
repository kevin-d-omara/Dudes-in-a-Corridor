--[[
Class - Grid
Description:
    A Grid is a rectangular collection of cells (i.e. 2d array).  Its cartesian
    coordinates (x,y) have their origin at the bottom left.
    i.e.  (1,2) (2,2)         (1,1) (1,2)
          (1,1) (2,1)   NOT   (2,1) (2,2)
Hierarchy:
    Ancestors: none
    Children:  none
Fields:
    - integer lenX; horizontal width of grid
    - integer lenY; vertical width of grid
Functions:
    - 
--]]
require 'Cell'
require 'file_intput_output'    -- TODO: make local? test locality

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


function Grid:makeFrom(file)
    local lines = linesFrom(file)

    for i,v in ipairs(lines) do
      print('line[' .. i .. ']', v)
    end
    
    --http://stackoverflow.com/questions/19262761/lua-need-to-split-at-comma
end

Grid:makeFrom('dummyfile.txt')
-- TODO: define public interface