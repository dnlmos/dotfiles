return {
  -- Lualine statusline config
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

-- -- util/lualine.lua
-- -- standalone lualine utility module (no LazyVim dependency)
-- local lualine_util = {}
--
-- local function get_color(group)
--   return { fg = group }
-- end
--
-- function lualine_util.status(icon, status)
--   local colors = {
--     ok = "Special",
--     error = "DiagnosticError",
--     pending = "DiagnosticWarn",
--   }
--   return {
--     function()
--       return icon
--     end,
--     cond = function()
--       return status() ~= nil
--     end,
--     color = function()
--       return get_color(colors[status()] or colors.ok)
--     end,
--   }
-- end
--
-- function lualine_util.cmp_source(name, icon)
--   local icons = { Buffer = "﩯", Path = "", Calc = "", Emoji = "😀" }
--   icon = icon or icons[name] or ""
--   local started = false
--   return lualine_util.status(icon, function()
--     if not package.loaded["cmp"] then
--       return
--     end
--     for _, s in ipairs(require("cmp").core.sources or {}) do
--       if s.name == name then
--         if s.source:is_available() then
--           started = true
--         else
--           return started and "error" or nil
--         end
--         if s.status == s.SourceStatus.FETCHING then
--           return "pending"
--         end
--         return "ok"
--       end
--     end
--   end)
-- end
--
-- function lualine_util.format(component, text, hl_group)
--   text = text:gsub("%%", "%%%%")
--   if not hl_group or hl_group == "" then
--     return text
--   end
--   component.hl_cache = component.hl_cache or {}
--   local lualine_hl_group = component.hl_cache[hl_group]
--   if not lualine_hl_group then
--     local utils = require("lualine.utils.utils")
--     local gui = vim.tbl_filter(function(x)
--       return x
--     end, {
--       utils.extract_highlight_colors(hl_group, "bold") and "bold",
--       utils.extract_highlight_colors(hl_group, "italic") and "italic",
--     })
--     lualine_hl_group = component:create_hl({
--       fg = utils.extract_highlight_colors(hl_group, "fg"),
--       gui = #gui > 0 and table.concat(gui, ",") or nil,
--     }, "UTIL_" .. hl_group)
--     component.hl_cache[hl_group] = lualine_hl_group
--   end
--   return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
-- end
--
-- function lualine_util.pretty_path(opts)
--   opts = vim.tbl_extend("force", {
--     relative = "cwd",
--     modified_hl = "MatchParen",
--     directory_hl = "",
--     filename_hl = "Bold",
--     modified_sign = "",
--     readonly_icon = " 󰌾 ",
--     length = 3,
--   }, opts or {})
--   return function(self)
--     local path = vim.fn.expand("%:p")
--     if path == "" then
--       return ""
--     end
--     local cwd = vim.loop.cwd()
--     if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
--       path = path:sub(#cwd + 2)
--     end
--     local sep = package.config:sub(1, 1)
--     local parts = vim.split(path, "[\\/]", { plain = false })
--     if opts.length == 0 then
--       parts = parts
--     elseif #parts > opts.length then
--       parts = { parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
--     end
--     if opts.modified_hl and vim.bo.modified then
--       parts[#parts] = parts[#parts] .. opts.modified_sign
--       parts[#parts] = lualine_util.format(self, parts[#parts], opts.modified_hl)
--     else
--       parts[#parts] = lualine_util.format(self, parts[#parts], opts.filename_hl)
--     end
--     local dir = ""
--     if #parts > 1 then
--       dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
--       dir = lualine_util.format(self, dir .. sep, opts.directory_hl)
--     end
--     local readonly = ""
--     if vim.bo.readonly then
--       readonly = lualine_util.format(self, opts.readonly_icon, opts.modified_hl)
--     end
--     return dir .. parts[#parts] .. readonly
--   end
-- end
--
-- function lualine_util.root_dir(opts)
--   opts = vim.tbl_extend("force", {
--     cwd = false,
--     subdirectory = true,
--     parent = true,
--     other = true,
--     icon = "󱉭 ",
--     color = function()
--       return get_color("Special")
--     end,
--   }, opts or {})
--
--   local function get()
--     local cwd = vim.loop.cwd()
--     local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
--     if not git_root or git_root == "" then
--       git_root = cwd
--     end
--     local name = vim.fn.fnamemodify(git_root, ":t")
--     if git_root == cwd then
--       return opts.cwd and name
--     elseif git_root:find(cwd, 1, true) == 1 then
--       return opts.subdirectory and name
--     elseif cwd:find(git_root, 1, true) == 1 then
--       return opts.parent and name
--     else
--       return opts.other and name
--     end
--   end
--
--   return {
--     function()
--       return (opts.icon and opts.icon .. " " or "") .. (get() or "")
--     end,
--     cond = function()
--       return type(get()) == "string"
--     end,
--     color = opts.color,
--   }
-- end
--
-- -- noice defaults (as in your original snippet)
-- local Msg = require("noice.ui.msg")
--
-- local noice_defaults = {
--   ruler = { event = Msg.events.ruler },
--   message = { event = Msg.events.show },
--   command = { event = Msg.events.showcmd },
--   mode = { event = Msg.events.showmode },
--   search = { event = Msg.events.show, kind = Msg.kinds.search_count },
-- }
--
-- -- Plugin spec with lualine setup showing multiple noice components
-- return {
--   "nvim-lualine/lualine.nvim",
--   event = "VeryLazy",
--   dependencies = { "nvim-tree/nvim-web-devicons", "folke/noice.nvim" },
--
--   config = function()
--     require("lualine").setup({
--       options = {
--         icons_enabled = true,
--         theme = "auto",
--         component_separators = { left = "|", right = "|" },
--         section_separators = { left = "|", right = "|" },
--         always_divide_middle = true,
--         always_show_tabline = true,
--       },
--       sections = {
--         lualine_a = { "mode" },
--         lualine_b = { "branch", "diff", "diagnostics" },
--         lualine_c = {
--           "filename",
--           -- noice command line
--           {
--             function()
--               return require("noice").api.status.command.get()
--             end,
--             cond = function()
--               return require("noice").api.status.command.has()
--             end,
--             color = { fg = "#ff9e64" },
--           },
--           -- noice search count
--           {
--             function()
--               return require("noice").api.status.search.get()
--             end,
--             cond = function()
--               return require("noice").api.status.search.has()
--             end,
--             color = { fg = "#98be65" },
--           },
--           -- noice mode
--           {
--             function()
--               return require("noice").api.status.mode.get()
--             end,
--             cond = function()
--               return require("noice").api.status.mode.has()
--             end,
--             color = { fg = "#7aa2f7" },
--           },
--         },
--         lualine_x = { "encoding", "fileformat", "filetype" },
--         lualine_y = { "progress" },
--         lualine_z = { "location" },
--       },
--       inactive_sections = {
--         lualine_a = {},
--         lualine_b = {},
--         lualine_c = { "filename" },
--         lualine_x = { "location" },
--         lualine_y = {},
--         lualine_z = {},
--       },
--       extensions = {},
--     })
--   end,
--   -- expose util module in case you want to use those helpers elsewhere:
--   util = lualine_util,
--   noice_defaults = noice_defaults,
-- }
