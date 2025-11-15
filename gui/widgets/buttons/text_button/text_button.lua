---This is a template for a TextButtonSelect Druid widget.
---Instantiate this template with `druid.new_widget(widget_module, [template_id], [nodes])`.
---Read more about Druid Widgets here: ...
---
--local druid = require("druid.druid")
local panthera = require("panthera.panthera")
local animation = require("gui.widgets.buttons.text_button.text_button_panthera")

---@class widget.text_button: druid.widget
local M = {}

function M:init()
	-- Now we have next functions to use here:
	-- self:get_node([node_id]) -- Get node inside widget by id
	-- self.druid to access Druid Instance API, like:
	-- self.druid:new_button([node_id], [callback])
	-- self.druid:new_text([node_id], [text])
	-- And all functions from component.lua file
	self.hover = self.druid:new_hover("root", self.on_hover, self.on_hover_mouse)
	self.button = self.druid:new_button("root", self.on_button)
	self.button:set_animations_disabled()
	self.animation = panthera.create_gui(animation,self:get_template())
	self.selected = false

	

	---will investigate with the radio buttons module 
	---May be useful
end

function M:on_hover(is_hover, hover_instance)
	
end

function M:on_hover_mouse(is_hover, hover_instance)
	if (self.selected) then return end
	
	if (is_hover) then
		panthera.play(self.animation, "on_hover")
	else
		panthera.play(self.animation, "off_hover")
	end
end

function M:on_button()
	if (not self.selected) then
		panthera.play(self.animation, "on_select")
		self.selected = true
	end
end

function M:unselect()
	panthera.play(self.animation, "off_select")
end


return M
