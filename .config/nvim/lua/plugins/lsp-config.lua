return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local on_attach = function(_, bufnr)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig').lua_ls.setup({
        capabilities = capabilities })
      require('lspconfig').html.setup({
        capabilities = capabilities })

      require 'lspconfig'.typst_lsp.setup {
        settings = {
          exportPdf = "onType" -- Choose onType, onSave or never.
          -- serverPath = "" -- Normally, there is no need to uncomment it.
        }
      }

     require('lspconfig').pyright.setup({
        capabilities = capabilities,
        settings = {
          pyright = {
         },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { '*' },
            }
          }
        }
      })
    end
  }
}
