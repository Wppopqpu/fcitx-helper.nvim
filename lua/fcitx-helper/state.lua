local M = {}
---@type fcitx-helper.Opt
local config = require("fcitx-helper.config")


---@type fcitx-helper.State
local global_state = "inactive"

---@type table<integer, fcitx-helper.State>
local buffer_states = {}

--- get saved state for a buffer
---@param bufnr integer
---@return fcitx-helper.State
local function get_buffer_state(bufnr)
	return buffer_states[bufnr] or "inactive"
end

--- set state for a buffer
---@param bufnr integer
---@param state fcitx-helper.State
local function set_buffer_state(bufnr, state)
	buffer_states[bufnr] = state
end

--- get current saved state
---@return fcitx-helper.State
function M.get_current_state()
	local opt = config.save_state_relative_to
	if opt == "never" then
		return "inactive"
	end
	if opt == "global" then
		return global_state
	end
	if opt == "buffer" then
		return get_buffer_state(vim.api.nvim_get_current_buf())
	end
	error("unreachable")
end

local function trigger_state_changed()
	local augroup = require("fcitx-helper.autocmd").augroup
	vim.api.nvim_exec_autocmds("User", { pattern = "FcitxStateChanged", group = augroup, data = { state = M.get_current_state() } })
end

--- set current saved state
---@param state fcitx-helper.State
function M.set_current_state(state)
	trigger_state_changed()
	local opt = config.save_state_relative_to
	if opt == "never" then
		return
	end
	if opt == "global" then
		global_state = state
		return
	end
	if opt == "buffer" then
		set_buffer_state(vim.api.nvim_get_current_buf(), state)
		return
	end
	error("unreachable")
end

--- toggle current saved state
function M.toggle_current_state()
	if M.get_current_state() == "inactive" then
		M.set_current_state("active")
		return
	end
	M.set_current_state("inactive")
end

---@type table<fcitx-helper.State, string>
local params_to_use = {
	["inactive"] = "-c",
	["active"] = "-o",
}

--- apply a given state
---@param state fcitx-helper.State
function M.apply_state(state)
	vim.system({ config.backend,  params_to_use[state] }, { detach = true })
end

--- apply current state
function M.apply_current_state()
	M.apply_state(M.get_current_state())
end

return M
