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


function Grid:buildFrom(file)
    local lines = linesFrom(file)    
    local x, y = lines[2]:match("(%d+),(%d+)")
    x = tonumber(x); y = tonumber(y)
    local grid = Grid:new{lenX = x, lenY = y}

    -- read through lines and insert entities into each square
    local entity = ''
    local ii = 1
    while ii <= #lines do repeat    -- repeat until w/ break == continue
        if lines[ii]:match("[/*]") then             -- delimited by '// '
            entity = lines[ii]:match("/*%s*(%g*)")  -- (Open, Token, Unit, etc.)
            ii = ii + 1; break
        end
        
        local x, y = lines[ii]:match("(%d+),(%d+)")
        x = tonumber(x); y = tonumber(y)
        if entity == 'Open' then                -- set square to 'open' values
            grid[x][y].blocksMove = false
            grid[x][y].blocksSight = false
            grid[x][y].blocksAttack = false
        else                                    -- insert element (rubble, etc.)
            --ii = ii + 1
            --local type = lines[ii]
            --grid[x][y].insert(entity, type)
        end
        
        ii = ii + 1
    until true end
    
    return grid
end

-- TODO: define public interface