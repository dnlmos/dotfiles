-- File: lua/core/keymaps.lua
local M = {}

-- Require and setup WhichKey
local wk = require("which-key")
wk.setup({})

-- Window navigation keymaps using Ctrl + hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Buffer navigation using Shift + hl
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Define and register <leader>w group for window commands using the modern approach
wk.add({
  { "<leader>w", group = "Windows" }, -- This creates the group
  { "<leader>wh", "<C-w>h", desc = "Go to left window" },
  { "<leader>wj", "<C-w>j", desc = "Go to lower window" },
  { "<leader>wk", "<C-w>k", desc = "Go to upper window" },
  { "<leader>wl", "<C-w>l", desc = "Go to right window" },
  { "<leader>w-", ":resize -2<CR>", desc = "Decrease window height" },
  { "<leader>w+", ":resize +2<CR>", desc = "Increase window height" },
  { "<leader>w<", ":vertical resize -2<CR>", desc = "Decrease window width" },
  { "<leader>w>", ":vertical resize +2<CR>", desc = "Increase window width" },
  { "<leader>wc", ":close<CR>", desc = "Close current window" },
})

return M
