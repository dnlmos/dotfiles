-- stylua: ignore
-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- Material theme setup
  {
    "marko-cerovac/material.nvim",
    init = function()
      vim.g.material_style = "darker"
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "material",
    },
  },

  -- Disable trouble.nvim
  {
    "folke/trouble.nvim",
    enabled = false,
  },

  -- Add cmp-emoji to nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- Telescope customization
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- LSP configuration
{
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- Python configuration
      pyright = {}, -- Python type checking
      -- Lua configuration
      lua_ls = {
        -- Lua config as before
      },
    },
  },
},

  -- Formatting
  {
    "stevearc/conform.nvim", -- Assuming you're using conform.nvim for formatting
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Keep your other formatters
        python = { "ruff_format" }, -- You can use ruff for formatting too
      },
    },
  },

  -- Treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- Mason tools to install
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "pyright",
        "ruff",
        "lua-language-server",
        "shellcheck",
        "shfmt",
        "markdownlint",
        "markdownlint-cli2",
      })
    end,
  },
}
