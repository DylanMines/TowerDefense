---This is a template for a TextButtonSelect Druid widget.
---Instantiate this template with `druid.new_widget(widget_module, [template_id], [nodes])`.
---Read more about Druid Widgets here: ...
---
--local druid = require("druid.druid")
local panthera = require("panthera.panthera")
local animation = require("gui.widgets.buttons.text_button.text_button_panthera")
local event = require("event.event")

---@class widget.text_button: druid.widget
---@field is_enabled boolean
local M = {}

function M:init()
	self.hover = self.druid:new_hover("root", self.on_hover, self.on_hover_mouse)
	self.button = self.druid:new_button("root", self.on_button)
	self.button:set_animations_disabled()
	self.animation = panthera.create_gui(animation,self:get_template())
	self:set_state(false)

	---will investigate with the radio buttons module 
	---May be useful
	self.on_state_changed = event.create()
end

function M:on_hover(is_hover, hover_instance)
	
end

function M:on_hover_mouse(is_hover, hover_instance)
	if (self.is_enabled) then return end
	if (is_hover) then
		panthera.play(self.animation, "on_hover")
	else
		panthera.play(self.animation, "off_hover")
	end
end

function M:on_button()
	if (self.is_enabled) then return end
	self:set_state(not self.is_enabled)
	self.on_state_changed:trigger(self.is_enabled)
end

function M:set_state(new_state)
	if (new_state == self.is_enabled) then return end

	self.is_enabled = new_state
	if (new_state) then
		panthera.play(self.animation, "on_select")
	else
		panthera.play(self.animation, "off_select")
	end
end

function M:get_state()
	return self.is_enabled
end

return M
