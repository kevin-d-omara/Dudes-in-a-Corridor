--[[
Purpose: to test 100% of the Unit Tests available
Documentation: http://luaunit.readthedocs.io/en/latest/
--]]

luaunit = require('/tests/luaunit')

-- contents of Unit Test Suite      --> TODO: automate this
require '/tests/Cell/test_instantiation'
require '/tests/Grid/test_instantiation'
require '/tests/Grid/test_hasSight'

-- begin tests
lu = luaunit.LuaUnit.new()
lu:setOutputType("tap")
os.exit( lu:runSuite() )