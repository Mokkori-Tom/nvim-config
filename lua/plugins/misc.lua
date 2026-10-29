return {
  { "vim-jp/vimdoc-ja" }, -- 日本語ヘルプ
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
