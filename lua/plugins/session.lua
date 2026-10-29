-- セッションの保存と復元
local function call(fn)
  return function() require("nvim-possession")[fn]() end
end

return {
  "gennaro-tedesco/nvim-possession",
  dependencies = { "ibhagwan/fzf-lua" },
  opts = {},
  keys = {
    { "<leader>sl", call("list"), desc = "セッション一覧" },
    { "<leader>sn", call("new"), desc = "セッションを作る" },
    { "<leader>su", call("update"), desc = "セッションを更新" },
    { "<leader>sd", call("delete"), desc = "セッションを消す" },
  },
}
