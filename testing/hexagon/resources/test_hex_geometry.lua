require "deftest.deftest"
M = require "hexagon.resources.hex_geometry"

return function()
    describe("hex neighbors", function()
        test("test neighbor cell 0,0,0", function()
            assert_equal(M.cube_neighbor(vmath.vector3(0,0,0), M.DIRECTIONS.TOP_LEFT),vmath.vector3(-1,0,1))
            assert_equal(M.cube_neighbor(vmath.vector3(0,0,0), M.DIRECTIONS.BOTTOM) == vmath.vector3(0,1,-1))
        end)
        test("test neighbor cell 1,1,-2", function()
            assert_equal(M.cube_neighbor(vmath.vector3(1,1,-2), M.DIRECTIONS.TOP_RIGHT) == vmath.vector3(2,0,-2))
            assert_equal(M.cube_neighbor(vmath.vector3(1,1,-2), M.DIRECTIONS.TOP) == vmath.vector3(1,0,-1))
        end)
        test("test neighbor cell -1,0,1", function()
            assert_equal(M.cube_neighbor(vmath.vector3(-1,0,1), M.DIRECTIONS.BOTTOM_LEFT) == vmath.vector3(-2,1,-1))
            assert_equal(M.cube_neighbor(vmath.vector3(-1,0,1), M.DIRECTIONS.BOTTOM_RIGHT) == vmath.vector3(0,0,0))
        end)
    end)
    describe("hex conversions", function ()
        --cube to axial
        test("test cube to axial", function ()
            assert_equal(M.cube_to_axial(vmath.vector3(-4,1,3)),vmath.vector3(-4,1,0))
        end)

        test("test axial to cube", function ()
            assert_equal(M.axial_to_cube(vmath.vector3(-2,3,0)),vmath.vector3(-2,3,-1))
        end)

        --horizontal distance
        test("test horiontal distance medium", function ()
            assert_equal(M.get_horizontal_distance(120),180)
        end)

        test("test vertical distance", function ()
            assert_equal(math.floor(M.get_vertical_distance(178)+0.5),308)
        end)

        
    end)
    describe("hex transformations",function ()
        test("test rotate cube no center", function ()
            assert_equal(M.rotate_cube(vmath.vector3(0,-1,1)),vmath.vector3(1,-1,0))
        end)
        test("test rotate cube with center", function ()
            assert_equal(M.rotate_cube(vmath.vector3(0,-2,2),vmath.vector3(0,-1,1)),vmath.vector3(1,-2,1))
        end)

        test("cube_round",function ()
            assert_equal(M.cube_round(vmath.vector3(0.2,1.7,-1.6)),vmath.vector3(0,2,-2))
        end)
        test("cube_round with reset",function ()
            assert_equal(M.cube_round(vmath.vector3(1.5,-3.5,1.4)),vmath.vector3(2,-3,1))
        end)
    end)
end