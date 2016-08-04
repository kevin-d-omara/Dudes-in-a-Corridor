--[[
Description:
    Checks if a line can be drawn between the center of two squares/cells.
    Overlapping corners block sight, even if separated, but one corner does not.
    'A' can't see 'B'       'A' can see 'B'
        XB    OXB           OB    OXB
        AX    OOO           AX    OOO
              AXO                 AOO
    Note: eplison = 1*10^-7; not necessary b/c Lua double precision rocks
Arguments:
    - number x1, y1; position of first cell
    - number x2, y2; position of second cell
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

    if x2 < x1 then -- make pt1 be on left
        x1, y1, x2, y2 = x2, y2, x1, y1
    end
    
-- X LOOP (PRE)
    local dx = x2 - x1
    local dy = y2 - y1
    local m = dy/dx
    local b = y1 - m*x1
    local theta = math.deg(math.atan(dy,dx))

    local x = x1 + 0.5
    local y = m*x + b
    local numStepsX = (math.abs(theta) < 45.0) and (dx - 1) or (dx)
    if math.abs(m) == 1/0 then numStepsX = 0 end
    local topCornerBlocked, bottomCornerBlocked = false, false
    local shiftTop = (m > 0) and -1 or 0   -- for cornerTopBlocked
    local shiftBot = (m > 0) and 0 or -1   -- for cornerBottomBlocked
    local eps = 0.0000001

-- X LOOP
    -- check vertical edge collisions; (i.e. ray ⊥ y-axis '-> | ->' )
    for i = 1, numStepsX do
        if math.abs(y - math.floor(y + eps)) >= eps then
            if self[math.floor(x)][math.floor(y)].blocksSight then
                return false
            end
        else -- check corners
            topCornerBlocked = topCornerBlocked or
                self[math.floor(x)+shiftTop][math.floor(y+eps)].blocksSight
            bottomCornerBlocked = bottomCornerBlocked or
                self[math.floor(x)+shiftBot][math.floor(y+eps)-1].blocksSight
        end
        x = x + 1
        y = y + m
    end
    if topCornerBlocked and bottomCornerBlocked then return false end

-- Y LOOP (PRE)
    y = y1 + ((m > 0) and 0.5 or -0.5)
    local shiftY = (m > 0) and 0 or -1
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

-- Y LOOP
    -- check horizontal edge collisions; (i.e. ray ⊥ x-axis '--')
    for j = 1, numStepsY do
        if self[math.floor(x+eps)][math.floor(y)+shiftY].blocksSight then
            return false
        end
        y = y + stepY
        x = x + stepX
    end

    return true
end
