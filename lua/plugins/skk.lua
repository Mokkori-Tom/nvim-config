-- 日本語入力（SKK）。Lua だけで動き denops/Deno 不要
-- <C-j> でひらがな、l で半角英数、q でカタカナ
-- 辞書は install.sh が ~/.local/share/nvim/skk/SKK-JISYO.L に置く
return {
  "nabehan/skk.nvim",
  version = "*",
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    require("skk").setup({
      user_dictionary = vim.fn.stdpath("data") .. "/skk/SKK-JISYO.user",
    })

    local ESC = string.char(27)
    local pending_n -- Esc 直前に残っていた未確定の n を何に直すか

    -- Esc 1 回で確定して抜ける。既定では ▼ 中の Esc は確定だけで抜けず、
    -- 末尾の n は「ん」にならない。普通の Esc はそのまま通す
    vim.on_key(function(key)
      if key ~= ESC or vim.fn.mode() ~= "i" or not require("skk").is_enabled() then
        return
      end
      if require("skk.henkan.state").is_active() then
        -- skk が Esc を確定に使う（遅延挿入）ので、その後で抜ける
        vim.schedule(function() vim.schedule(vim.cmd.stopinsert) end)
        return
      end
      local mode = require("skk.capture").get_mode()
      local col = vim.fn.col(".")
      if (mode == "hira" or mode == "kata") and col > 1 and vim.fn.getline("."):sub(col - 1, col - 1) == "n" then
        pending_n = mode == "kata" and "ン" or "ん"
      end
    end, vim.api.nvim_create_namespace("skk_esc"))

    -- 挿入モードを抜けたら英数に戻す（既定ではひらがなのまま残る）
    vim.api.nvim_create_autocmd("InsertLeave", {
      callback = function()
        local skk = require("skk")
        if not skk.is_enabled() then
          return
        end
        skk.confirm_henkan()
        require("skk.capture").set_mode("ascii")
        if pending_n then
          local row, c = unpack(vim.api.nvim_win_get_cursor(0)) -- Esc 後は n の上
          vim.api.nvim_buf_set_text(0, row - 1, c, row - 1, c + 1, { pending_n })
          pending_n = nil
        end
      end,
    })

    local jisyo = vim.fn.stdpath("data") .. "/skk/SKK-JISYO.L"
    if vim.uv.fs_stat(jisyo) then
      require("skk.dict").load_dictionary_async(jisyo, "euc-jp")
    end
  end,
}
