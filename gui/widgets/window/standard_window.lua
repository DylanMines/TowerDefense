local text_button = require("gui.widgets.buttons.text_button.text_button")
local radio = require("gui.widgets.radio.radio")

---@class widget.standard_window: druid.widget
local M = {}


function M:init()
	self.root = self:get_node("root")
	self.close = self.druid:new_button("close/image", self.on_button, self)
    self.title = self.druid:new_text("title", "window title")

	self.screen_selections = {}
	for i = 1, 3 do
		table.insert(self.screen_selections, self.druid:new_widget(text_button, "screen"..i))
	end
	self.screen_group = radio.new(self.screen_selections, 1)
end

function M:on_button()
	print("Root node", self.root)
end

function M:set_title(title)
    self.title:set_text(title)
end


return M
