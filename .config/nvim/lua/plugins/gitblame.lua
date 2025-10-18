return {
  "f-person/git-blame.nvim",
  opts = {
    enabled = true,
    message_template = " <summary> • <author> - <date> • <sha>",
    date_format = "%Y-%m-%d %H:%M",
    virtual_text_column = 1,
  },
  vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<cr>", { desc = "Toggle Git blame" }),
}
