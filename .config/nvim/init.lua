require("config.options")
require("core.lazy")
require("core.lsp")
require("config.autocmds")
require("config.keymaps")

-- Set theme

-- Load the colorscheme
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
