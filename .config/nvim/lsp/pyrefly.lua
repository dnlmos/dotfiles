-- #############################################################
-- ####### pyrefly
-- #############################################################
-- main purpose is fast completion/semanticTokens
-- the alternative of it is ty, but it is experimental yet
return {
    cmd = { "pyrefly", "lsp" },
    root_markers = {
        "pyproject.toml",
        "pyrefly.toml",
        "requirements.txt",
        ".git",
    },
    filetypes = { "python" },
    on_attach = function(client, _)
        client.server_capabilities.codeActionProvider = false -- basedpyright has more kinds
        client.server_capabilities.documentSymbolProvider = false -- basedpyright has more kinds
        client.server_capabilities.hoverProvider = false -- basedpyright has more kinds
        client.server_capabilities.inlayHintProvider = false -- basedpyright has more kinds
        client.server_capabilities.referenceProvider = false -- basedpyright has more kinds
        client.server_capabilities.signatureHelpProvider = false -- basedpyright has more kinds
    end,
}
