return {
  "nvim-treesitter/nvim-treesitter-context",
  enabled = true,
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
        vim.schedule(function()
          require("treesitter-context").go_to_context()
        end)
        return "<Ignore>"
      end,
      desc = "Jump to upper context",
      expr = true,
    },
  },
  opts = {
    max_lines = 3,
    multiline_threshold = 1,
  },
}
