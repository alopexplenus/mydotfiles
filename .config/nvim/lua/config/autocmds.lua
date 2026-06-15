-- Autocmds
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Auto-leave insert mode after updatetime ms of inaction (mirrors .vimrc)
vim.api.nvim_create_autocmd("CursorHoldI", {
  pattern = "*",
  command = "stopinsert",
})
