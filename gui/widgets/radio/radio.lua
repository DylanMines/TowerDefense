local event = require("event.event")

---@class radio_group
---@field state boolean[] 
---@field objects widget.radio_widget[]
local M = {}

---@param objects widget.text_button[]
---@param initial_enabled? integer
function M.new(objects, initial_enabled)
     o = {}
     setmetatable(o,{ __index = M })
     o.state = {}
     o.objects = {}
     o:init(objects, initial_enabled)
     return o
end

function M:init(objects, initial_enabled)
    self.objects = objects
    initial_enabled = initial_enabled or 1
    for i = 1, #self.objects do
        self.objects[i].on_state_changed:subscribe(self.on_select, self)
        self.state[i] = false
     end

     self.objects[initial_enabled]:set_state(true)
     self.state[initial_enabled] = true

     self.on_state_changed = event.create()
end

---@return nil --void funciton
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
  
---@return widget.radio_widget[]
function M:get_objects()
    return self.objects
end

---@param object widget.radio_widget
---@return nil
function M:add_oject(object)
    table.insert(self.objects, object)
    object:set_state(false)
end

return M