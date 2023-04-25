-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Open help page to the right
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = augroup("help_vertical"),
  pattern = { "*/doc/*.txt" },
  callback = function()
    vim.cmd("wincmd L")
    vim.cmd("vert resize 100")
  end,
})
