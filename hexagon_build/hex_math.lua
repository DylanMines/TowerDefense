local M = {}

--[[
HEX DIRECTIONS
           _____
           /     \
          /       \
    ,----<    3    >----.
   /      \       /      \
  /        \_____/        \
  \    4   /     \    2   /
   \      /       \      /
    >----<         >----<
   /      \       /      \
  /    5   \_____/    1   \
  \        /     \        /
   \      /       \      /
    `----<    6    >----'
          \       /
           \_____/
vmath.vector3(q,r,s) for cude coordinates
]]

--neighbors
M.DIRECTIONS = {
    BOTTOM_RIGHT = 1, TOP_RIGHT=2, TOP = 3, TOP_LEFT=4, BOTTOM_LEFT = 5, BOTTOM = 6
}

M.CUBE_DIRECTION_VECTORS = {
    vmath.vector3(1,0,-1),vmath.vector3(1,-1,0),vmath.vector3(0,-1,1),
    vmath.vector3(-1,0,1),vmath.vector3(-1,1,0),vmath.vector3(0,1,-1)
}

function M.cude_direction(direction)
    return M.CUBE_DIRECTION_VECTORS[direction]
end

function M.cube_neighbor(cube, direction)
    return cube + M.cube_direction(direction)
end

--conversions
function M.cube_to_axial(cube)
    return vmath.vector3(cube.x, cube.y, 0)
end

function M.axial_to_cube(axial)
    local q = axial.x   
    local r = axial.y
    return vmath.vector3(q,r,-q-r)
end

--transform
local function rotate_cube(cube,center) --vector3, vector3
    center = center or vmath.vector3(0)

    local vector = cube - center
    local rotated_vector = vmath.vector3(-vector.y,-vector.z,-vector.x)
    return rotated_vector + center
    --vec = cube_subtract(hex, center) = Cube(hex.q - center.q, hex.r - center.r, hex.s - center.s)
end

return M