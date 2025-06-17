-- Lualine statusline config
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        component_separators = { left = "|", right = "|" },
        section_separators = { left = nil, right = nil },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          {
            "filename",
            file_status = true,
            newfile_status = true,
            path = 1,
            symbols = {
              modified = "*",
              readonly = "!",
              unnamed = "Unnamed",
              newfile = "@",
            },
          },
        },
        lualine_x = {
          function()
            local ok, noice = pcall(require, "noice")
            if not ok then
              return ""
            end
            local msg = require("noice").api.status.command.get()
            return msg or ""
          end,
          -- "encoding",
          "filetype",
        },
        lualine_y = { "diagnostics" },
        lualine_z = { "location" },
      },
      extensions = { "neo-tree", "fugitive", "mason", "lazy", "fzf" },
    },
  },
}
