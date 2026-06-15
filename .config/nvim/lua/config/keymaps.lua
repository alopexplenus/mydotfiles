-- Keymaps
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Write shortcut (mirrors .vimrc C-s)
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Disable accidental Ex mode
vim.keymap.set("n", "Q", "<nop>")
