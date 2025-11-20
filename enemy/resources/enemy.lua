--Libraries
local camera = require("orthographic.camera")

local pData = require("Path.path_data")
local Enemy = {}
local currentz = 0.24 --variable used to make sure enemies dont clip
local types = {}; --subtypes
Enemy.enemies = {}
function Enemy:new(o,type) --Constructor
	o = o or {health = 1, damage = 1, zpos = 0, speed = 1,last = vmath.vector3(),layer = 1,visible = true, tint = vmath.vector4(),pathNum = 2}   -- create object
	setmetatable(o, self)
	self.__index = self

	if currentz <= 0 then currentz = 0.24 end 
	currentz = currentz-0.01

	--class is ready
	o.go = factory.create("#factory")
	--print(self.go)
	local current_type = types[type]
	o.name = current_type.name
	local sprite_url = msg.url("main",o.go,"sprite")
	go.set(sprite_url, "playback_rate", current_type.speed)
	msg.post(sprite_url, "play_animation",{id = hash(o.name.."_Enemy")})

	o.zpos = currentz
	o.last = vmath.vector3()
	o.damage = current_type.damage
	o.health = current_type.health
	o.maxHealth = o.health
	o.speed = current_type.speed
	o.lastSpeed = o.speed
	o.layer = 1
	o.visible = true
	o:start(pData.start,pData.path[2][1]) --wrong probably
	return o
end

function Enemy:getEnemies()
    return Enemy.enemies
end

function Enemy:addType(value)
    table.insert(types, value)
end

function Enemy:get_rotation(pos) --accessor function to get rotation
	return math.deg(math.atan2(pos.y - go.get_position(self.go).y, pos.x - go.get_position(self.go).x)-math.pi/2)
end

function Enemy:get_position() -- accessor function to get position
	return go.get_position(self.go)
end

function Enemy:move(pos,tile) --Move the enemy from current position to pos while doing the action of tile_source
--print(pos)
	pos = vmath.vector3(pos.x,pos.y,self.zpos+(0.5*(self.layer-1)))
	--print(tile)
	--print(self.lastSpeed)
	-- speed math
	self.last = go.get_position(self.go)
	local speed = self.speed
	if tile == 7 then speed = speed * 3
	elseif tile == 8 then speed = speed * 0.125 end
	local sprite_url = msg.url("main",self.go,"sprite")
	go.set(sprite_url, "playback_rate", self.lastSpeed)
	--//--

	--invisible blocks
	
	if not self.visible then
		go.set(sprite_url,"tint.w",0) 
	else
		go.set(sprite_url,"tint.w",1) 
	end
	if tile == 4 then 
		self.visible = not self.visible
	end
	--//--
	-- angle math
	local char_angle = go.get(self.go,"euler.z")
	local angle = self:get_rotation(pos)
	if tile == 5 then go.set(self.go,"euler.z",angle)
	elseif angle ~= char_angle then
		if math.abs(angle-char_angle) == 270 then 
			go.set(self.go,"euler.z",char_angle+360)
		end
		go.animate(self.go, "euler.z", go.PLAYBACK_ONCE_FORWARD, angle, go.EASING_LINEAR, 1/self.lastSpeed)
	end
	--//--

	-- layer stuff
	if tile == 2 then
		self.layer = self.layer + 1
	elseif tile == 3 then
		self.layer = self.layer - 1
	end
	--print(self.layer)
	--//--

	-- animate!
	go.animate(self.go, "position", go.PLAYBACK_ONCE_FORWARD, pos, go.EASING_LINEAR, 1/self.lastSpeed, 0, function()
		if tile == 6 then self:final() return end
		self.lastSpeed = speed
		self.pathNum = self.pathNum +1
		local pos,tile = pData.path[self.pathNum][1],pData.path[self.pathNum][2]
		pos = pData.to_world(pos)
		self:move(pos, tile)
	end)
end

function Enemy:take_damage(dmg) --Take damage
	self.health = self.health - dmg
	self:health_changed()
end

function Enemy:health_changed() --Do the red flashing thingy (Not to be used outside of class but idk how to make private functions in lua)
	local red = vmath.vector4()
	local sprite_url = msg.url("main",self.go,"sprite")
	
	go.cancel_animations(sprite_url)
	go.set(sprite_url,"tint.x",1)
	go.set(sprite_url,"tint.z",0)
	go.set(sprite_url,"tint.y",0)
	if self.health <= 0 then
		self:final()
	else
		local easing = go.EASING_INOUTSINE
		local function animate_tint(x,y,z,time, pingpong ,callback)
			local playback = pingpong and go.PLAYBACK_LOOP_PINGPONG or go.PLAYBACK_ONCE_FORWARD
			go.animate(sprite_url, "tint.x", playback, x, easing, time)
			go.animate(sprite_url, "tint.z", playback, z, easing, time)
			if callback then 
				go.animate(sprite_url, "tint.y", playback, y, easing, time,0,callback)
			else 
				go.animate(sprite_url, "tint.y", playback, y, easing, time,0)
			end
		end
		animate_tint(self.tint.x, self.tint.y, self.tint.z, 0.3, false, function ()
			animate_tint(1, self.tint.y-0.5, self.tint.z-0.5, (self.health/self.maxHealth)*2, true)
		end)
	end
end

function Enemy:final() --Enemy died
	local particle_url = msg.url("main",self.go,"death")
	self.health = 0
	local size = 80
	local SM = size/5 --size multiplier
	camera.shake(nil,0.003)
	Enemy.enemies[self.go] = nil
		go.delete(self.go)
		particlefx.play(particle_url)
		particlefx.set_constant(particle_url, "emitter", "tint", vmath.vector4(1,1,1,1))
	for _,v in pairs(Enemy.enemies) do
		if v == nil then return end
		local position = v:get_position()
		local selfPos = self:get_position()
		local dist = vmath.length(vmath.vector3(selfPos.x,selfPos.y,0)-position)
		if dist < size then
			local dmg = math.abs((size+SM)/math.sqrt(dist+SM)-math.sqrt(size+SM))
			--print(dist,dmg*SM)
			v:take_damage(dmg*SM)
		end
	end
end

function Enemy:get_id() --Accessor function
	return self.go
end

function Enemy:start(pos,next) --Enemy just spawned
	go.set_position(pData.to_world(pos),self.go)
	self.last = pos
	self.lastSpeed = self.speed
	self:move(pData.to_world(next), 5)
	--msg.post("/map#path_manager", "get_next",{pos = go.get_position(self.go),last = pos,layer = self.layer,id = self.go})
end
return Enemy