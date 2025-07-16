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
        base00 = "#1a1f2b", -- Dark Navy
        base01 = "#232834", -- Charcoal
        base02 = "#2e3440", -- Slate Gray
        base03 = "#4b5568", -- Steel Blue Gray
        base04 = "#7a889a", -- Cool Gray
        base05 = "#c2c6d8", -- Light Lavender Gray
        base06 = "#d6d9e5", -- Pale Silver
        base07 = "#eff1f5", -- Almost White

        base08 = "#D87C7C", -- Soft Red
        base09 = "#deb974", -- Golden Sand
        base0A = "#e4d67c", -- Muted Yellow
        base0B = "#88d1a2", -- Mint Green
        base0C = "#96d5e5", -- Sky Blue
        base0D = "#7ba7df", -- Cornflower Blue
        base0E = "#c19cd2", -- Lavender Purple
        base0F = "#b47777", -- Dusty Rose
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
