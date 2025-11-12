vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim" },
})

local wk = require("which-key")
wk.setup({ preset = "helix" })

-- Register groups
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
    { "<leader>h", group = "+Hunks" },
    { "[", group = "Prev" },
    { "]", group = "Next" },
    { "g", group = "Goto" },
    { "z", group = "Fold" },
    { "gs", group = "Surround" },
})

local opts = { silent = true }

-- General
vim.keymap.set("n", "<space>", "<Nop>")
vim.keymap.set(
    "n",
    "<Esc>",
    "<Cmd>nohlsearch<CR>",
    { desc = "Clear search highlighting" }
)

-- remap redo
vim.keymap.set("n", "U", "<C-r>")

-- save and quit current file
vim.keymap.set(
    "n",
    "<leader>ww",
    ":w<cr>",
    { silent = true, noremap = true, desc = "Write file" }
)
vim.keymap.set(
    { "n", "t" },
    "<leader>t",
    ":q<cr>",
    { silent = true, noremap = true, desc = "Quit" }
)

-- Plugin manager
vim.keymap.set("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>", opts)

-- Movement
vim.keymap.set(
    "n",
    "j",
    "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true }
)
vim.keymap.set(
    "n",
    "k",
    "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true }
)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Split windows
vim.keymap.set("n", "<leader>_", "<cmd>vsplit<CR>", opts)
vim.keymap.set("n", "<leader>-", "<cmd>split<CR>", opts)

