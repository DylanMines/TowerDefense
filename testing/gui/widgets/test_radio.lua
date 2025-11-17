require "deftest.deftest"
M = require "gui.widgets.radio.radio"

return function()
    describe("radio class", function()
        test("test class creation", function ()
            local test_radio = M:new({"1","2","3"})
            assert_same({"1","2","3"}, test_radio:get_objects())
        end)
    end)
end