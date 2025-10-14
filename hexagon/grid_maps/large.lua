-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local M = {}

M.layout_1 = {
    {0,0},{0,-1},{1,-1},{1,0},{0,1},{-1,1},{-1,0}
}

return M
