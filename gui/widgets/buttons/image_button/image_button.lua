---This is a template for a ImageButtonOverlay Druid widget.
---Instantiate this template with `druid.new_widget(widget_module, [template_id], [nodes])`.

local druid = require("druid.druid")
local panthera = require("panthera.panthera")
local animation = require("gui.widgets.buttons.image_button.image_button_panthera")
local event = require("event.event")

---@class widget.image_button: druid.widget
local M = {}


function M:init()
	-- Now we have next functions to use here:
	-- self:get_node([node_id]) -- Get node inside widget by id
	-- self.druid to access Druid Instance API, like:
	-- self.druid:new_button([node_id], [callback])
	-- self.druid:new_text([node_id], [text])
	-- And all functions from component.lua file
	self.hover = self.druid:new_hover("root", self.on_hover, self.on_hover_mouse)
	self.animation = panthera.create_gui(animation,self:get_template())
end

function M:on_hover(is_hover, hover_instance)
	
end

function M:on_hover_mouse(is_hover, hover_instance)
	if (is_hover) then
		panthera.play(self.animation, "show",{speed = 2})
	else 
		panthera.play(self.animation, "hide",{speed = 2})
	end
end

function M:on_button()
end


return M
