return {
  "folke/which-key.nvim",
    config = function()
      -- Setup which-key
      local wk = require("which-key")
      wk.setup {
        -- Your configuration options here
      }

    end
}
-- return {
--   "folke/which-key.nvim",
--   event = "VeryLazy",
--   opts = {
--     -- your configuration comes here
--     -- or leave it empty to use the default settings
--     -- refer to the configuration section below
--   },
--   keys = {
--     {
--       "<leader>?",
--       function()
--         require("which-key").show({ global = false })
--       end,
--       desc = "Buffer Local Keymaps (which-key)",
--     },
--   },
-- }
