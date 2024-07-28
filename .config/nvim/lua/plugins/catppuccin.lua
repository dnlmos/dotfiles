return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      local ucolors = require('catppuccin.utils.colors')
      local mocha = require('catppuccin.palettes').get_palette('mocha')
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        show_end_of_buffer = true,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = function(colors)
          return {
            -- Cmp Menu
            PmenuSel = { fg = colors.base, bg = colors.maroon, style = { 'bold' } },

            -- Telescope
            TelescopeBorder = { fg = colors.blue },
            TelescopeSelectionCaret = { fg = colors.flamingo },
            TelescopeSelection = { fg = colors.text, bg = colors.surface0, style = { 'bold' } },
            TelescopeMatching = { fg = colors.blue },
            TelescopePromptPrefix = { fg = colors.yellow, bg = colors.crust },
            TelescopePromptNormal = { bg = colors.crust },
            TelescopeResultsNormal = { bg = colors.mantle },
            TelescopePreviewNormal = { bg = colors.crust },
            TelescopePromptBorder = { bg = colors.crust, fg = colors.crust },
            TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
            TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
            TelescopePromptTitle = { fg = colors.crust, bg = colors.mauve },
            TelescopeResultsTitle = { fg = colors.crust, bg = colors.mauve },
            TelescopePreviewTitle = { fg = colors.crust, bg = colors.mauve },

            -- Bufferline
            BufferLineIndicatorSelected = { fg = colors.pink },
            BufferLineIndicator = { fg = colors.base },
            BufferLineModifiedSelected = { fg = colors.teal },
            TabLineSel = { bg = colors.pink },

            -- Cursorline & Linenumbers
            CursorLine = { bg = colors.mantle },
            CursorLineNr = { style = {'bold'}},

            -- Visual Mode
            Visual = { bg = ucolors.darken('#9745be', 0.25, mocha.mantle), style = { 'italic' } },
        }
    end,
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
      enabled = true,
            indentscope_color = "",
          },
          -- For more plugin integrations, check the documentation
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end
  },
}
