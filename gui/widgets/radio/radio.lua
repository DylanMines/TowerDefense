local event = require("event.event")

---@class radio_group
---@field state boolean[]
---@field objects widget.text_button[]
local M = {}

---@param objects widget.text_button[]
function M:new(objects, initial_enabled)
    initial_enabled = initial_enabled or 1
     o = {}
     setmetatable(o,{ __index = M })
     self.state = {}
     self.objects = objects

     for i = 1, #self.objects do
        self.objects[i].on_state_changed:subscribe(self.on_select, self)
        self.state[i] = false
     end

     self.objects[initial_enabled]:set_state(true)
     self.state[initial_enabled] = true

     self.on_state_changed = event.create()
     return o
end

function M:on_select()
    local new_clicked = nil
    for index = 1, #self.objects do
		if self.objects[index]:get_state() ~= self.state[index] then
			new_clicked = index
			break
		end
	end

    for index = 1, #self.state do
		self.objects[index]:set_state(index == new_clicked)
		self.state[index] = index == new_clicked
	end

    self.on_state_changed:trigger(new_clicked)
end
  

function M:get_objects()
    return self.objects
end

return M