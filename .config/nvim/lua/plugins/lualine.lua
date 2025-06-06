return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    -- Override default settings
    opts.options = {
      component_separators = "",
      section_separators = "",
    }
  end,
}
