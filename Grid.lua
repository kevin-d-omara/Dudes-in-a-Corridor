--[[
Class - Grid
Description:
    A Grid is a rectangular collection of Cells and Edges (i.e. 2d array).
    Its cartesian coordinates (x,y) have their origin at the bottom left.
    i.e.  (1,2) (2,2)       ->(1,1) (1,2)
        ->(1,1) (2,1)   NOT   (2,1) (2,2)
Hierarchy:
    Ancestors: none
    Children:  none
Arguments:
    - string  :: filename; path to file (i.e. 'maps/test1.map')
Fields:
    - integer :: BUFFER; Number of 'wall' Cells bordering filename-defined Grid
    - integer :: lenX; horizontal width of grid
    - integer :: lenY; vertical width of grid
Functions:
    - 
Public API
    -
--]]
require 'Cell'
require 'Edge'
require 'file_intput_output'    -- TODO: make local? test locality

Grid = {}
Grid.BUFFER = 2 -- # of 'wall' Cells bordering Grid;
                -- to prevent nil dereferences by catching explosions etc.
function Grid:new(filename)
    local grid = {}
    
    -- get dimensions from file
    local lines = linesFrom(filename)
    grid.lenX, grid.lenY = lines[2]:match("(%d+),(%d+)")
    grid.lenX = tonumber(grid.lenX)
    grid.lenY = tonumber(grid.lenY)

    -- create 2d array with 'walls' Cells
    for xx = (1 - self.BUFFER), (grid.lenX + self.BUFFER) do
        grid[xx] = {}
        for yy = (1 - self.BUFFER), (grid.lenY + self.BUFFER) do
            grid[xx][yy] = Cell:new{type = 'wall'}
            --
        end
    end

    -- create 2d array with 'wall' Edges along the X-axis ( | | | )
    grid.edgeX = {}
    for xx = (1 - self.BUFFER), (grid.lenX + self.BUFFER + 1) do
        grid.edgeX[xx] = {}
        for yy = (1 - self.BUFFER), (grid.lenY + self.BUFFER) do
            grid.edgeX[xx][yy] = Edge:new{type = 'wall'}
        end
    end

    -- create 2d array with 'wall' Edges along the Y-axis ( __ __ __ )
    grid.edgeY = {}
    for xx = (1 - self.BUFFER), (grid.lenX + self.BUFFER) do
        grid.edgeY[xx] = {}
        for yy = (1 - self.BUFFER), (grid.lenY + self.BUFFER + 1) do
            grid.edgeY[xx][yy] = Edge:new{type = 'wall'}
        end
    end
    
    -- carve out 'open' map area, leave boarder of 'wall' Cells & Edges (buffer)
    for xx = 1, grid.lenX do    -- Cells
        for yy = 1, grid.lenY do
            grid[xx][yy] = Cell:new{type = 'open'}
        end
    end
    for xx = 2, grid.lenX do    -- edgeX
        for yy = 1, grid.lenX do
            grid.edgeX[xx][yy] = Edge:new{type = 'open'}
        end
    end
    for xx = 1, grid.lenX do    -- edgeY
        for yy = 2, grid.lenY do
            grid.edgeY[xx][yy] = Edge:new{type = 'open'}
        end
    end

    -- read through file and insert entities into each square
    -- Note: default state is 'open' Cells & Edges within map dimensions
    local entity = ''
    local ii = 3
    while ii <= #lines do
        -- check for header/entity
        if lines[ii]:match("[/*]") then             -- delimited by '// '
            entity = lines[ii]:match("/*%s*(%g*)")  -- (Open, Token, Unit, etc.)
            ii = ii + 1
        end
        
        -- get coordinates (x,y)
        local x, y = lines[ii]:match("(%d+),(%d+)")
        x = tonumber(x); y = tonumber(y)
        
        if entity == 'WallSquares' then -- set Cell & 4 Edges to 'wall'
            grid[x][y].type = Cell.types.wall
            grid.edgeX[x]  [y].type = Edge.types.wall
            grid.edgeX[x+1][y].type = Edge.types.wall
            grid.edgeY[x][  y].type = Edge.types.wall
            grid.edgeY[x][y+1].type = Edge.types.wall
        elseif entity == 'EdgeX' then   -- set X Edge to 'wall' values
            grid.edgeX[x][y].type = Edge.types.wall
        elseif entity == 'EdgeY' then   -- set Y Edge to 'wall' values
            grid.edgeY[x][y].type = Edge.types.wall
        else -- insert element (rubble, etc.)
            --ii = ii + 1
            --local type = lines[ii]
            --grid[x][y].insert(entity, type)
        end
        
        ii = ii + 1
    end

    -- update Cells and Edges to account for changed types & added entities
    for xx = (1 - self.BUFFER), (grid.lenX + self.BUFFER) do
        for yy = (1 - self.BUFFER), (grid.lenY + self.BUFFER) do
            grid[xx][yy]:updateBooleans()
        end
    end
    for xx = (1 - self.BUFFER), (grid.lenX + self.BUFFER + 1) do
        for yy = (1 - self.BUFFER), (grid.lenY + self.BUFFER) do
            grid.edgeX[xx][yy]:updateBooleans()
        end
    end
    for xx = (1 - self.BUFFER), (grid.lenX + self.BUFFER) do
        for yy = (1 - self.BUFFER), (grid.lenY + self.BUFFER + 1) do
            grid.edgeY[xx][yy]:updateBooleans()
        end
    end
    
    setmetatable(grid, self)
    self.__index = self
    --table.insert(Grid.allGrids, grid)
    
    -- TODO: UPDATE EVERYTHING
    
    return grid
end

-- include other functions
require 'Grid_hasSight'

---[[ FOR VISUAL TESTING (remove for release) ----------------------------------
function Grid:pprint(withBuffer)
    local buffer = withBuffer and self.BUFFER or 0
    local yStart = self.lenY + buffer
    local yEnd = 1 - buffer
    local xStart = 1 - buffer
    local xEnd = self.lenX + buffer
    
    for i = 1, self.lenX do io.write('______') end; print('_')
    for y = yStart, yEnd, -1 do
        s1 = ''
        s2 = ''
        for i = 1, 2 do
            for x = xStart, xEnd do
                if self[x][y].blocksSight == true then
                    if i == 1 then
                        s1 = s1..'|XXXXX'
                    else
                        s2 = s2..'|X̲X̲X̲X̲X̲'
                    end
                elseif self[x][y].blocksSight == false then
                    if i == 1 then
                        s1 = s1..'|     '   -- ‖
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

--g1 = Grid:new('tests/Grid/test_1.map'); g1:pprint(false)
--]]