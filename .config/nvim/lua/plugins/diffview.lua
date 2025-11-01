return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "lewis6991/gitsigns.nvim",
  },
  cmd = {
    "DiffviewClose",
    "DiffviewFileHistory",
    "DiffviewFocusFiles",
    "DiffviewLog",
    "DiffviewOpen",
    "DiffviewRefresh",
    "DiffviewToggleFiles",
  },
  keys = {
    -- Repo history
    { "<leader>hh", "<cmd>DiffviewFileHistory<cr>",                    desc = "Repo history" },

    -- File history (current file, with --follow)
    { "<leader>hf", "<cmd>DiffviewFileHistory --follow %<cr>",         desc = "File history" },

    -- Visual selection history
    { "<leader>hl", "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", mode = "v",                  desc = "Range history" },

    -- Line history (current line)
    { "<leader>hl", "<Cmd>.DiffviewFileHistory --follow<CR>",          desc = "Line history" },

    -- Diff working dir vs HEAD
    { "<leader>hd", "<cmd>DiffviewOpen<cr>",                           desc = "Repo diff (vs HEAD)" },

    -- Diff against local main/master
    {
      "<leader>hm",
      function()
        local branch = vim.fn.systemlist("git rev-parse --verify main 2>/dev/null")[1] and "main" or "master"
        vim.cmd("DiffviewOpen " .. branch)
      end,
      desc = "Diff against local main/master",
    },

    -- Diff against remote main/master
    {
      "<leader>hM",
      function()
        local branch = vim.fn.systemlist("git rev-parse --verify main 2>/dev/null")[1] and "main" or "master"
        vim.cmd("DiffviewOpen HEAD..origin/" .. branch)
      end,
      desc = "Diff against origin/main or origin/master",
    },
  },
  opts = {
    keymaps = {
      -- Close with 'q' in all panels
      view = { ["q"] = function() vim.cmd("tabclose") end },
      file_panel = { ["q"] = function() vim.cmd("tabclose") end },
      file_history_panel = { ["q"] = function() vim.cmd("tabclose") end },
    },
  },
}
