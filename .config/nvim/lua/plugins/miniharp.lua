return {
  'vieitesss/miniharp.nvim',
  config = function()
    require('miniharp').setup({
      autoload = true,
      autosave = true,
      show_on_autoload = false
    })

    vim.keymap.set('n', '<leader>m', require('miniharp').toggle_file, { desc = 'miniharp: toggle file mark' })
    vim.keymap.set('n', '<C-n>', require('miniharp').next, { desc = 'miniharp: next file mark' })
    vim.keymap.set('n', '<C-p>', require('miniharp').prev, { desc = 'miniharp: prev file mark' })
    vim.keymap.set('n', '<leader>l', require('miniharp').show_list, { desc = 'miniharp: list marks' })
  end
}

-- return {
--   "ThePrimeagen/harpoon",
--   branch = "harpoon2",
--   config = function()
--     local harpoon = require("harpoon")
--     harpoon:setup()
--     vim.keymap.set("n", "<leader>p", function() harpoon:list():add() end, { desc = "⇁ pin" })
--     vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "⇁ list" })
--
--     vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "⇁ 1" })
--     vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "⇁ 2" })
--     vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "⇁ 3" })
--     vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "⇁ 4" })
--     vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "⇁ 5" })
--
--     vim.keymap.set("n", "<leader>j", function() harpoon:list():next() end, { desc = "⇁ next" })
--     vim.keymap.set("n", "<leader>k", function() harpoon:list():prev() end, { desc = "⇁ prev" })
--   end
-- }
