local M = {}
local state = require("fcitx-helper.state")
local autocmd = require("fcitx-helper.autocmd")

--- generate a lualine widget
---@param text table<fcitx-helper.State, string> The text to show
---@return table
function M.make_widget(text)
	return {
		function ()
			return text[state.get_current_state()]
		end,
	}
end

vim.api.nvim_create_autocmd("User", {
	pattern = "FcitxStateChanged",
	group = autocmd.augroup,
	callback = function ()
		require("lualine").refresh()
	end,
})

return M
