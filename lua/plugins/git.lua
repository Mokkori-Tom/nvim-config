return {
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>lg", "<Cmd>LazyGit<CR>", desc = "LazyGit" } },
  },
  -- GitHub で開く
  {
    "almo7aya/openingh.nvim",
    keys = {
      { "<leader>gr", "<Cmd>OpenInGHRepo<CR>", desc = "GitHub でリポジトリを開く" },
      { "<leader>gf", "<Cmd>OpenInGHFile<CR>", desc = "GitHub でファイルを開く" },
      { "<leader>gf", ":OpenInGHFileLines<CR>", mode = "x", desc = "GitHub で選択行を開く" },
    },
  },
}
