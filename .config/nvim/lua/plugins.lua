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
  { src = "https://github.com/folke/persistence.nvim" },

  { src = "https://github.com/rcarriga/nvim-notify" },
}, { load = true })

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
require('mini.tabline').setup()
require('mini.indentscope').setup()

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

require('mason').setup()
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
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Helper: consistent keymap wrapper
    local function map(mode, lhs, rhs, desc, opts)
      opts = vim.tbl_extend('force', { buffer = bufnr, desc = 'GitSigns: ' .. desc }, opts or {})
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- === Navigation ===
    map('n', ']h', gs.next_hunk, 'Next Hunk', { expr = true })
    map('n', '[h', gs.prev_hunk, 'Prev Hunk', { expr = true })

    -- === Actions: Hunk ===
    map('n', '<leader>hs', gs.stage_hunk, 'Stage Hunk')
    map('n', '<leader>hr', gs.reset_hunk, 'Reset Hunk')
    map('v', '<leader>hs', function()
      gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Stage Selected Hunk')
    map('v', '<leader>hr', function()
      gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, 'Reset Selected Hunk')

    -- === Actions: Buffer ===
    map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
    map('n', '<leader>hR', gs.reset_buffer, 'Reset Buffer')
    map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo Stage Hunk')

    -- === Preview & Info ===
    map('n', '<leader>hp', gs.preview_hunk, 'Preview Hunk')
    map('n', '<leader>hb', function() gs.blame_line({ full = true }) end,
      'Blame Line (Full)')
    map('n', '<leader>hB', gs.toggle_current_line_blame, 'Toggle Line Blame')

    -- === Diff ===
    map('n', '<leader>hd', gs.diffthis, 'Diff This')
    map('n', '<leader>hD', function() gs.diffthis('~') end, 'Diff This ~')

    -- === Text Objects ===
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Select Hunk (ih)', { silent = true })

    -- === Optional: Quick jump with repeat ===
    vim.schedule(function()
      if vim.fn.maparg(']h', 'n') == '' then
        vim.keymap.set('n', ']h', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'GitSigns: Next Hunk or ]c' })
      end

      if vim.fn.maparg('[h', 'n') == '' then
        vim.keymap.set('n', '[h', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'GitSigns: Prev Hunk or [c' })
      end
    end)
  end,
})

require("marks").setup({})
require("persistence").setup({})
require("fzf-lua").setup({})