-- Copy and paste
vim.keymap.set("v", "<leader>p", '"_dP', opts)
vim.keymap.set("x", "y", [["+y]], opts)

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", opts)
vim.keymap.set(
    "t",
    "<Esc><Esc>",
    "<C-\\><C-n>",
    { desc = "Exit terminal mode" }
)

-- File manager (Oil)
vim.keymap.set("n", "<leader>e", function()
    require("oil").toggle_float()
end, { desc = "File Manager", nowait = true })

-- mini.diff overlay
vim.keymap.set("n", "<leader>go", function()
    require("mini.diff").toggle_overlay(0)
end, { desc = "Toggle mini.diff overlay" })

-- AutoSession
vim.keymap.set(
    "n",
    "<leader>ar",
    "<Cmd>AutoSession search<CR>",
    { desc = "Session search" }
)
vim.keymap.set(
    "n",
    "<leader>as",
    "<Cmd>AutoSession save<CR>",
    { desc = "Save session" }
)
vim.keymap.set(
    "n",
    "<leader>aa",
    "<Cmd>AutoSession toggle<CR>",
    { desc = "Toggle autosave" }
)

-- Change directory to current file
vim.keymap.set(
    "n",
    "<leader>cd",
    '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>',
    opts
)

-- Window navigation (Ctrl + hjkl)
vim.keymap.set(
    "n",
    "<C-h>",
    "<C-w>h",
    { desc = "Move focus to the left window" }
)
vim.keymap.set(
    "n",
    "<C-l>",
    "<C-w>l",
    { desc = "Move focus to the right window" }
)
vim.keymap.set(
    "n",
    "<C-j>",
    "<C-w>j",
    { desc = "Move focus to the lower window" }
)
vim.keymap.set(
    "n",
    "<C-k>",
    "<C-w>k",
    { desc = "Move focus to the upper window" }
)

-- Window management
vim.keymap.set(
    "n",
    "<leader>ws",
    "<C-w>s",
    { desc = "Split window horizontally" }
)
vim.keymap.set(
    "n",
    "<leader>wv",
    "<C-w>v",
    { desc = "Split window vertically" }
)
vim.keymap.set("n", "<leader>wc", "<C-w>c", { desc = "Close current window" })
vim.keymap.set(
    "n",
    "<leader>wo",
    "<C-w>o",
    { desc = "Close all other windows" }
)
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize window sizes" })

-- Resize windows
vim.keymap.set(
    "n",
    "<C-Up>",
    ":resize +2<CR>",
    { desc = "Increase window height" }
)
vim.keymap.set(
    "n",
    "<C-Down>",
    ":resize -2<CR>",
    { desc = "Decrease window height" }
)
vim.keymap.set(
    "n",
    "<C-Left>",
    ":vertical resize -2<CR>",
    { desc = "Decrease window width" }
)
vim.keymap.set(
    "n",
    "<C-Right>",
    ":vertical resize +2<CR>",
    { desc = "Increase window width" }
)

-- Move windows
vim.keymap.set(
    "n",
    "<leader>wh",
    "<C-w>H",
    { desc = "Move window to far left" }
)
vim.keymap.set(
    "n",
    "<leader>wl",
    "<C-w>L",
    { desc = "Move window to far right" }
)
vim.keymap.set("n", "<leader>wj", "<C-w>J", { desc = "Move window to bottom" })
vim.keymap.set("n", "<leader>wk", "<C-w>K", { desc = "Move window to top" })

-- Rotate / exchange windows
vim.keymap.set(
    "n",
    "<leader>wr",
    "<C-w>r",
    { desc = "Rotate windows clockwise" }
)
vim.keymap.set(
    "n",
    "<leader>wR",
    "<C-w>R",
    { desc = "Rotate windows counter-clockwise" }
)
vim.keymap.set(
    "n",
    "<leader>wx",
    "<C-w>x",
    { desc = "Exchange with next window" }
)

-- Buffer management
vim.keymap.set(
    "n",
    "<leader>bb",
    "<cmd>b#<CR>",
    { desc = "Switch to last buffer" }
)
vim.keymap.set(
    "n",
    "<leader>bd",
    "<cmd>bdelete<CR>",
    { desc = "Delete current buffer" }
)
vim.keymap.set(
    "n",
    "<leader>bD",
    "<cmd>bdelete!<CR>",
    { desc = "Force delete buffer" }
)
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set(
    "n",
    "<leader>bp",
    "<cmd>bprevious<CR>",
    { desc = "Previous buffer" }
)
vim.keymap.set("n", "<leader>bl", "<cmd>ls<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>bf", "<cmd>bfirst<CR>", { desc = "First buffer" })
vim.keymap.set("n", "<leader>be", "<cmd>blast<CR>", { desc = "Last buffer" })
vim.keymap.set("n", "<leader>bo", function()
    vim.cmd("%bd|e#|bd#")
end, { desc = "Close all other buffers" })

-- Buffer navigation
vim.keymap.set("n", "<S-h>", "<Cmd>bprevious<CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<Cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<Cmd>bprevious<CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<Cmd>bnext<CR>", { desc = "Next Buffer" })

-- Formatting (Conform)
vim.keymap.set("n", "<leader>cf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

-- Quickfix
vim.keymap.set("n", "<leader>q", function()
    vim.diagnostic.setloclist()
end, { desc = "[Q]uickfix list" })

-- LSP / Code
vim.keymap.set(
    "n",
    "<leader>ca",
    vim.lsp.buf.code_action,
    { desc = "Code Actions" }
)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set(
    "n",
    "<leader>cd",
    vim.diagnostic.open_float,
    { desc = "Show diagnostics (float)" }
)

local fzf = require("fzf-lua")

-- File / Project
vim.keymap.set("n", "<C-p>", function()
    fzf.files({ previewer = false })
end, { desc = "[F]ind Files (no preview)" })
vim.keymap.set("n", "<leader><leader>", fzf.files, { desc = "[F]ind [F]iles" })
vim.keymap.set(
    "n",
    "<leader>fg",
    fzf.grep_project,
    { desc = "[F]ind [G]rep (project)" }
)
vim.keymap.set(
    "n",
    "<leader>fl",
    fzf.grep_last,
    { desc = "[F]ind [L]ast grep" }
)
vim.keymap.set(
    "n",
    "<leader>fr",
    fzf.resume,
    { desc = "[F]ind [R]esume last picker" }
)
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fh", fzf.helptags, { desc = "[F]ind [H]elp tags" })
vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>of", function()
    fzf.oldfiles({ cwd_only = true })
end, { desc = "[O]ld [F]iles (recent)" })

-- Search / Grep
vim.keymap.set(
    "n",
    "<leader>sg",
    fzf.live_grep,
    { desc = "[S]earch [G]rep (live)" }
)
vim.keymap.set(
    "n",
    "<leader>sw",
    fzf.grep_cword,
    { desc = "[S]earch [W]ord under cursor" }
)
vim.keymap.set(
    "n",
    "<leader>s/",
    fzf.grep_curbuf,
    { desc = "[S]earch [/] current buffer" }
)

-- LSP Navigation
vim.keymap.set("n", "gd", fzf.lsp_definitions, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gr", fzf.lsp_references, { desc = "[G]oto [R]eferences" })
vim.keymap.set(
    "n",
    "gI",
    fzf.lsp_implementations,
    { desc = "[G]oto [I]mplementation" }
)
vim.keymap.set(
    "n",
    "gy",
    fzf.lsp_typedefs,
    { desc = "[G]oto T[y]pe definition" }
)
vim.keymap.set(
    "n",
    "<leader>ss",
    fzf.lsp_workspace_symbols,
    { desc = "[S]earch [S]ymbols (workspace)" }
)
vim.keymap.set(
    "n",
    "<leader>sd",
    fzf.diagnostics_workspace,
    { desc = "[S]earch [D]iagnostics" }
)

-- Symbol search (filtered)
local function sym(filter, title)
    fzf.lsp_workspace_symbols({ symbols = filter, prompt = title })
end
vim.keymap.set("n", "<leader>sc", function()
    sym({ "Class", "Struct", "Interface" }, "Classes> ")
end, { desc = "[S]earch [C]lasses" })
vim.keymap.set("n", "<leader>sf", function()
    sym({ "Function", "Method" }, "Functions> ")
end, { desc = "[S]earch [F]unctions" })
vim.keymap.set("n", "<leader>sv", function()
    sym({ "Variable", "Constant", "Field", "Property" }, "Vars> ")
end, { desc = "[S]earch [V]ariables" })

-- Diagnostics navigation
vim.keymap.set("n", "<leader>dn", function()
    vim.diagnostic.jump({ count = 1 })
end, { desc = "[D]iagnostic [N]ext" })
vim.keymap.set("n", "<leader>dp", function()
    vim.diagnostic.jump({ count = -1 })
end, { desc = "[D]iagnostic [P]revious" })

-- Git
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "[G]it [S]tatus" })
vim.keymap.set(
    "n",
    "<leader>gp",
    "<cmd>Git push<CR>",
    { desc = "[G]it [P]ush" }
)
vim.keymap.set(
    "n",
    "<leader>gl",
    fzf.git_commits,
    { desc = "[G]it [L]og (commits)" }
)
vim.keymap.set(
    "n",
    "<leader>gb",
    fzf.git_branches,
    { desc = "[G]it [B]ranches" }
)
vim.keymap.set("n", "<leader>gf", fzf.git_files, { desc = "[G]it [F]iles" })

-- Command palette
vim.keymap.set("n", "<leader>oco", fzf.commands, { desc = "[C]ommand [O]pen" })
vim.keymap.set(
    "n",
    "<leader>ocr",
    fzf.command_history,
    { desc = "[C]ommand [R]ecent" }
)

-- Quickfix / Location list
vim.keymap.set("n", "<leader>fq", fzf.quickfix, { desc = "[F]ind [Q]uickfix" })
vim.keymap.set(
    "n",
    "<leader>fl",
    fzf.loclist,
    { desc = "[F]ind [L]ocation list" }
)

-- GitHub permalink
vim.keymap.set({ "n", "x" }, "<leader>gy", function()
    require("gh-permalink").yank()
end, { desc = "[G]itHub [Y]ank permalink" })

-- Insert relative path
vim.keymap.set("n", "<leader>so", function()
    fzf.files({
        prompt = "Path> ",
        previewer = false,
        actions = {
            ["default"] = function(sel)
                local file = sel[1]
                local rel = vim.fn.fnamemodify(file, ":.")
                rel = rel:gsub(" ", "\\ ")
                if not rel:match("^%.?/") then
                    rel = "./" .. rel
                end
                vim.api.nvim_put({ rel }, "l", true, false)
            end,
        },
    })
end, { desc = "[S]earch & insert [O]bject (relative path)" })
