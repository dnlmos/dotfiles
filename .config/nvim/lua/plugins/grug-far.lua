-- Search and replace
return {
  "MagicDuck/grug-far.nvim",
  cmd = { "GrugFar", "GrugFarWithin" },

  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "grug-far" },
      callback = function(args)
        local buf = args.buf

        -- Keymaps specifically for the grug-far buffer
        vim.keymap.set({ "i", "n", "x" }, "<A-h>", function()
          local state = unpack(require("grug-far").get_instance(0):toggle_flags({ "--hidden", "--glob !.git/" }))
          vim.notify("grug-far: toggled --hidden --glob !.git/ " .. (state and "ON" or "OFF"))
        end, { desc = "Toggle Hidden Files", buffer = buf })

        vim.keymap.set({ "i", "n", "x" }, "<A-i>", function()
          local state = unpack(require("grug-far").get_instance(0):toggle_flags({ "--no-ignore" }))
          vim.notify("grug-far: toggled --no-ignore " .. (state and "ON" or "OFF"))
        end, { desc = "Toggle Ignored Files", buffer = buf })
      end,
    })
  end,

  keys = {
    -- Normal mode mappings
    {
      "<leader>sRc",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%:p") } })
      end,
      desc = "Current File (Normal)",
      mode = "n",
    },
    {
      "<leader>sRa",
      function()
        require("grug-far").open() -- Default to all files in project
      end,
      desc = "All Project Files (Normal)",
      mode = "n",
    },

    -- Visual mode mappings
    {
      "<leader>sRa",
      function()
        require("grug-far").with_visual_selection()
      end,
      desc = "All Files (Visual Selection)",
      mode = "x",
    },
    {
      "<leader>sRc",
      function()
        -- Note: `with_visual_selection` operates on the visual selection content,
        -- so `prefills.paths` for the current file might be redundant here if the intent is to search the selected text.
        -- If the intent is to search the selected text *within* the current file, this is fine.
        require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%:p") } })
      end,
      desc = "Current File (Visual Selection)",
      mode = "x",
    },
    {
      "<leader>sRw",
      "<cmd>GrugFarWithin<CR>",
      desc = "Within Range (Visual Selection)",
      mode = "x",
    },
  },
}
