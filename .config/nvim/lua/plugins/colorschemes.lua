return {
  -- Kanso.nvim configuration
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanso").setup({
        bold = true,
        italics = true,
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = {},
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
          palette = {},
          theme = { zen = {}, pearl = {}, ink = {}, all = {} },
        },
        overrides = function(colors)
          return {}
        end,
        theme = "zen", -- Load "zen" theme by default for kanso
        background = {
          dark = "zen",
          light = "pearl",
        },
      })
    end,
  },

  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "storm", -- Options: storm, night, moon, day
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    opts = {
      compile = false,  -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = { italic = true },
      transparent = true,    -- do not set background color
      dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {             -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = { ui = { bg_gutter = "none" } } },
      },
      overrides = function(colors) -- add/modify highlights
        local theme = colors.theme

        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          -- Telescope
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        }
      end,
      theme = "wave",  -- Load "wave" theme when 'background' option is not set
      background = {   -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    config = function()
      require("catppuccin").setup({
        flavour = "auto", -- latte, frappe, macchiato, mocha
        background = {    -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
        term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false,             -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15,           -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,             -- Force no italic
        no_bold = false,               -- Force no bold
        no_underline = false,          -- Force no underline
        styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" },     -- Change the style of comments
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
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })
    end
  },

  -- {
  --   "echasnovski/mini.base16",
  --   version = false,
  --   config = function()
  --     require("mini.base16").setup({
  --       palette = {
  --         base00 = "#112641",
  --         base01 = "#3a475e",
  --         base02 = "#606b81",
  --         base03 = "#8691a7",
  --         base04 = "#d5dc81",
  --         base05 = "#e2e98f",
  --         base06 = "#eff69c",
  --         base07 = "#fcffaa",
  --         base08 = "#ffcfa0",
  --         base09 = "#cc7e46",
  --         base0A = "#46a436",
  --         base0B = "#9ff895",
  --         base0C = "#ca6ecf",
  --         base0D = "#42f7ff",
  --         base0E = "#ffc4ff",
  --         base0F = "#00a5c5",
  --       },
  --       plugins = { default = true },
  --     })
  --   end,
  -- },
}
