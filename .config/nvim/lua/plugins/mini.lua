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

    -- require("mini.base16").setup({
    --   palette = {
    --     base00 = "#1a1f2b",
    --     base01 = "#232834",
    --     base02 = "#2e3440",
    --     base03 = "#4b5568",
    --     base04 = "#7a889a",
    --     base05 = "#c2c6d8",
    --     base06 = "#d6d9e5",
    --     base07 = "#eff1f5",
    --
    --     base08 = "#D87C7C",
    --     base09 = "#D29B6C",
    --     base0A = "#E8C275",
    --     base0B = "#6EC9B0",
    --     base0C = "#75C6E0",
    --     base0D = "#5A99D6",
    --     base0E = "#9984D4",
    --     base0F = "#D48CAF",
    --   },
    --   use_cterm = true,
    --   plugins = { default = true }
    -- })

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
