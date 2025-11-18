local text_button = require("gui.widgets.buttons.text_button.text_button")
local event = require("event.event")
local radio = require("gui.widgets.radio.radio")

---@class widget.standard_window: druid.widget
local M = {}


function M:init()
	self.root = self:get_node("root")
	self.close = self.druid:new_button("close/image", self.on_close_pressed, self)
    self.title = self.druid:new_text("title", "window title")

	---@type widget.text_button[]
	self.screen_selections = {}
	for i = 1, 3 do
		table.insert(self.screen_selections, self.druid:new_widget(text_button, "screen"..i))
		gui.set_enabled(self.screen_selections[i]:get_node("root"), false)
	end
	self.tab_group = radio.new(self.screen_selections, 1)
	---@type userdata[]
	self.tabs = {}
	self.tab_group.on_state_changed:subscribe(self.tab_changed, self)

	self.numer_of_tabs = 0

	self.on_close = event.create()
end

---@return nil
function M:on_close_pressed()
	self.on_close:trigger()
end

---@return nil
---@param title string
function M:set_title(title)
    self.title:set_text(title)
end

---@param title string Text to show on the tab button
---@param node string ID of the root node of the tab
---@param index? integer Which button the tab should show on. Listed as [3, 2, 1]
function M:add_tab(title, node, index)
	if self.numer_of_tabs >= 3 then
		error("Too many tabs added in standard_window")
	end
	self.numer_of_tabs = self.numer_of_tabs+1;
	index = index or self.numer_of_tabs
	local tab_button_widget = self.screen_selections[index]
	local root_node = tab_button_widget:get_node("root")
	tab_button_widget:set_text(title)
	gui.set_enabled(root_node, true)

	self.tabs[index] = gui.get_node(node)
end

---@param tab_index number Index of the button which should be enabled. Listed as [3, 2, 1]
function M:set_enabled_tab(tab_index)
	self.screen_selections[tab_index]:on_button()
end

---@private
function M:tab_changed(tab_index)
	for i = 1, self.numer_of_tabs do
        gui.set_enabled(self.tabs[i], i == tab_index)
    end
end


return M
