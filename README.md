# fcitx-helper.nvim

让我们愉快地输入吧。

一个简单的neovim输入法解决方案。

## 功能

使用fcitx(5)-remote操纵输入法状态。在返回Normal状态时自动禁用输入法。
相对于缓冲区保存输入法状态，并在进入插入模式时自动恢复。提供一个lualine组件。

## 配置示例（lazy.nvim)


```lua
{
    "wppopqpu/fcitx-helper.nvim",
    config = function ()
        local helper = require("fcitx-helper")
        helper.setup({
            backend = "fcitx5-remote", -- or "fcitx-remote"
            save_state_relative_to = "buffer", -- or "global", "never"
            inactivate_in_normal = true,
        })

        require("which-key").add({
            { "<leader>\\", helper.state.toggle_current_state, desc = "toggle input method state" },
        })

        local text = {
            active = "中",
            inactive = "EN",
        }
        require("lualine").setup({
            sections = {
                lualine_y = { require("fcitx-helper.lualine_widget").make_widget(text), "location" },
            },
        })
    end,
    event = "VeryLazy",
},

```
