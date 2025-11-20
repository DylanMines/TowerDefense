local M = {}

local state = {}

state.enabled = false

function M.set_enabled(enabled)
    state.enabled = enabled
end

function M.get_enabled()
    return state.enabled
end

return M