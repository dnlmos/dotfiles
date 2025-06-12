return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VeryLazy", -- Sets the loading event to 'VimEnter'
  opts = {
    preset = "helix",
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = "<Up> ",
        Down = "<Down> ",
        Left = "<Left> ",
        Right = "<Right> ",
        C = "<C-…> ",
        M = "<M-…> ",
        D = "<D-…> ",
        S = "<S-…> ",
        CR = "<CR> ",
        Esc = "<Esc> ",
        ScrollWheelDown = "<ScrollWheelDown> ",
        ScrollWheelUp = "<ScrollWheelUp> ",
        NL = "<NL> ",
        BS = "<BS> ",
        Space = "<Space> ",
        Tab = "<Tab> ",
        F1 = "<F1>",
        F2 = "<F2>",
        F3 = "<F3>",
        F4 = "<F4>",
        F5 = "<F5>",
        F6 = "<F6>",
        F7 = "<F7>",
        F8 = "<F8>",
        F9 = "<F9>",
        F10 = "<F10>",
        F11 = "<F11>",
        F12 = "<F12>",
      },
    },

    -- Define all your key chains and individual keymaps within the 'spec' table.
    -- This replaces the deprecated 'defaults' table.
    spec = {
      -- Top-level leader groups (these should display their 'group' name when <leader> is pressed)
      { "<leader><tab>", group = "Tabs" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "File/Find" },
      { "<leader>g", group = "Git" },
      { "<leader>Q", group = "Quit/Session" },
      { "<leader>s", group = "Search" },
      { "<leader>sR", group = "Search and Replace" },
      { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
      { "<leader>q", group = "quickfix" },

      {
        "<leader>q",
        function()
          vim.diagnostic.setloclist()
        end,
        desc = "Open diagnostic [Q]uickfix list",
      },
      -- Navigation and motion groups
      { "[", group = "Prev" },
      { "]", group = "Next" },
      { "g", group = "Goto" },
      { "z", group = "Fold" },
      { "gs", group = "Surround" },

      -- Sub-groups (these will appear when their parent group key is pressed)
      { "<leader>dp", group = "Profiler" }, -- Under <leader>d
      { "<leader>gh", group = "Hunks" }, -- Under <leader>g

      -- Mappings that expand dynamically using which-key.extras
      {
        "<leader>b",
        group = "Buffer",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      {
        "<leader>w",
        group = "Windows",
        proxy = "<c-w>", -- Tells which-key to show <c-w> options under <leader>w
        expand = function()
          return require("which-key.extras").expand.win()
        end,
      },

      -- Other specific keymaps, potentially mode-specific
      {
        mode = { "n", "v" }, -- Apply to Normal and Visual modes
        { "gx", desc = "Open with system app" }, -- Better description for 'gx'
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Keymaps (which-key)",
    },
    -- Keybinding to enter "Window Hydra Mode" via which-key popup
    {
      "<c-w><space>",
      function()
        require("which-key").show({ keys = "<c-w>", loop = true })
      end,
      desc = "Window Hydra Mode (which-key)",
    },
  },
  -- The configuration function where which-key is set up
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts) -- Pass the 'opts' table directly to setup
  end,
}
