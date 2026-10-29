return {
  -- ファイラ。一覧をバッファとして編集して :w で反映
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    opts = { view_options = { show_hidden = true } },
    keys = {
      { "-", "<Cmd>Oil<CR>", desc = "ファイラ（親ディレクトリ）" },
      { "<leader>e", "<Cmd>Oil<CR>", desc = "ファイラ" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "ファイル検索" },
      { "<leader>fb", "<Cmd>Telescope buffers<CR>", desc = "バッファ一覧" },
      { "<leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "ヘルプ検索" },
      { "<leader>gs", "<Cmd>Telescope git_files<CR>", desc = "Git 管理下のファイル検索" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          mappings = { i = { ["<C-j>"] = "move_selection_next", ["<C-k>"] = "move_selection_previous" } },
        },
      })
      telescope.load_extension("fzf")
    end,
  },

  -- 実装とテストなど、対になるファイルへ移る
  {
    "rgroli/other.nvim",
    main = "other-nvim",
    keys = {
      { "<leader>oo", "<Cmd>Other<CR>", desc = "対のファイルへ" },
      { "<leader>ot", "<Cmd>OtherTab<CR>", desc = "対のファイルを新しいタブで" },
    },
    opts = { mappings = { "rails", "golang", "python", "react", "rust", "angular", "laravel" } },
  },
}
