local starter = require("mini.starter")

local function section_item(name, action, section)
  return { name = name, action = action, section = section }
end

-- Define custom items
local custom_items = {
  -- Config
  section_item("Edit Config", "e $MYVIMRC", "Config"),
  section_item("Edit Lua Config", "e ~/.config/nvim/lua", "Config"),

  -- Plugins
  section_item("Update Plugins", "Lazy update", "Plugins"),

  -- Misc
  section_item("Quit", "qa", "Misc"),
}

-- Combine items
local items = vim.list_extend({
  starter.sections.builtin_actions(),
  starter.sections.recent_files(10, true),
}, custom_items)

-- Add Sessions last
vim.list_extend(items, {
  section_item("Restore Last Session", "lua require('persistence').load({ last = true })", "Sessions"),
  section_item("Select Session", "lua require('persistence').select()", "Sessions"),
})

starter.setup({
  items = items,

  header = table.concat({
    [[╔════════════════════════╗]],
    [[║   Welcome to Neovim    ║]],
    [[╚════════════════════════╝]],
  }, "\n"),

  content_hooks = {
    starter.gen_hook.adding_bullet("» "),
    starter.gen_hook.aligning("center", "center"),
  },
})
