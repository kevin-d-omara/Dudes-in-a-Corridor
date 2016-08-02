--[[
Purpose: to run a single Unit Test file
Documentation: http://luaunit.readthedocs.io/en/latest/
--]]

luaunit = require('/tests/luaunit')

-- place single Unit Test file here
require '/tests/Grid/test_instantiation'
--require '/tests/Cell/test_instantiation'

-- begin tests
lu = luaunit.LuaUnit.new()
lu:setOutputType("tap")
os.exit( lu:runSuite() )