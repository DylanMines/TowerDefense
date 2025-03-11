local M = {}
M.scale = vmath.vector3()
M.pos = vmath.vector3()
function M.from_world(val) --World->tilemap
	val = vmath.vector3(val.x-M.pos.x,val.y-M.pos.y,0)
	return (val+vmath.vector3(8*M.scale.x,8*M.scale.x,0))/(16*M.scale.x)
end

function M.to_world(val) --Tilemap->world
	local world_transform = val*(16*M.scale.x)-vmath.vector3(8*M.scale.x,8*M.scale.x,0)
	return vmath.vector3(world_transform.x+M.pos.x,world_transform.y+M.pos.y,0)
end
M.start = nil
M.path = {} --{vector3,tile,layer}

return M