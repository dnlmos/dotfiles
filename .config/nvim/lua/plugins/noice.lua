-- Floating windows, notify, cmd line, ...
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      hover = { enabled = false },
      signature = { enabled = false }
    },
    views = {
      mini = {
        win_options = {
          winblend = 0
        }
      },
    },
    cmdline = {
      view = "cmdline", -- disable floating cmdline
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
}
