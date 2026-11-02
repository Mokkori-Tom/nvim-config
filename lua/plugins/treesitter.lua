-- 構文解析。main ブランチ版はパーサー導入とハイライト開始を自分で書く（要 tree-sitter CLI）
local langs = {
  "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
  "javascript", "typescript", "python", "go", "ruby", "embedded_template",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- CLI が無ければパーサーは入れない（入らずにエラーが出続けるだけなので）。
      -- nvim 同梱の lua / vim / vimdoc / query / markdown / c のハイライトはそのまま効く
      if vim.fn.executable("tree-sitter") == 1 then
        require("nvim-treesitter").install(langs)
      end
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  { "RRethy/nvim-treesitter-endwise", event = "InsertEnter" }, -- Ruby/Lua の end を補う
  { "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} }, -- HTML タグを閉じる
}
