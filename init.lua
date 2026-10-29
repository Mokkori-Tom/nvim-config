vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local o = vim.opt
o.number = true
o.relativenumber = true
o.cursorline = true
o.helplang = "ja"
o.clipboard = "unnamedplus"
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.smartindent = true
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

local map = vim.keymap.set
map("i", "jk", "<Esc>")
map("n", "<Esc><Esc>", "<Cmd>nohlsearch<CR>", { silent = true })
map("n", "<leader>cf", function() vim.fn.setreg("+", vim.fn.expand("%")) end, { desc = "相対パスをコピー" })
map("n", "<leader>cF", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, { desc = "フルパスをコピー" })

-- 外で書き換えられたファイルを読み直す
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "WinEnter" }, { command = "checktime" })

require("config.lazy")

-- 端末の背景をそのまま見せる
for _, g in ipairs({ "Normal", "NormalNC", "NonText" }) do
  vim.api.nvim_set_hl(0, g, { bg = "none", ctermbg = "none" })
end
