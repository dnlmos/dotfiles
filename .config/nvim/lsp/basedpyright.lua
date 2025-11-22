-- #############################################################
-- ####### basedpyright
-- #############################################################
-- main purpose is exact type checking diagnostics
-- It has very slow lsp completion to use
return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "pyrightconfig.json",
        "requirements.txt",
        ".git",
    },
    on_attach = function(client, _)
        client.server_capabilities.completionProvider = false -- use pyrefly for fast response
        client.server_capabilities.definitionProvider = false -- use pyrefly for fast response
        client.server_capabilities.documentHighlightProvider = false -- use pyrefly for fast response
        client.server_capabilities.renameProvider = false -- use pyrefly as I think it is stable
        client.server_capabilities.semanticTokensProvider = false -- use pyrefly it is more rich
    end,
    settings = { -- see https://docs.basedpyright.com/latest/configuration/language-server-settings/
        basedpyright = {
            disableOrganizeImports = true, -- use ruff instead of it
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true, -- auto serach command paths like 'src'
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
            },
        },
    },
}
