--[[
Purpose: to automate a collection (Suite) of Unit Tests
Documentation: http://luaunit.readthedocs.io/en/latest/
--]]

luaunit = require('/tests/luaunit')

-- contents of Unit Test Suite
require '/tests/Grid/test_instantiation'
require '/tests/Grid/test_hasSight'

-- begin tests
lu = luaunit.LuaUnit.new()
lu:setOutputType("tap")
os.exit( lu:runSuite() )