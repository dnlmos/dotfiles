return { -- Collection of various small independent plugins/modules
  "nvim-mini/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    -- Examples:
    -- - va) - [V]isually select [A]round [)]paren
    -- - yinq - [Y]ank [I]nside [N]ext [Q]uote
    -- - ci' - [C]hange [I]nside [']quote
    require("mini.ai").setup({ n_lines = 500 })

    local hipatterns = require('mini.hipatterns')
    require("mini.hipatterns").setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })

    -- In visual mode:
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    -- - saf - Surround around function
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd' - [S]urround [D]elete [']quotes
    -- - sr)' - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()

    -- -- Configure mini.diff
    -- require("mini.diff").setup({
    --   view = {
    --     style = "sign",
    --     signs = {
    --       add = "▎",
    --       change = "▎",
    --       delete = "",
    --     },
    --   },
    -- })
    --
    -- -- Set keybinding for toggling mini.diff overlay
    -- vim.keymap.set('n', '<leader>go', function()
    --   require("mini.diff").toggle_overlay(0)
    -- end, { desc = "Toggle mini.diff overlay" })

    require("mini.pairs").setup() -- Autopairs
  end,
}
