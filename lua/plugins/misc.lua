return {
  -- 日本語ヘルプ。lazy の :helptags が同梱の doc/tags-ja を書き換えて更新できなくなるので元に戻す
  {
    "vim-jp/vimdoc-ja",
    build = function(plugin)
      vim.fn.system({ "git", "-C", plugin.dir, "checkout", "--", "doc/tags-ja" })
    end,
  },
  { "tpope/vim-rails", ft = { "ruby", "eruby" } },

  -- カーソル下の URL などをブラウザで開く
  {
    "chrishrb/gx.nvim",
    cmd = "Browse",
    keys = { { "gx", "<Cmd>Browse<CR>", mode = { "n", "x" } } },
    init = function() vim.g.netrw_nogx = 1 end,
    opts = {},
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
    ft = "markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
  },
}
