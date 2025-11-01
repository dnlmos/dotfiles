vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim" },
})
require("which-key").setup({
    preset = "helix",
})

local keymap = vim.keymap.set
local s = { silent = true }

keymap("n", "<space>", "<Nop>")

-- movement
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

--- save and quit
keymap("n", "<leader>w", "<cmd>w!<CR>", s)
keymap("n", "<leader>q", "<cmd>q<CR>", s)

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

-- Oil
keymap("n", "<leader>e", function() require('oil').toggle_float() end, { desc = "File Manager", nowait = true })

-- cd current dir
keymap("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')

local ns = { noremap = true, silent = true }
local er = { expr = true, replace_keycodes = false }
keymap("n", "grd", "<cmd>lua vim.lsp.buf.definition()<CR>", ns)
keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.jump({count = 1})<CR>", ns)
keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.jump({count = -1})<CR>", ns)
keymap("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")
keymap("n", "<leader>gs", "<cmd>Git<CR>", ns)
keymap("n", "<leader>gp", "<cmd>Git push<CR>", ns)
keymap("n", "<leader>ff", "<cmd>FzfLua files<CR>")
keymap("n", "<leader>fg", "<cmd>FzfLua grep_project<CR>")
keymap("n", "<leader>fl", "<cmd>FzfLua grep_last<CR>")
keymap("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>")
keymap("n", "<leader>co", "<cmd>CommandExecute<CR>")
keymap("n", "<leader>cr", "<cmd>CommandExecuteLast<CR>")
keymap("i", "<S-Tab>", 'copilot#Accept("\\<Tab>")', er)
keymap({ "n", "x" }, "<leader>gy", require("gh-permalink").yank)
keymap("n", "<leader>so", function()
    require("fzf-lua").files({
        actions = {
            ["default"] = function(selected)
                local file = selected[1]
                local rel_path = vim.fn.fnamemodify(file, ":.")

                rel_path = rel_path:gsub(" ", "\\ ")
                if not rel_path:match("^%.?/") then
                    rel_path = "./" .. rel_path
                end

                vim.api.nvim_put({ rel_path }, "l", true, false)
            end,
        },
    })
end)

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n","<leader>cf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, {desc = "Format buffer"})

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
