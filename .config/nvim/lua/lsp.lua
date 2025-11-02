vim.lsp.enable({
    "bashls",
    "gopls",
    "lua_ls",
    "texlab",
    "ts_ls",
    "rust-analyzer",
    "helm_ls",
    "yamlls",
    "pyright",
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
})

vim.pack.add(
    { "https://github.com/nvim-treesitter/nvim-treesitter" },
    { confirm = false }
)

-- equivalent to :TSUpdate
require("nvim-treesitter.install").update("all")
require("nvim-treesitter.configs").setup({
    sync_install = true,

    modules = {},
    ignore_install = {},

    ensure_installed = {
        "bash",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "rust",
        "python",
        "query",
        "regex",
        "vim",
        "yaml",
    },

    auto_install = true, -- autoinstall languages that are not installed yet

    highlight = {
        enable = true,
    },
})

-- INFO: completion engine
vim.pack.add({ "https://github.com/saghen/blink.cmp" }, { confirm = false })

require("blink.cmp").setup({
    signature = { enabled = true },
    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "normal",
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
            cmdline = {
                min_keyword_length = 2,
            },
        },
    },
    keymap = {
        preset = "enter",
    },
    cmdline = {
        enabled = false,
        completion = { menu = { auto_show = true } },
        keymap = {
            ["<CR>"] = { "accept_and_enter", "fallback" },
        },
    },
    completion = {
        menu = {
            border = "single",
            scrolloff = 1,
            scrollbar = false,
            draw = {
                columns = {
                    { "kind_icon" },
                    { "label", "label_description", gap = 1 },
                    { "kind" },
                    { "source_name" },
                },
            },
        },
        documentation = {
            window = {
                border = "rounded",
                scrollbar = false,
                winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            },
            auto_show = true,
            auto_show_delay_ms = 500,
        },
    },
})

-- INFO: lsp server installation and configuration

-- lsp servers we want to use and their configuration
-- see `:h lspconfig-all` for available servers and their settings
local lsp_servers = {
    lua_ls = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
    clangd = {},
    rust_analyzer = {},
    gopls = {},
}

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig", -- default configs for lsps

    -- NOTE: if you'd rather install the lsps through your OS package manager you
    -- can delete the next three mason-related lines and their setup calls below.
    -- see `:h lsp-quickstart` for more details.
    "https://github.com/mason-org/mason.nvim", -- package manager
    "https://github.com/mason-org/mason-lspconfig.nvim", -- lspconfig bridge
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", -- auto installer
}, { confirm = false })

-- Mason (LSP installer)
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
    ensure_installed = vim.tbl_keys(lsp_servers),
})

-- configure each lsp server on the table
-- to check what clients are attached to the current buffer, use
-- `:checkhealth vim.lsp`. to view default lsp keybindings, use `:h lsp-defaults`.
for server, config in pairs(lsp_servers) do
    vim.lsp.config(server, {
        settings = config,

        -- only create the keymaps if the server attaches successfully
        on_attach = function(_, bufnr)
            vim.keymap.set(
                "n",
                "grd",
                vim.lsp.buf.definition,
                { buffer = bufnr, desc = "vim.lsp.buf.definition()" }
            )

            vim.keymap.set(
                "n",
                "<leader>f",
                vim.lsp.buf.format,
                { buffer = bufnr, desc = "LSP: [F]ormat Document" }
            )
        end,
    })
end

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
    notify_on_error = true,
    formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback" },
        python = {
            -- To fix auto-fixable lint errors.
            "ruff_fix",
            -- To run the Ruff formatter.
            "ruff_format",
            -- To organize the imports.
            "ruff_organize_imports",
        },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
})
