-- ~/.config/nvim/after/ftplugin/markdown.lua

-- Soft wrap + nice line breaking (your settings)
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Conceal links, **bold**, _italic_, etc. (very popular for markdown)
vim.opt_local.conceallevel = 2 -- 1 = minimal, 2 = more aggressive (most people prefer 2)

-- Spell checking – great for prose/markdown
vim.opt_local.spell = true
vim.opt_local.spelllang = "en" -- or {"en", "sk"} / {"en_us"} etc.

-- Keep textwidth ~72–80 (GitHub / many style guides recommend ≤80)
vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = "+1" -- shows the limit nicely (light gray column)

-- Indentation – markdown usually uses 2 or 4 spaces
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true -- spaces > tabs in markdown

-- Better list continuation & auto-bullets (very useful)
vim.opt_local.formatoptions:append("n") -- numbered lists
vim.opt_local.formatoptions:append("r") -- auto-insert comment leader on <Enter>
vim.opt_local.formatoptions:append("o") -- auto-insert comment leader on o/O

-- Optional but frequently used
vim.opt_local.formatlistpat = [[^\s*\(\d\+[\]:.)}\t ]\||[-*+]\s\+\|>\s\+\)]]

-- Folding by headings (very helpful in long documents)
vim.opt_local.foldlevel = 99 -- start with everything open
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()" -- if you use treesitter

-- Optional: auto-format on save (if you use conform.nvim + prettier/markdownlint)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   buffer = 0,
--   callback = function() vim.lsp.buf.format({ async = false }) end,
-- })
