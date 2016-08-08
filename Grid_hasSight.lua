--[[
Description:
    Checks if a line can be drawn between the center of two squares/cells.
    
    The algorithm works as follows:
        Cast a ray between the between source (x1,y1) and target (x2,y2).
        
        ---- X LOOP ----
        For each point where ray crosses lines ⊥ to y-axis (-> | ->) check:
        - if corner:
            check 4 Edges making a '+' centered on the corner point
            check 2 Cells on the diagonals of the '+' which are ⊥ to the ray
            ^ keep track of 'top' and 'bottom' corners separately
        - else:
            check Edge
            check Cell immediately behind that Edge
        ----------------
        - check if 'top' and 'bottom' corners are both blocked

        ---- Y LOOP ----                                     ^
        For each point where ray crosses lines ⊥ to x-axis (---) check:
        - if not corner:                                     ^
            check Edge
        - check Cell immediately behind that Edge/corner
        ----------------
        - check Edge adjacent to target (x2,y2) which faces source (x1,y1)    
    
    Overlapping corners block sight, even if separated, but one corner does not.
    'A' can't see 'B'       'A' can see 'B'
        XB    OXB           OB    OXB
        AX    OOO           AX    OOO
              AXO                 AOO
    Note: eplison = 1*10^-7; not necessary b/c double precision is very accurate
Arguments:
    - number x1, y1; position of source cell
    - number x2, y2; position of target cell
Example use:
    -- find all enemies in LoS of 'unit'
    for _, enemy in ipairs(allEnemies) do
        if grid:hasSight(unit.x, unit.y, enemy.x, enemy.y) then
            table.insert(unit.visibleEnemies, enemy)
        end
    end
--]]
function Grid:hasSight(x1, y1, x2, y2)
    x1 = x1 + 0.5; y1 = y1 + 0.5    -- offset to center of square
    x2 = x2 + 0.5; y2 = y2 + 0.5

    if x2 < x1 then -- make (x1,y1) be on left
        x1, y1, x2, y2 = x2, y2, x1, y1
    end

    local dx = x2 - x1
    local dy = y2 - y1
    local m = dy/dx
    local b = y1 - m*x1
    local theta = math.deg(math.atan(dy,dx))

-- X LOOP (PRE)
    local x = x1 + 0.5
    local y = m*x + b
    local numStepsX = (math.abs(theta) < 45.0) and (dx - 1) or (dx)
    if math.abs(m) == 1/0 then numStepsX = 0 end
    local topCornerBlocked, bottomCornerBlocked = false, false
    local shiftTop = (m > 0) and -1 or 0   -- for cornerTopBlocked
    local shiftBot = (m > 0) and 0 or -1   -- for cornerBottomBlocked
    local eps = 0.0000001

-- X LOOP
    -- check collisions where ray crosses lines ⊥ to y-axis (-> | ->)
    for i = 1, numStepsX do
        if math.abs(y - math.floor(y + eps)) >= eps then -- check EdgeX & Cell
            if self.edgeX[math.floor(x)][math.floor(y)].blocksSight or
               self      [math.floor(x)][math.floor(y)].blocksSight then
                return false
            end
        else -- check corners (i.e. 4 Edges & 2 Cells)
            topCornerBlocked = topCornerBlocked
            or self.edgeX[math.floor(x)][math.floor(y+eps)].blocksSight
            or self.edgeY[math.floor(x)+shiftTop][math.floor(y+eps)].blocksSight
            or self      [math.floor(x)+shiftTop][math.floor(y+eps)].blocksSight

            bottomCornerBlocked = bottomCornerBlocked
            or self.edgeX[math.floor(x)][math.floor(y+eps)-1].blocksSight
            or self.edgeY[math.floor(x)+shiftBot][math.floor(y+eps)].blocksSight
            or self      [math.floor(x)+shiftBot][math.floor(y+eps)-1].blocksSight
        end
        x = x + 1
        y = y + m
    end   
    if topCornerBlocked and bottomCornerBlocked then return false end

-- Y LOOP (PRE)
    y = y1 + ((m > 0) and 0.5 or -0.5)
    local shiftY = (m > 0) and 0 or 1
    local stepY = (m > 0) and 1 or -1
    local stepX
    if dx == 0 then
        x = x1
        stepX = 0
    else
        x = math.abs((y - b)/m)
        stepX = math.abs(1/m)
    end
    local numStepsY = (math.abs(theta) < 45.0) and math.abs(dy)
                                                or math.abs(dy) - 1

-- Y LOOP                                                     ^
    -- check collisions where ray crosses lines ⊥ to x-axis (---)
    for j = 1, numStepsY do --                                ^
        -- check Cell
        if self[math.floor(x+eps)][math.floor(y)-shiftY].blocksSight then
            return false
        end
        -- if not corner, check EdgeY
        if math.abs(x - math.floor(x + eps)) >= eps then
            if self.edgeY[math.floor(x+eps)][math.floor(y)].blocksSight then
                return false
            end
        end
        y = y + stepY
        x = x + stepX
    end

    -- FINAL EDGE -> Check last edge immediately before target (x2,y2)
    -- Target's Cell always blocks itself, this avoids checking it in X/Y LOOP
    if math.abs(theta) < 45.0 then      -- check final EdgeX
        if self.edgeX[math.floor(x2)][math.floor(y2)].blocksSight then
            return false
        end
    elseif math.abs(theta) > 45.0 then  -- check final EdgeY
        if self.edgeY[math.floor(x2)][math.floor(y2)+shiftY].blocksSight then
            return false
        end
    end

    return true
end
