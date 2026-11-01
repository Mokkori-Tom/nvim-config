vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local o = vim.opt
o.number = true
o.relativenumber = true
o.cursorline = true
o.helplang = "ja"
o.clipboard = "unnamedplus"

-- Termux や SSH 先ではコピーを OSC 52 で端末のクリップボードへ送る（Termux:API 不要）。
-- 端末からの読み戻しは Termux が答えないので、貼り付けは最後にコピーした内容を返す。
local ssh_no_clip = vim.env.SSH_TTY and vim.fn["provider#clipboard#Executable"]() == ""
if vim.env.TERMUX_VERSION or ssh_no_clip then
  local osc52 = require("vim.ui.clipboard.osc52")
  local last = { {}, "v" }
  local function copy(reg)
    local send = osc52.copy(reg)
    return function(lines, regtype)
      last = { lines, regtype }
      send(lines, regtype)
    end
  end
  local function paste() return last end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = copy("+"), ["*"] = copy("*") },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end
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
