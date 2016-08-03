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
function Grid:hasSight(x1, y1, x2, y2, test)    -- test is for testing only
    test = test or false
    local dx = x2 - x1
    local dy = y2 - y1
    -- check for divide by zero
    local m  = dy / dx
    local b  = y1 - m * x1
    -- check for 'up -> right' orientation, rotate if necessary
    
    local x = x1 + 1
    local y = m * x + b + 0.5
    for i = 1, dx do
        if self[x][math.floor(y)].blocksSight then return false end
        x = x + 1
        y = y + m
    end

    local y = y1 + 1
    --local x = (y + 0.5 - b) / m
    local x = (y + 0.5 - b) / m - 1 -- works, don't know why
    local stepX = 1 / m
    
    if test then print('y: '..y) end
    if test then print('x: '..x) end
    
    for j = 1, dy do
        if test then print('('..math.floor(x)..','..y..')') end
        if self[math.floor(x)][y].blocksSight then return false end
        y = y + 1
        x = x + stepX
    end
    if test then print(self[13][5].blocksSight) end

    return true
end








--[[
    -- check for 'up -> right' orientation, rotate if necessary
    print('--------')
    print('pt1('..x1..','..y1..')')
    print('pt2('..x2..','..y2..')')
    print('dx: '..dx..'; dy: '..dy)
    print('m : '..m)  
    
    local x = x1 + 1
    local y = m * x + b +0.5
    print('xi: '..x)
    print('yi: '..y)
    print('--------')
    for i = 1, dx do
        print('x :'..x)
        print('y :'..y)
        print('y_:'..math.floor(y))
        if self[x][math.floor(y)].blocksSight then return false end
        x = x + 1
        y = y + m
    end
--]]







--[[ For optimization testing:
    local sightBlocked = false
    local x = x1 + 1
    local y = m * x
    for i = 1, dx do
        sightBlocked = self[x][y].blocksSight or sightBlocked
        x = x + 1
        y = y + m
    end
    if sightBlocked then return false end
--]]





















