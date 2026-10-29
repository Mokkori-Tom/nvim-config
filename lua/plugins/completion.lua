return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },
  config = function()
    local cmp = require("cmp")

    -- 候補が出ていれば確定、markdown なら箇条書きを続ける、それ以外は普通の Enter
    local function enter(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      elseif vim.bo.filetype == "markdown" and vim.fn.exists(":AutolistNewBullet") == 2 then
        vim.api.nvim_feedkeys(vim.keycode("<CR><Cmd>AutolistNewBullet<CR>"), "n", false)
      else
        fallback()
      end
    end

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping(enter, { "i" }),
      }),
      sources = cmp.config.sources({ { name = "nvim_lsp" } }, { { name = "buffer" }, { name = "path" } }),
    })
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "cmdline" } },
    })
  end,
}
