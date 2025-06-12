-- -- Session manager
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    -- stylua: ignore
    keys = {
      { "<leader>Qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>QS", function() require("persistence").select() end, desc = "Select a session to load" },
      { "<leader>Ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>Qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
}
