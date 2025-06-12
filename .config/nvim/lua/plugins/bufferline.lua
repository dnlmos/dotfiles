return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  config = function()
    require("bufferline").setup({
      options = {
        numbers = "none",
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
