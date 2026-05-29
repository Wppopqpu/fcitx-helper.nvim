local M = {}
local state = require("fcitx-helper.state")
---@type fcitx-helper.Opt
local config = require("fcitx-helper.config")

M.augroup = vim.api.nvim_create_augroup("fcitx-helper", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*",
	group = M.augroup,
	callback = function (ev)
		local mode = vim.fn.mode():sub(1, 1)
		if mode == "n" then
			if config.inactivate_in_normal then
				state.apply_state("inactive")
			end
			return
		end
		if vim.tbl_contains({ "i", "c", "t" }, mode) then
			state.apply_current_state()
			return
		end
	end,
})

return M
