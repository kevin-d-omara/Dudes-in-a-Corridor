--[[
Purpose: to run a single Unit Test file
Documentation: http://luaunit.readthedocs.io/en/latest/
--]]

luaunit = require('/tests/luaunit')

-- place single Unit Test file here
--require '/tests/Cell/test_instantiation'
--require '/tests/Edge/test_instantiation'
--require '/tests/Grid/test_instantiation'
--require '/tests/Grid/test_instantiation_2'
--require '/tests/Grid/test_hasSight'
require '/tests/Grid/test_hasSight_2'

-- begin tests
lu = luaunit.LuaUnit.new()
lu:setOutputType("text")    -- "tap"; other option
os.exit( lu:runSuite() )