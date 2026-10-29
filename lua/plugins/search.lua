-- プロジェクト全体の検索・置換（ripgrep）
local function open(prefills)
  return function() require("grug-far").open({ prefills = prefills and prefills() }) end
end

return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    { "<leader>rr", open(), desc = "検索・置換（全体）" },
    { "<leader>rw", open(function() return { search = vim.fn.expand("<cword>") } end), desc = "検索・置換（カーソル下の語）" },
    { "<leader>rf", open(function() return { paths = vim.fn.expand("%") } end), desc = "検索・置換（このファイル）" },
    {
      "<leader>rr",
      function() require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } }) end,
      mode = "x",
      desc = "検索・置換（選択した文字列）",
    },
  },
  opts = {
    keymaps = {
      replace = { n = "<leader>rp" },
      qflist = { n = "<leader>rq" },
      syncLocations = { n = "<leader>rs" },
      syncLine = { n = "<leader>rl" },
      close = { n = "<leader>rc" },
      historyOpen = { n = "<leader>rt" },
      historyAdd = { n = "<leader>ra" },
      refresh = { n = "<leader>rn" },
      openLocation = { n = "<leader>ro" },
      gotoLocation = { n = "<CR>" },
      pickHistoryEntry = { n = "<CR>" },
    },
  },
}
