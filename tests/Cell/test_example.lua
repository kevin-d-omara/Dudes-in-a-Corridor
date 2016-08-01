-- function I want to test
require 'functionsToTest'


--[[
LuaUnit Tests are functions prefaced with 'test' (case-insensitive) and may be
stored within a table (also beginning with 'test')
--]]

--- test 'add' function --------------------------------------------------------
TestAdd = {}
    function TestAdd:testAddPositive()
        luaunit.assertEquals(add(1,1),2)
    end
    
--[[
    function TestAdd:testThisShouldFail()
        luaunit.assertEquals(add(2,-3),2)
    end
--]]

    function TestAdd:testAddZero()
        luaunit.assertEquals(add(1,0),0)
        luaunit.assertEquals(add(0,5),0)
        luaunit.assertEquals(add(0,0),0)
    end

    function TestAdd:testAddError()
        luaunit.assertErrorMsgContains('Can only add positive or null numbers, received 2 and -3', add, 2, -3)
    end
-- end of table TestAdd

--- test 'adder' function ------------------------------------------------------
TestAdder = {}
    function TestAdder:testAdder()
        f = adder(3)
        luaunit.assertIsFunction( f )
        luaunit.assertEquals( f(2), 5 )
    end
-- end of table TestAdder

-- test 'div' function ---------------------------------------------------------
TestDiv = {}
    function TestDiv:testDivPositive()
        luaunit.assertEquals(div(4,2),2)
    end

    function TestDiv:testDivZero()
        luaunit.assertEquals(div(4,0),0)
        luaunit.assertEquals(div(0,5),0)
        luaunit.assertEquals(div(0,0),0)
    end

    function TestDiv:testDivError()
        luaunit.assertErrorMsgContains('Can only divide positive or null numbers, received 2 and -3', div, 2, -3)
    end
-- end of table TestDiv



--[[
~~ demonstrate 'setUp()' and 'tearDown()' functionality
    'setUp()' called before each test within table
    'tearDown()' called after each test within a table

-- test 'logger' function ------------------------------------------------------
TestLogger = {}
    function TestLogger:setUp()
        -- define the fname to use for logging
        self.fname = 'mytmplog.log'
        -- make sure the file does not already exists
        os.remove(self.fname)
    end

    function TestLogger:testLoggerCreatesFile()
        initLog(self.fname)
        log('toto')
        -- make sure that our log file was created
        f = io.open(self.fname, 'r')
        luaunit.assertNotNil( f )
        f:close()
    end

    function TestLogger:tearDown()
        -- cleanup our log file after all tests
        os.remove(self.fname)
    end
--]]