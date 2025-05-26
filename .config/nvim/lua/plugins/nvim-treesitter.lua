return {
  "nvim-treesitter/nvim-treesitter-context",
  -- enabled = false,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    max_lines = 3,
    multiline_threshold = 1,
  },
  keys = {
    {
      "<leader>cx",
      function()
        require("treesitter-context").toggle()
      end,
      desc = "Toggle Treesitter Context",
    },
    {
      "<leader>lc",
      function()
        -- Jump to previous change when in diffview.
        vim.schedule(function()
          require("treesitter-context").go_to_context()
        end)
        return "<Ignore>"
      end,
      desc = "Jump to upper context",
      expr = true,
    },
  },
}
