vim.pack.add({
  { src = "https://github.com/folke/which-key.nvim" },
})
local wk = require("which-key")

wk.setup({
  preset = "helix",
})

-- Register groups appear
wk.add({
  { "<leader>w", group = "+Window" },
  { "<leader>b", group = "+Buffer" },
  { "<leader>p", group = "+Plugin/Package" },
  { "<leader>t", group = "+Tab" },
  { "<leader>a", group = "+AutoSession" },
  { "<leader>c", group = "+Code/LSP" },
  { "<leader>f", group = "+Find/File" },
  { "<leader>s", group = "+Search/Grep" },
  { "<leader>g", group = "+Git" },
  { "<leader>o", group = "+Open/Command" },
  { "<leader>d", group = "+Diagnostics" },
})

local keymap = vim.keymap.set
local s = { silent = true }

keymap("n", "<space>", "<Nop>")

-- Clear search highlighting on Escape
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', { desc = 'Clear search highlighting' })
-- ── Plugin manager ───────────────────────────────────
keymap("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")
-- movement
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- --- save and quit
-- keymap("n", "<leader>w", "<cmd>w!<CR>", s)
-- keymap("n", "<leader>q", "<cmd>q<CR>", s)

-- tabs
keymap("n", "<leader>te", "<cmd>tabnew<CR>", s)

--- split windows
keymap("n", "<leader>_", "<cmd>vsplit<CR>", s)
keymap("n", "<leader>-", "<cmd>split<CR>", s)

