return {
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  -- 箇条書きの続きを Enter で自動入力（Enter 自体は completion.lua で振り分け）
  {
    "gaoDean/autolist.nvim",
    ft = "markdown",
    config = function()
      require("autolist").setup()
      for _, k in ipairs({ "<Tab>", "<S-Tab>" }) do
        vim.keymap.set("i", k, k .. "<Cmd>AutolistRecalculate<CR>")
      end
    end,
  },

  -- カーソル下の単語に下線
  {
    "yamatsum/nvim-cursorline",
    opts = {
      cursorline = { enable = true, timeout = 1000 },
      cursorword = { enable = true, min_length = 3, hl = { underline = true } },
    },
  },
}
