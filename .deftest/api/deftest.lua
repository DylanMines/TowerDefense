---@meta

--telescope API documentation
---@class deftest
deftest = {}

---creates a collection of tests
---@param title string title of the test collection
---@param collection function a function containing other collections or tests
---@return nil
function describe(title, collection) end

---unit test
---@param title any
---@param test any
---@return nil
function test(title, test) end

---true if a == b
---@param a any
---@param b any
---@return nil
function assert_equal(a, b)
    
end