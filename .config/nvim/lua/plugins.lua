vim.g.mapleader = " "

vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/vieitesss/gh-permalink.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/saghen/blink.cmp",           version = vim.version.range("^1") },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/chentoast/marks.nvim" },
})

require('mini.ai').setup({ n_lines = 500 })
require('mini.hipatterns').setup({
  highlighters = {
    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
  },
})
require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.tabline').setup()

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

require('mason').setup({})
require('mini.tabline').setup()
require('gitsigns').setup({ signcolumn = false })
require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    natural_order = true,
    is_always_hidden = function(name, _)
      return name == ".." or name == ".git"
    end,
  },
  float = {
    preview_split = "right",
    padding = 2,
    max_width = 160,
    max_height = 40,
    win_options = {
      number = true,
      relativenumber = true,
      signcolumn = "no",
      cursorline = true,
    }
  },
  win_options = {
    wrap = true,
    winblend = 0,
  },
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = false,
    ["q"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["<BS>"] = { "actions.parent", mode = "n" },
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
  },
})
vim.api.nvim_create_autocmd("User", {
  pattern = "OilEnter",
  callback = vim.schedule_wrap(function(args)
    local oil = require("oil")
    if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
      oil.open_preview()
    end
  end),
})

local actions = require('fzf-lua.actions')
require('fzf-lua').setup({
  winopts = {
    height = 1,
    width = 1,
    backdrop = 85,
    preview = {
      horizontal = "right:70%",
    }
  },
  keymap = {
    builtin = {
      ["<C-f>"] = "preview-page-down",
      ["<C-b>"] = "preview-page-up",
      ["<C-p>"] = "toggle-preview",
    },
    fzf = {
      ["ctrl-a"] = "toggle-all",
      ["ctrl-t"] = "first",
      ["ctrl-g"] = "last",
      ["ctrl-d"] = "half-page-down",
      ["ctrl-u"] = "half-page-up",
    }
  },
  actions = {
    files = {
      ["ctrl-q"] = actions.file_sel_to_qf,
      ["ctrl-n"] = actions.toggle_ignore,
      ["ctrl-h"] = actions.toggle_hidden,
      ["enter"]  = actions.file_edit_or_qf,
    }
  }
})


require("lualine").setup({
  options = {
    theme = "auto",
    icons_enabled = true,
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {},
    lualine_c = {
      {
        "filetype",
        icon_only = true,
        separator = "",
        padding = {
          left = 1,
          right = 0,
        },
      },
      {
        "filename",
        path = 1,
        symbols = {
          modified = "  ",
          readonly = "",
          unnamed = "",
        },
      },
      { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
      { "diff" },
      { "searchcount" },
    },
    lualine_x = {
      "encoding",
      "branch",
    },
    lualine_y = { "progress" },
    lualine_z = {
      -- function()
      --   return " " .. os.date("%R")
      -- end,
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "neo-tree", "lazy" },
})


require("vague").setup({
  transparent = false,
  italic = false
})

require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align',
    delay = 1000,
    ignore_whitespace = false,
  },
})

require("marks").setup({})
