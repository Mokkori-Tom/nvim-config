-- プラグイン管理（lazy.nvim）。無ければ取ってくる
local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(path) then
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", path })
  if vim.v.shell_error ~= 0 then
    error("lazy.nvim を取得できませんでした:\n" .. out)
  end
end
vim.opt.rtp:prepend(path)

require("lazy").setup("plugins", {
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
