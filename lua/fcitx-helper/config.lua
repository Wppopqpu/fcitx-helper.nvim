---@type fcitx-helper.Opt
local M = {
	backend = "fcitx5-remote",
	inactivate_in_normal = true,
	save_state_relative_to = "buffer",
}

--- setup config
---@param opt fcitx-helper.Opt
local function setup(opt)
	opt = opt or {}
	M = vim.tbl_deep_extend("force", M, opt)
end

return setmetatable({}, {
	__index = function (table, key)
		if "setup" == key then
			return setup
		end
		return M[key]
	end
})
