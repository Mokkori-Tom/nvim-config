-- 画面まわり: ダッシュボード・通知・ピッカーなど（snacks）、キー案内（which-key）、端末（toggleterm）
local dashboard = {
  width = 40, -- スマホ幅（約46桁）でも中央に収まる
  sections = {
    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
    { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
    { section = "startup" },
  },
  preset = {
    keys = {
      { icon = "", key = "e", desc = "New file", action = ":enew" },
      { icon = "󰒲", key = "z", desc = "Lazy", action = ":Lazy" },
      { icon = "", key = ".", desc = "Oil", action = ":Oil" },
      { icon = "", key = "d", desc = "Dotfiles", action = ":Oil " .. vim.fn.stdpath("config") },
      { icon = "", key = "f", desc = "Files", action = ":Telescope find_files" },
      { icon = "", key = "s", desc = "Restore Session", section = "session" },
      { icon = "", key = "q", desc = "Quit", action = ":qa" },
    },
  },
}

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function()
      local opts = { dashboard = dashboard }
      for _, name in ipairs({
        "bigfile", "dashboard", "explorer", "image", "indent", "input", "notifier",
        "picker", "quickfile", "scope", "scroll", "statuscolumn", "words",
      }) do
        opts[name] = vim.tbl_extend("force", opts[name] or {}, { enabled = true })
      end
      return opts
    end,
    keys = {
      { "<leader>sf", function() Snacks.picker.files() end, desc = "ファイル検索" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "全文検索" },
      { "<leader>z", function() Snacks.zen.zoom() end, desc = "ズーム切替" },
      { "<leader>n", function() Snacks.notifier.show_history() end, desc = "通知の履歴" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "GitHub で開く（ブラウザ）" },
      { "]]", function() Snacks.words.jump(1) end, desc = "同じ語の次へ" },
      { "[[", function() Snacks.words.jump(-1) end, desc = "同じ語の前へ" },
    },
  },

  -- Space を押すと続きのキーを一覧表示
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<leader>c", group = "パスをコピー" },
        { "<leader>f", group = "検索（Telescope）" },
        { "<leader>g", group = "Git / GitHub" },
        { "<leader>o", group = "対のファイル" },
        { "<leader>r", group = "検索・置換" },
        { "<leader>s", group = "検索 / セッション" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "このバッファのキー一覧" },
      { "<leader>K", function() require("which-key").show({ global = true }) end, desc = "全キー一覧" },
    },
  },

  -- Ctrl+\ で下に端末、Ctrl+g で lazygit を浮かせて開く
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = { [[<C-\>]], { "<C-g>", mode = { "n", "t" } } },
    config = function()
      require("toggleterm").setup({ size = 20, open_mapping = [[<C-\>]], direction = "horizontal" })
      local lazygit = require("toggleterm.terminal").Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
      vim.keymap.set({ "n", "t" }, "<C-g>", function() lazygit:toggle() end, { desc = "lazygit（浮き窓）" })
    end,
  },
}
