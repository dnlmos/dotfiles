local M = {}

-- Utility to create augroups with a consistent prefix
local function augroup(name)
    return vim.api.nvim_create_augroup("danielm_" .. name, { clear = true })
end

-- Go to last cursor location when reopening file
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if
            vim.tbl_contains(exclude, vim.bo[buf].filetype)
            or vim.b[buf].lazyvim_last_loc
        then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Close certain filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "checkhealth",
        "dbout",
        "gitsigns-blame",
        "grug-far",
        "help",
        "lspinfo",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})

-- Hide man files from buffer list
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
    end,
})

-- Open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("help_vertical"),
    pattern = { "help" },
    callback = function()
        vim.cmd("wincmd L")
    end,
})

-- Disable JSON conceal
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("json_conceal"),
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- No auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("no_auto_comment"),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Auto-create directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+:") then
            return
        end
        local uv = vim.uv or vim.loop
        local file = uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Oil: auto-preview on enter
vim.api.nvim_create_autocmd("User", {
    group = augroup("oil_preview"),
    pattern = "OilEnter",
    callback = vim.schedule_wrap(function(args)
        local oil = require("oil")
        if
            vim.api.nvim_get_current_buf() == args.data.buf
            and oil.get_cursor_entry()
        then
            oil.open_preview()
        end
    end),
})

-- Auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("resize_splits"),
    callback = function()
        vim.cmd("wincmd =")
    end,
})

-- Show cursorline only in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = augroup("active_cursorline"),
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = augroup("active_cursorline"),
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

-- LSP: Highlight references under cursor
vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup(
        "LspReferenceHighlight",
        { clear = true }
    ),
    desc = "Highlight references under cursor",
    callback = function()
        -- Only run if the cursor is not in insert mode
        if vim.fn.mode() ~= "i" then
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            local supports_highlight = false
            for _, client in ipairs(clients) do
                if client.server_capabilities.documentHighlightProvider then
                    supports_highlight = true
                    break -- Found a supporting client, no need to check others
                end
            end

            -- 3. Proceed only if an LSP is active AND supports the feature
            if supports_highlight then
                vim.lsp.buf.clear_references()
                vim.lsp.buf.document_highlight()
            end
        end
    end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMovedI", {
    group = "LspReferenceHighlight",
    desc = "Clear highlights when entering insert mode",
    callback = function()
        vim.lsp.buf.clear_references()
    end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    pattern = "*",
    desc = "Highlight selection on yank",
    callback = function()
        vim.highlight.on_yank({ timeout = 200, visual = true })
    end,
})

-- LSP User Commands
vim.api.nvim_create_user_command("LspStart", function()
    vim.cmd.e()
end, { desc = "Starts LSP clients in the current buffer" })

vim.api.nvim_create_user_command("LspStop", function(opts)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if opts.args == "" or opts.args == client.name then
            client:stop(true)
            vim.notify(client.name .. ": stopped")
        end
    end
end, {
    desc = "Stop all LSP clients or a specific client attached to the current buffer",
    nargs = "?",
    complete = function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local client_names = {}
        for _, client in ipairs(clients) do
            table.insert(client_names, client.name)
        end
        return client_names
    end,
})

vim.api.nvim_create_user_command("LspRestart", function()
    local detach_clients = {}
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        client:stop(true)
        if vim.tbl_count(client.attached_buffers) > 0 then
            detach_clients[client.name] =
                { client, vim.lsp.get_buffers_by_client_id(client.id) }
        end
    end
    local timer = vim.uv.new_timer()
    if not timer then
        return vim.notify("Servers are stopped but havent been restarted")
    end
    timer:start(
        100,
        50,
        vim.schedule_wrap(function()
            for name, client in pairs(detach_clients) do
                local client_id =
                    vim.lsp.start(client[1].config, { attach = false })
                if client_id then
                    for _, buf in ipairs(client[2]) do
                        vim.lsp.buf_attach_client(buf, client_id)
                    end
                    vim.notify(name .. ": restarted")
                end
                detach_clients[name] = nil
            end
            if next(detach_clients) == nil and not timer:is_closing() then
                timer:close()
            end
        end)
    )
end, {
    desc = "Restart all the language client(s) attached to the current buffer",
})

vim.api.nvim_create_user_command("LspLog", function()
    vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
    desc = "Get all the lsp logs",
})

vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("silent checkhealth vim.lsp")
end, {
    desc = "Get all the information about all LSP attached",
})

return M
