-- open neovim, split the window.
-- I place my Python script in one side, and on the other side, I open the terminal with IPython.
return { {
  'goerz/jupytext.vim',
  init = function()
    -- will use `# %%` to define cells
    vim.g.jupytext_fmt = 'py:percent'
  end
},
  {
    'jpalardy/vim-slime',
    init = function()
      vim.g.slime_last_channel = { nil }
      -- will use `# %%` to define cells
      vim.g.slime_cell_delimiter = '\\s*#\\s*%%'
      vim.g.slime_paste_file = os.getenv("HOME") .. "/.slime_paste"

      local function next_cell()
        vim.fn.search(vim.g.slime_cell_delimiter)
      end

      local function prev_cell()
        vim.fn.search(vim.g.slime_cell_delimiter, "b")
      end

      vim.keymap.set('n', '<leader>rl', vim.cmd.SlimeSend, { noremap = true, desc = 'Slime: Send line to terminal' })
      vim.keymap.set('n', '<leader>rc', vim.cmd.SlimeConfig, { noremap = true, desc = "Slime: Open configuration" })
      vim.keymap.set('x', '<leader>rs', '<Plug>SlimeRegionSend',
        { noremap = true, desc = 'Slime: Send selected region to tmux' })
      vim.keymap.set('n', '<leader>rp', '<Plug>SlimeParagraphSend', { noremap = true, desc = "Slime: Send paragraph" })
      vim.keymap.set('n', '<leader>rk', prev_cell, { noremap = true, desc = "Slime: Search backward for cell delimiter" })
      vim.keymap.set('n', '<leader>rj', next_cell, { noremap = true, desc = "Slime: Search forward for cell delimiter" })
      vim.keymap.set('n', '<leader>rr', '<Plug>SlimeSendCell', { noremap = true, desc = "Slime: Send cell" })

      local slime_get_jobid = function()
        local buffers = vim.api.nvim_list_bufs()
        local terminal_buffers = { "Select terminal:\tjobid\tname", }
        local name = ""
        local jid = 1
        local chosen_terminal = 1

        for _, buf in ipairs(buffers) do
          if vim.bo[buf].buftype == 'terminal' then
            jid = vim.api.nvim_buf_get_var(buf, 'terminal_job_id')
            name = vim.api.nvim_buf_get_name(buf)
            table.insert(terminal_buffers, jid .. "\t" .. name)
          end
        end

        -- if there is more than one terminal, ask which one to use
        if #terminal_buffers > 2 then
          chosen_terminal = vim.fn.inputlist(terminal_buffers)
        else
          chosen_terminal = jid
        end

        if chosen_terminal then
          print("\n[slime] jobid chosen: ", chosen_terminal)
          return chosen_terminal
        else
          print("No terminal found")
        end
      end

      local function slime_use_tmux()
        vim.g.slime_target = "tmux"
        vim.g.slime_bracketed_paste = 1
        vim.g.slime_python_ipython = 0
        vim.g.slime_no_mappings = 1
        vim.g.slime_default_config = { socket_name = "default", target_pane = ":.2" }
        vim.g.slime_dont_ask_default = 1
      end

      local function slime_use_neovim()
        vim.g.slime_target = "neovim"
        vim.g.slime_bracketed_paste = 1
        vim.g.slime_python_ipython = 1
        vim.g.slime_no_mappings = 1
        vim.g.slime_get_jobid = slime_get_jobid
        -- vim.g.slime_default_config = nil
        -- vim.g.slime_dont_ask_default = 0
      end

      slime_use_neovim()
      -- slime_use_tmux()
      -- }}
    end
  }
}
