--[[
Class - Grid
Description:
    A Grid is a rectangular collection of cells (i.e. 2d array).  Its cartesian
    coordinates (x,y) have their origin at the bottom left.
    i.e.  (1,2) (2,2)       ->(1,1) (1,2)
        ->(1,1) (2,1)   NOT   (2,1) (2,2)
Hierarchy:
    Ancestors: none
    Children:  none
Arguments:
    - string filename; path to file (i.e. 'maps/test1.map')
Fields:
    - integer lenX; horizontal width of grid
    - integer lenY; vertical width of grid
Functions:
    - 
--]]
require 'Cell'
require 'file_intput_output'    -- TODO: make local? test locality

Grid = {}
function Grid:new(filename)
    local grid = {}
    
    -- get dimensions from file
    local lines = linesFrom(filename)
    grid.lenX, grid.lenY = lines[2]:match("(%d+),(%d+)")
    grid.lenX = tonumber(grid.lenX)
    grid.lenY = tonumber(grid.lenY)
    
    -- create 2d array with default Cells
    for ii = 1, grid.lenX do
        grid[ii] = {}
        for jj = 1, grid.lenY do
            grid[ii][jj] = Cell:new{}
        end
    end
    
    -- read through file and insert entities into each square
    local entity = ''
    local ii = 3
    while ii <= #lines do repeat    -- repeat until w/ break == continue
        -- check for header/entity
        if lines[ii]:match("[/*]") then             -- delimited by '// '
            entity = lines[ii]:match("/*%s*(%g*)")  -- (Open, Token, Unit, etc.)
            ii = ii + 1; break
        end
        
        -- get coordinates (x,y)
        local x, y = lines[ii]:match("(%d+),(%d+)")
        x = tonumber(x); y = tonumber(y)
        
        if entity == 'OpenSquares' then -- set square to 'open' values
            grid[x][y].blocksMove = false
            grid[x][y].blocksSight = false
            grid[x][y].blocksAttack = false
        else -- insert element (rubble, etc.)
            --ii = ii + 1
            --local type = lines[ii]
            --grid[x][y].insert(entity, type)
        end
        
        ii = ii + 1
    until true end
    
    setmetatable(grid, self)
    self.__index = self
    --table.insert(Grid.allGrids, obj)
    return grid
end

-- include other functions
require 'Grid_hasSight'

---[[ FOR VISUAL TESTING (remove for release) ----------------------------------
function Grid:pprint()
    for i = 1, self.lenX do io.write('______') end; print('_')
    for y = self.lenY, 1, -1 do
        s1 = ''
        s2 = ''
        for i = 1, 2 do
            for x = 1, self.lenX do
                if self[x][y].blocksMove == true then
                    if i == 1 then
                        s1 = s1..'|XXXXX'
                    else
                        s2 = s2..'|X̲X̲X̲X̲X̲'
                    end
                elseif self[x][y].blocksMove == false then
                    if i == 1 then
                        s1 = s1..'|     '
                    else
                        s2 = s2..'|_____'
                    end
                else
                    s1 = s1..'|?*?'
                end
            end
        end
        
        io.write(s1); print('|')
        io.write(s1); print('|')
        io.write(s2); print('|')
    end
end

--g1 = Grid:new('tests/Grid/test_1.map'); g1:pprint()
--]]

-- TODO: define public interface