--[[
Description:
    Checks if a line can be drawn between the center of two squares/cells.
    Overlapping corners block sight, even if separated, but one corner does not.
    i.e. 'A' cannot see 'B' because the wall's (X) have overlapping corners.
    'A' can't see 'B'       'A' can see 'B'
        XB    OXB           OB    OXB
        AX    OOO           AX    OOO
              AXO                 AOO

    TODO: add robust diagrams from pprint()
    Note: eplison = 1*10^-7; deemed unnecessary

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
    -- check negative slope
    
    local dx = x2 - x1
    local dy = y2 - y1
    local m = dy/dx
    local b = y1 - m*x1
    local theta = math.deg(math.atan(dy,dx))

    local x = x1 + 0.5
    local y = m*x + b
    local numStepsX = (math.abs(theta) < 45.0) and (dx - 1) or (dx + 1)
    if math.abs(m) == 1/0 then numStepsX = 0 end
    local topCornerBlocked, bottomCornerBlocked = false, false
    local eps = 0.0000001
    
    for i = 1, numStepsX do
        if math.abs(y - math.floor(y + eps)) < eps then
            -- corner
        else
            if self[math.floor(x)][math.floor(y)].blocksSight then
                return false
            end
        end
        x = x + 1
        y = y + m
    end
    if topCornerBlocked and bottomCornerBlocked then return false end

    y = y1 + ((m > 0) and 0.5 or -1.5)
    local stepY = (m > 0) and 1 or -1
    local stepX
    if dx == 0 then
        x = x1
        stepX = 0
    else
        x = (y - b)/m
        stepX = 1/m
    end
    local numStepsY = (math.abs(theta) < 45.0) and (dy) or (dy - 1)
    
    for j = 1, math.abs(numStepsY) do
        if math.abs(x - math.floor(x + eps)) < eps then
            -- nothing, corner already handled in x-loop
        else
            if self[math.floor(x)][math.floor(y)].blocksSight then
                return false
            end
        end
        y = y + stepY
        x = x + stepX
    end

    return true
end















--[[
    -- check negative slope
    
    THETA

    if test then print('--------') end
    if test then print('pt1('..x1..','..y1..')') end
    if test then print('pt2('..x2..','..y2..')') end
    if test then print('dx: '..dx..'; dy: '..dy) end
    if test then print('m : '..m) end
    if test then print('b : '..b) end
    if test then print('theta : '..theta) end

    PRE - LOOP X
    
    if test then print('X--------------------------') end
    if test then print('x: '..x) end
    if test then print('y: '..y) end
    if test then print('numStepsX: '..numStepsX) end
    
    LOOP X
    
    if test then print('('..math.floor(x)..','..math.floor(y)..')') end
    
    PRE - LOOP Y
    
    if test then print('Y--------------------------') end
    if test then print('x: '..x) end
    if test then print('y: '..y) end
    if test then print('numStepsY: '..numStepsY) end
    if test then print('stepX: '..stepX) end
    if test then print('stepY: '..stepY) end
    
    LOOP Y
    
    if test then print('('..math.floor(x)..','..math.floor(y)..')') end
--]]



























