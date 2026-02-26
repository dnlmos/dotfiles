-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.smartindent = true -- Enables smart indentation based on code context
vim.opt.autoindent = true -- Keep from first block (complements smartindent)

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.opt.numberwidth = 2

-- UI & Display
vim.opt.colorcolumn = "80" -- guideline for line length
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.termguicolors = true -- Enables true color support
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.scrolloff = 10 -- Minimal lines to keep above/below cursor
vim.o.wrap = false
vim.o.winborder = "rounded" -- Window border style

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true -- Case-insensitive unless \C or capital letters
vim.opt.incsearch = true -- Show matches as you type
vim.o.hlsearch = false -- Disable search highlight after search
vim.o.inccommand = "split" -- Preview substitutions live

-- Editing behavior
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.breakindent = true -- Enable break indent
vim.o.confirm = true -- Ask to save on quit if unsaved changes

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Whitespace visualization
-- vim.opt.list = true
-- vim.opt.listchars = { tab = ' ', multispace = '| ', eol = '󰌑' }  -- Keep custom icons from first block

-- Mouse & clipboard
vim.o.mouse = "a" -- Enable mouse mode
vim.schedule(function()
    vim.o.clipboard = "unnamedplus" -- Sync clipboard with OS
end)

-- -- Performance & timing
-- vim.o.updatetime = 250               -- Decrease update time
-- vim.o.timeoutlen = 500               -- Decrease mapped sequence wait time

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Miscellaneous
vim.cmd.filetype("plugin indent on")

-- Global variables
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "size"