-- copy and paste
keymap("v", "<leader>p", '"_dP')
keymap("x", "y", [["+y]], s)

-- terminal
keymap("t", "<esc>", "<C-\\><C-N>")

-- Oil: Toggle floating file manager
keymap("n", "<leader>e", function() require('oil').toggle_float() end, { desc = "File Manager", nowait = true })

-- Set keybinding for toggling mini.diff overlay
vim.keymap.set('n', '<leader>go', function()
  require("mini.diff").toggle_overlay(0)
end, { desc = "Toggle mini.diff overlay" })

-- Autosession
vim.keymap.set('n', '<leader>ar', "<Cmd>AutoSession search<CR>", { desc = 'Session search' })
vim.keymap.set('n', '<leader>as', "<Cmd>AutoSession save<CR>", { desc = 'Save session' })
vim.keymap.set('n', '<leader>aa', "<Cmd>AutoSession toggle<CR>", { desc = 'Toggle autosave' })

-- cd current dir
keymap("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- === WINDOW NAVIGATION (Ctrl + hjkl) ===
keymap("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move focus to the upper window" })

-- === <leader>w : Window Management ===
keymap("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>wc", "<C-w>c", { desc = "Close current window" })
keymap("n", "<leader>wo", "<C-w>o", { desc = "Close all other windows" })
keymap("n", "<leader>w=", "<C-w>=", { desc = "Equalize window sizes" })

-- Resize with arrows (hold Ctrl + Arrow)
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move windows (swap positions)
keymap("n", "<leader>wh", "<C-w>H", { desc = "Move window to far left" })
keymap("n", "<leader>wl", "<C-w>L", { desc = "Move window to far right" })
keymap("n", "<leader>wj", "<C-w>J", { desc = "Move window to bottom" })
keymap("n", "<leader>wk", "<C-w>K", { desc = "Move window to top" })

-- Rotate / exchange
keymap("n", "<leader>wr", "<C-w>r", { desc = "Rotate windows clockwise" })
keymap("n", "<leader>wR", "<C-w>R", { desc = "Rotate windows counter-clockwise" })
keymap("n", "<leader>wx", "<C-w>x", { desc = "Exchange with next window" })

-- === <leader>b : Buffer Management ===
keymap("n", "<leader>bb", "<cmd>b#<CR>", { desc = "Switch to last buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete current buffer" })
keymap("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Force delete buffer" })
keymap("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>bl", "<cmd>ls<CR>", { desc = "List buffers" })
keymap("n", "<leader>bf", "<cmd>bfirst<CR>", { desc = "First buffer" })
keymap("n", "<leader>be", "<cmd>blast<CR>", { desc = "Last buffer" })

-- Close all but current buffer
keymap("n", "<leader>bo", function()
  vim.cmd("%bd|e#|bd#")
end, { desc = "Close all other buffers" })

-- Conform
vim.keymap.set("n", "<leader>cf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
  { desc = "[F]ormat buffer" })

-- buffers
vim.keymap.set("n", "<S-h>", "<Cmd>bprevious<CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<Cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<Cmd>bprevious<CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<Cmd>bnext<CR>", { desc = "Next Buffer" })

vim.keymap.set("n", "<leader>q", function()
  vim.diagnostic.setloclist()
end, { desc = "Open diagnostic [Q]uickfix list" })

-- misc
vim.keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Code Actions" })

vim.keymap.set("n", "<leader>cr", function()
  vim.lsp.buf.rename()
end, { desc = "Rename" })

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show diagnostics (float)" })

local fzf = require('fzf-lua')
-- ── File / Project ─────────────────────────────────────
keymap('n', '<C-p>', function() fzf.files({ previewer = false }) end,
  { desc = '[F]ind Files (no preview)' })

keymap('n', '<leader><leader>', function() fzf.files() end,
  { desc = '[F]ind [F]iles' })

keymap('n', '<leader>fg', fzf.grep_project,
  { desc = '[F]ind [G]rep (project)' })

keymap('n', '<leader>fl', fzf.grep_last,
  { desc = '[F]ind [L]ast grep' })

keymap('n', '<leader>fr', fzf.resume,
  { desc = '[F]ind [R]esume last picker' })

keymap('n', '<leader>fb', function() fzf.buffers() end,
  { desc = '[F]ind [B]uffers' })

keymap('n', '<leader>fh', fzf.helptags,
  { desc = '[F]ind [H]elp tags' })

keymap('n', '<leader>fk', fzf.keymaps,
  { desc = '[F]ind [K]eymaps' })

keymap('n', '<leader>of', function() fzf.oldfiles({ cwd_only = true }) end,
  { desc = '[O]ld [F]iles (recent)' })


-- ── Grep / Search ─────────────────────────────────────
keymap('n', '<leader>sg', fzf.live_grep,
  { desc = '[S]earch [G]rep (live)' })

keymap('n', '<leader>sw', fzf.grep_cword,
  { desc = '[S]earch [W]ord under cursor' })

keymap('n', '<leader>s/', fzf.grep_curbuf,
  { desc = '[S]earch [/] current buffer' })


-- ── LSP ───────────────────────────────────────────────
keymap('n', 'gd', fzf.lsp_definitions, { desc = '[G]oto [D]efinition' })
keymap('n', 'gr', fzf.lsp_references, { desc = '[G]oto [R]eferences' })
keymap('n', 'gI', fzf.lsp_implementations, { desc = '[G]oto [I]mplementation' })
keymap('n', 'gy', fzf.lsp_typedefs, { desc = '[G]oto T[y]pe definition' })

keymap('n', '<leader>ss', fzf.lsp_workspace_symbols,
  { desc = '[S]earch [S]ymbols (workspace)' })

keymap('n', '<leader>sd', fzf.diagnostics_workspace,
  { desc = '[S]earch [D]iagnostics' })

keymap('n', '<leader>ca', vim.lsp.buf.code_action,
  { desc = '[C]ode [A]ction' })


-- Custom symbol filters (class / func / var)
local function sym(filter, title)
  fzf.lsp_workspace_symbols({ symbols = filter, prompt = title })
end

keymap('n', '<leader>sc', function() sym({ 'Class', 'Struct', 'Interface' }, 'Classes> ') end,
  { desc = '[S]earch [C]lasses' })

keymap('n', '<leader>sf', function() sym({ 'Function', 'Method' }, 'Functions> ') end,
  { desc = '[S]earch [F]unctions' })

keymap('n', '<leader>sv', function() sym({ 'Variable', 'Constant', 'Field', 'Property' }, 'Vars> ') end,
  { desc = '[S]earch [V]ariables' })


-- ── Diagnostics navigation ─────────────────────────────
keymap('n', '<leader>dn', function() vim.diagnostic.jump({ count = 1 }) end,
  { desc = '[D]iagnostic [N]ext' })

keymap('n', '<leader>dp', function() vim.diagnostic.jump({ count = -1 }) end,
  { desc = '[D]iagnostic [P]revious' })

-- ── Git ───────────────────────────────────────────────
keymap('n', '<leader>gs', '<cmd>Git<CR>', { desc = '[G]it [S]tatus' })
keymap('n', '<leader>gp', '<cmd>Git push<CR>', { desc = '[G]it [P]ush' })
keymap('n', '<leader>gl', fzf.git_commits, { desc = '[G]it [L]og (commits)' })
keymap('n', '<leader>gb', fzf.git_branches, { desc = '[G]it [B]ranches' })
keymap('n', '<leader>gf', fzf.git_files, { desc = '[G]it [F]iles' })

-- ── Command palette ───────────────────────────────────
keymap('n', '<leader>oco', fzf.commands, { desc = '[C]ommand [O]pen' })
keymap('n', '<leader>ocr', fzf.command_history, { desc = '[C]ommand [R]ecent' })

-- ── Quickfix / Location list ─────────────────────────
keymap('n', '<leader>fq', fzf.quickfix, { desc = '[F]ind [Q]uickfix' })
keymap('n', '<leader>fl', fzf.loclist, { desc = '[F]ind [L]ocation list' })

-- ── GitHub permalink yank ─────────────────────────────
keymap({ 'n', 'x' }, '<leader>gy', function() require('gh-permalink').yank() end,
  { desc = '[G]itHub [Y]ank permalink' })


-- ── Insert relative path (smart `so`) ─────────────────
keymap('n', '<leader>so', function()
  fzf.files({
    prompt = 'Path> ',
    previewer = false,
    actions = {
      ['default'] = function(sel)
        local file = sel[1]
        local rel = vim.fn.fnamemodify(file, ':.')
        rel = rel:gsub(' ', '\\ ')
        if not rel:match('^%.?/') then rel = './' .. rel end
        vim.api.nvim_put({ rel }, 'l', true, false)
      end,
    },
  })
end, { desc = '[S]earch & insert [O]bject (relative path)' })
