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

M.directions = {
    BOTTOM_RIGHT = 1, TOP_RIGHT=2, TOP = 3, TOP_LEFT=4, BOTTOM_LEFT = 5, BOTTOM = 6
}

M.cube_direction_vectors = {
    vmath.vector3(1,0,-1),vmath.vector3(1,-1,0),vmath.vector3(0,-1,1),
    vmath.vector3(-1,0,1),vmath.vector3(-1,1,0),vmath.vector3(0,1,-1)
}

function M.cude_direction(direction)
    return cube_direction_vectors[direction]
end

function M.cube_add(hex, vec)
    return vmath.vector3(hex.x + vec.x, hex.y + vec.y, hex.z + vec.z)
end

function M.cube_neighbor(cube, direction)
    return M.cube_add(cube, M.cube_direction(direction))
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

return M