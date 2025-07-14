return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({ n_lines = 500 })

    require("mini.base16").setup({
      palette = {
        base00 = "#0E1116", -- Crust (Darkest background)
        base01 = "#131925", -- Mantle
        base02 = "#1C2533", -- Surface0
        base03 = "#2E3A49", -- Overlay0 (Comments)
        base04 = "#5B6675", -- Overlay2
        base05 = "#A8B0C0", -- Text (Primary foreground, softened)
        base06 = "#C9D1DA", -- Lighter foreground
        base07 = "#E5E9F0", -- Purest white, toned down

        base08 = "#D87C7C", -- Red (Desaturated rose)
        base09 = "#D29B6C", -- Peach (Dusty muted orange)
        base0A = "#E8C275", -- Yellow (Soft gold)
        base0B = "#6EC9B0", -- Green (Cool seafoam)
        base0C = "#75C6E0", -- Teal (Icy blue)
        base0D = "#5A99D6", -- Blue (Softened accent)
        base0E = "#9984D4", -- Mauve (Muted lilac)
        base0F = "#D48CAF", -- Maroon (Faded orchid)
      },
      use_cterm = true,
      plugins = { default = true }
    })

    local hipatterns = require('mini.hipatterns')
    require("mini.hipatterns").setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })

    -- In visual mode:
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    -- - saf - Surround around function
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()
    require("mini.diff").setup()  -- Git diff, colored line numbers
    require("mini.pairs").setup() -- Autopairs
  end,
}
