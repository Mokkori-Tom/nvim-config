return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup()
      -- 入れたサーバーは自動で有効になる。Ruby を使うなら solargraph を足す
      require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "ts_ls", "gopls" } })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local function map(lhs, fn, desc)
            vim.keymap.set("n", lhs, fn, { buffer = ev.buf, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "定義へ")
          map("gD", vim.lsp.buf.declaration, "宣言へ")
          map("gi", vim.lsp.buf.implementation, "実装へ")
          map("gr", vim.lsp.buf.references, "参照一覧")
          map("K", vim.lsp.buf.hover, "説明を表示")
        end,
      })
    end,
  },

  -- Go のデバッグ（delve は mason が入れる）
  {
    "mfussenegger/nvim-dap",
    dependencies = { "leoluz/nvim-dap-go", "jay-babu/mason-nvim-dap.nvim" },
    ft = "go",
    config = function()
      require("mason-nvim-dap").setup({ ensure_installed = { "delve" } })
      require("dap-go").setup()
    end,
  },
}
