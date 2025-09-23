return {
  -- Kanso.nvim configuration
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanso").setup({
        bold = true,
        italics = false,
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = {},
        typeStyle = {},
        transparent = true,
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
        transparent = false,
        italics = false,
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
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
      })
    end
  },

  {
    "vague2k/vague.nvim",
    config = function()
      require("vague").setup({
        transparent = false,
        italic = false
      })
    end
  },

}
