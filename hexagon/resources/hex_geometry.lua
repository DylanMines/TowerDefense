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

local ORIENTATION = {
	f0 = 3 / 2,
	f1 = 0,
	f2 = math.sqrt(3) / 2,
	f3 = math.sqrt(3),
	b0 = 2 / 3,
	b1 = 0,
	b2 = -1 / 3,
	b3 = math.sqrt(3) / 3,
	start_angle = 0,
}

local CUBE_DIRECTION_VECTORS = {
    vmath.vector3(1,0,-1),vmath.vector3(1,-1,0),vmath.vector3(0,-1,1),
    vmath.vector3(-1,0,1),vmath.vector3(-1,1,0),vmath.vector3(0,1,-1)
}

local function cube_direction(direction)
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

function M.get_horizontal_distance(size)
    return ORIENTATION.f0*size
end

function M.get_vertical_distance(size)
    return ORIENTATION.f3*size+0.5
end

--transform
function M.rotate_cube(cube,center) --vector3, vector3
    center = center or vmath.vector3(0)

    local vector = cube - center
    local rotated_vector = vmath.vector3(-vector.y,-vector.z,-vector.x)
    return rotated_vector + center
    --vec = cube_subtract(hex, center) = Cube(hex.q - center.q, hex.r - center.r, hex.s - center.s)
end

function M.cube_round(frac)
    local q = math.floor(frac.x+0.5)
    local r = math.floor(frac.y+0.5)
    local s = math.floor(frac.z+0.5)

    local q_diff = math.abs(q - frac.x)
    local r_diff = math.abs(r - frac.y)
    local s_diff = math.abs(s - frac.z)

    if q_diff > r_diff and q_diff > s_diff then
        q = -r-s
    elseif r_diff > s_diff then
        r = -q-s
    else
        s = -q-r
    end

    return vmath.vector3(q,r,s)
end

--screen to hex and back
local function matrix_multiply(vec3,matrix)
    return vmath.vector3(vec3.x * matrix[1] + vec3.y * matrix[2], vec3.x * matrix[3] + vec3.y * matrix[4])
end

function M.hex_to_pixel(hex,size,offset)
    offset = offset or vmath.vector3()

    hex = M.cube_to_axial(hex)
    --local vector = vmath.vector3(hex.x * ORIENTATION.f0, hex.y * ORIENTATION.f1, hex.x * ORIENTATION.f2 + hex.y * ORIENTATION.f3)
    local vector = matrix_multiply(hex, {ORIENTATION.f0,ORIENTATION.f1,ORIENTATION.f2,ORIENTATION.f3})

    vector = vector + offset

    return vector*size
end

function M.pixel_to_hex(pixel, size, offset) --offset is the center, in pixels. Theoretically, it would be the position of the collection
    offset = offset or vmath.vector3()

    pixel = pixel - offset

    pixel.x = pixel.x / size.x
    pixel.y = pixel.y / size.y

    --local vector = vmath.vector3(pixel.x * ORIENTATION.b0, pixel.y * ORIENTATION.b1, pixel.x * ORIENTATION.b2 + pixel.y * ORIENTATION.b3)
    local vector = matrix_multiply(pixel, {ORIENTATION.b0,ORIENTATION.b1,ORIENTATION.b2,ORIENTATION.b3})

    local cube_vector = M.axial_to_cube(vector)

    M.cube_round(cube_vector)
end


return M