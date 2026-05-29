local M = {}
M.setup = require("fcitx-helper.config").setup
M.state = require("fcitx-helper.state")
M.autocmd = require("fcitx-helper.autocmd")

M.state.apply_state("inactive")
return M
