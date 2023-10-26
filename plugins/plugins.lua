-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- @override: disable due to incompatibility with vimr
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
  },

  -- @override: turn on icons
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
      },
    },
  },

  -- file managing , picker etc
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    init = function()
      require('custom.core.utils').load_mappings 'nvimtree'
    end,
    keys = {
      -- toggle
      { '<leader>o', '<cmd>NvimTreeFindFileToggle<CR>', desc = 'toggle NvimTree' },
      -- focus
      { '<leader>e', '<cmd>NvimTreeFocus<CR>', desc = 'Focus nvimtree' },
    },
    -- opts = function()
    --   return require 'custom.plugins.configs.nvimtree'
    -- end,
    opts = {
      -- view = {
      --   -- auto
      --   mappings = {
      --     list = {
      --       { key = "<C-t>", action = "" }, -- removes the default mapping; already have <C-t> mapped to toggle nvim-tree
      --     },
      --   },
      -- },
      renderer = {
        highlight_git = true,
        icons = {
          glyphs = {
            default = '󰈚',
            symlink = '',
            folder = {
              default = '',
              empty = '',
              empty_open = '',
              open = '',
              symlink = '',
              symlink_open = '',
              arrow_open = '',
              arrow_closed = '',
            },
            git = {
              unstaged = '✗',
              staged = '✓',
              unmerged = '',
              renamed = '➜',
              untracked = '★',
              deleted = '',
              ignored = '◌',
            },
          },
        },
      },
    },
    config = function(_, opts)
      -- dofile(vim.g.base46_cache .. 'nvimtree')
      require('nvim-tree').setup(opts)
    end,
  },

  -- @override: add mappings
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gcc', mode = 'n', desc = 'Comment toggle current line' },
      { 'gc', mode = { 'n', 'o' }, desc = 'Comment toggle linewise' },
      { 'gc', mode = 'x', desc = 'Comment toggle linewise (visual)' },
      { 'gbc', mode = 'n', desc = 'Comment toggle current block' },
      { 'gb', mode = { 'n', 'o' }, desc = 'Comment toggle blockwise' },
      { 'gb', mode = 'x', desc = 'Comment toggle blockwise (visual)' },
    },
    init = function()
      require('custom.core.utils').load_mappings 'comment'
    end,
    config = function(_, opts)
      require('Comment').setup(opts)
    end,
  },

  -- Only load whichkey after all the gui
  {
    'folke/which-key.nvim',
    keys = { '<leader>', '<c-r>', '<c-w>', '"', "'", '`', 'c', 'v', 'g' },
    init = function()
      require('custom.core.utils').load_mappings 'whichkey'
    end,
    cmd = 'WhichKey',
    config = function(_, opts)
      require('which-key').setup(opts)
    end,
  },

  -- open terminal
  {
    'NvChad/nvterm',
    init = function()
      require('custom.core.utils').load_mappings 'nvterm'
    end,
    opts = {
      terminals = {
        type_opts = {
          horizontal = { location = 'rightbelow', split_ratio = .3, },
          vertical = { location = 'rightbelow', split_ratio = .3 },
        },
      },
    },
    config = function(_, opts)
      require('nvterm').setup(opts)
    end,
  },

  -- @todo fix flashing
  -- {
  --   'romgrk/barbar.nvim',
  --   dependencies = {
  --     'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
  --     'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  --   },
  --   init = function() vim.g.barbar_auto_setup = false end,
  --   opts = {
  --     -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
  --     -- animation = true,
  --     -- insert_at_start = true,
  --     -- …etc.
  --   },
  -- },

  -- setup top navigation
  -- :h bufferline-configuration
  {
    'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      -- colorize top buffer bar
      highlights = function()
        local l_bufferbg_color = 23 -- 23: turquoise, 233: black
        return {
          tab_selected = {
            ctermbg = l_bufferbg_color,
          },
          tab_separator_selected = {
            ctermbg = l_bufferbg_color,
          },
          duplicate_selected = {
            ctermbg = l_bufferbg_color,
            italic = true,
          },
          close_button_selected = {
            ctermbg = l_bufferbg_color,
          },
          buffer_selected = {
            ctermbg = l_bufferbg_color,
            bold = true,
            italic = true,
          },
          modified_selected = {
            ctermbg = l_bufferbg_color,
          },
          separator_selected = {
            ctermbg = l_bufferbg_color,
          },
          indicator_selected = {
            ctermbg = l_bufferbg_color,
          },
        }
      end,
      options = {
        indicator = {
          icon = '▎✧ ', -- this should be omitted if indicator style is not 'icon'
          -- icon = '▎Ɵ Ѻ ϟ Ѿ ֍ ✪ ☆  ϟឬឬឿ ', -- this should be omitted if indicator style is not 'icon'
          style = 'none', -- 'icon' not needed since using colors
        },
        -- separator_style = { '', '' },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        color_icons = true,
      },
    },
    config = function(_, opts)
      -- set statusbar to use term colors
      vim.opt.termguicolors = false
      -- load plugin
      require('bufferline').setup(opts)
    end,
  },

  -- {
  --   'nvim-neo-tree/neo-tree.nvim',
  --   branch = 'v3.x',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
  --     'MunifTanjim/nui.nvim',
  --     {
  --       's1n7ax/nvim-window-picker',
  --       version = '2.*',
  --       config = function()
  --           require 'window-picker'.setup({
  --               filter_rules = {
  --                   include_current_win = false,
  --                   autoselect_one = true,
  --                   -- filter using buffer options
  --                   bo = {
  --                       -- if the file type is one of following, the window will be ignored
  --                       filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
  --                       -- if the buffer type is one of following, the window will be ignored
  --                       buftype = { 'terminal', 'quickfix' },
  --                   },
  --           },
  --       })
  --       end,
  --     },
  --   },
  --   opts = {
  --     source_selector = {
  --       winbar = true,
  --       statusline = true,
  --     },
  --   },
  --   config = function(_, opts)
  --     require('neo-tree').setup(opts)
  --   end,
  -- },

  -- for diffing directories using with git dirdiff
  {
    'will133/vim-dirdiff'
  },

  -- allow editing of quickfix list for find and replace
  -- @see https://www.youtube.com/watch?v=AuXZA-xCv04
  {
    'stefandtw/quickfix-reflector.vim'
  },

  -- database querying
  {
    'tpope/vim-dadbod',
  },

  -- database ui
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- run postman like http queries for *.http files
  {
    'rest-nvim/rest.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    -- NOTE: cannot add keys since it breaks *.http file association
    -- keys = {},
    opts = {
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = true,
    },
    config = function(_, opts)
      require('rest-nvim').setup(opts)

      -- keybindings for rest.nvim
      vim.api.nvim_set_keymap('n', '<Plug>RestNvim', ':lua require("rest-nvim").run()<CR>', { noremap = true})
      vim.api.nvim_set_keymap('n', '<Leader>rr', '<Plug>RestNvim<CR>', { noremap = true })

      -- =====
      -- NOTES
      -- =====
      -- rest.nvim key bindings [NOTE: rename file extension to .http for this to work]
      -- https://www.reddit.com/r/neovim/comments/n6cdnl/my_first_neovim_plugin_restnvim/
      -- NOTE: add below content to file: ~/.config/nvim/ftdetect/http.vim

      -- map <leader>rr to http rest request
      -- autocmd BufRead,BufNewFile *.http		set filetype=http
      -- vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
      --   pattern = {'*.http'},
      --   callback = function(_) -- ev
      --     vim.opt.filetype = 'http'
      --   end
      -- })
    end
  },

  -- fix uneven windows during dir diffing
  {
    'kwkarlwang/bufresize.nvim',
    enabled = true,
    opts = {
      register = {
        keys = {
          { 'n', '<leader>w<', '30<C-w><', { noremap = true, silent = true, desc = 'Shrink left window' } },
          { 'n', '<leader>w>', '30<C-w>>', { noremap = true, silent = true, desc = 'Enlarge left window' } },
          { 'n', '<leader>w+', '10<C-w>+', { noremap = true, silent = true, desc = 'Enlarge bottom window' } },
          { 'n', '<leader>w-', '10<C-w>-', { noremap = true, silent = true, desc = 'Shrink bottom window' } },
          { 'n', '<leader>w_', '<C-w>_', { noremap = true, silent = true, desc = 'Enlarge vertically (max)' } },
          { 'n', '<leader>w=', '<C-w>=', { noremap = true, silent = true, desc = 'Equalize all window' } },
          { 'n', '<leader>w|', '<C-w>|', { noremap = true, silent = true, desc = 'Enlarge horizontally (max)' } },
          { 'n', '<leader>wo', '<C-w>|<C-w>_', { noremap = true, silent = true, desc = 'Enlarge vertically and horizonally (max)' } },
        },
        trigger_events = { 'BufWinEnter', 'WinEnter' },
      },
      resize = {
        keys = {},
        trigger_events = { 'VimResized' },
        increment = 5,
      },
    },
    config = function(_, opts)
        require('bufresize').setup(opts)
    end
  },

  -- multiple cursor support (ctrl-n)
  -- To select all occurrence inside function using visual multi-mode: <c-n> m i {
  -- @see https://www.youtube.com/watch?v=N-X_zjU5INs
  {
    'mg979/vim-visual-multi',
  },

  -- copy killring from emacs
  {
    'gbprod/yanky.nvim',
    keys = {
      { 'p', '<Plug>(YankyPutAfter)', desc = 'Paste after cursor', mode = {'x', 'n'} },
      { 'P', '<Plug>(YankyPutBefore)', desc = 'Paste before cursor', mode = {'x', 'n'} },
      { 'gp', '<Plug>(YankyGPutAfter)', desc = 'Paste after but leave cursor', mode = {'x', 'n'} },
      { 'gP', '<Plug>(YankyGPutBefore)', desc = 'Paste before but leave cursor', mode = {'x', 'n'} },

      { '<M-y>', '<Plug>(YankyCycleForward)', desc = 'Paste from killring', mode = 'n' },
      { '<M-Y>', '<Plug>(YankyCycleBackward)', desc = 'Paste from previous killring', mode = 'n' },
    },
    opts = {},
    config = function(_, opts)
        require('yanky').setup(opts)
    end
  },

  -- =========================== --
  -- LSP, linters and formatters
  -- =========================== --
  -- os-level package manager
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUpdate' },
    opts = {
      ensure_installed = {
        'eslint-lsp', -- linter
        'prettier', -- formatter
        'js-debug-adapter', -- JavaScript debugger
        'typescript-language-server', -- JavaScript/TypeScript LSP
        'clangd', -- C/C++ LSP
        'clang-format', -- C/C++ formatter
        'codelldb', -- clang debugger
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command('MasonInstallAll', function()
        vim.cmd('MasonInstall ' .. table.concat(opts.ensure_installed, ' '))
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

  -- codelldb nvim plugin
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      handlers = {},
    }
  },
  -- js debugger ui
  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      require('dapui').setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end
  },
  -- js debugger
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<leader>db', '<cmd>DapToggleBreakpoint<CR>', desc = 'Add breakpoint at line' },
      { '<leader>dr', '<cmd>DapContinue<CR>', desc = 'Run or continue the debugger' },
    },
    config = function()
      require 'custom.plugins.configs.dap'
    end
  },
  -- ts debugger
  -- @see https://www.reddit.com/r/neovim/comments/zygqnn/do_you_have_typescript_debugging_working_with/
  -- @see https://github.com/anasrar/.dotfiles/blob/4c444c3ab2986db6ca7e2a47068222e47fd232e2/neovim/.config/nvim/lua/rin/DAP/languages/typescript.lua
  --
  -- @todo setup lsp better:
  -- https://www.youtube.com/watch?v=7Nt8n3rjfDY
  -- https://github.com/VonHeikemen/lsp-zero.nvim
  {
    'mxsdev/nvim-dap-vscode-js',
    enabled = false,
    opts = {
      node_path = 'node',
      debugger_path = os.getenv('HOME') .. '/.local/share/nvim/mason/packages/js-debug-adapter/js-debug',
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    },
    config = function(_, opts)
      require('dap-vscode-js').setup(opts)

      local dap = require('dap')
      local exts = {
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
        -- using pwa-chrome
        'vue',
        'svelte',
      }

      for i, ext in ipairs(exts) do
        dap.configurations[ext] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Current File (pwa-node)',
            cwd = vim.fn.getcwd(),
            args = { '${file}' },
            sourceMaps = true,
            protocol = 'inspector',
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Current File (pwa-node with ts-node)',
            cwd = vim.fn.getcwd(),
            runtimeArgs = { '--loader', 'ts-node/esm' },
            runtimeExecutable = 'node',
            args = { '${file}' },
            sourceMaps = true,
            protocol = 'inspector',
            skipFiles = { '<node_internals>/**', 'node_modules/**' },
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Current File (pwa-node with deno)',
            cwd = vim.fn.getcwd(),
            runtimeArgs = { 'run', '--inspect-brk', '--allow-all', '${file}' },
            runtimeExecutable = 'deno',
            attachSimplePort = 9229,
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Test Current File (pwa-node with jest)',
            cwd = vim.fn.getcwd(),
            runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
            runtimeExecutable = 'node',
            args = { '${file}', '--coverage', 'false'},
            rootPath = '${workspaceFolder}',
            sourceMaps = true,
            console = 'integratedTerminal',
            internalConsoleOptions = 'neverOpen',
            skipFiles = { '<node_internals>/**', 'node_modules/**' },
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Test Current File (pwa-node with vitest)',
            cwd = vim.fn.getcwd(),
            program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
            args = { '--inspect-brk', '--threads', 'false', 'run', '${file}' },
            autoAttachChildProcesses = true,
            smartStep = true,
            console = 'integratedTerminal',
            skipFiles = { '<node_internals>/**', 'node_modules/**' },
          },
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch Test Current File (pwa-node with deno)',
            cwd = vim.fn.getcwd(),
            runtimeArgs = { 'test', '--inspect-brk', '--allow-all', '${file}' },
            runtimeExecutable = 'deno',
            attachSimplePort = 9229,
          },
          {
            type = 'pwa-chrome',
            request = 'attach',
            name = 'Attach Program (pwa-chrome = { port: 9222 })',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            port = 9222,
            webRoot = '${workspaceFolder}',
          },
          {
            type = 'node2',
            request = 'attach',
            name = 'Attach Program (Node2)',
            processId = require('dap.utils').pick_process,
          },
          {
            type = 'node2',
            request = 'attach',
            name = 'Attach Program (Node2 with ts-node)',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            skipFiles = { '<node_internals>/**' },
            port = 9229,
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach Program (pwa-node)',
            cwd = vim.fn.getcwd(),
            processId = require('dap.utils').pick_process,
            skipFiles = { '<node_internals>/**' },
          },
        }
      end
    end
  },
  -- C/C++ formatter and linter
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'VeryLazy',
    opts = function()
      return require 'custom.plugins.configs.null-ls'
    end
  },
  -- prettier (2 second delay between activation on write)
  {
    'mhartington/formatter.nvim',
    event = 'VeryLazy',
    opts = function()
      return require 'custom.plugins.configs.formatter'
    end
  },
  -- eslint-lsp (5 second delay between activation on write)
  {
    'mfussenegger/nvim-lint',
    event = 'VeryLazy',
    config = function()
      require 'custom.plugins.configs.lint'
    end
  },
  -- plugin for lsp
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- require 'plugins.configs.lspconfig'
      require 'custom.plugins.configs.lspconfig'
    end,
  },
}


-- {
--   fill = {
--     ctermbg = l_bufferbg_color,
--   },
--   background = {
--     ctermbg = l_bufferbg_color,
--   },
--   tab = {
--     ctermbg = l_bufferbg_color,
--   },
--   tab_selected = {
--     ctermbg = l_bufferbg_color,
--   },
--   tab_separator = {
--     ctermbg = l_bufferbg_color,
--   },
--   tab_separator_selected = {
--     ctermbg = l_bufferbg_color,
--   },
--   tab_close = {
--     ctermbg = l_bufferbg_color,
--   },
--   close_button = {
--     ctermbg = l_bufferbg_color,
--   },
--   close_button_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   close_button_selected = {
--     ctermbg = l_bufferbg_color,
--   },
--   buffer_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   buffer_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   numbers = {
--     ctermbg = l_bufferbg_color,
--   },
--   numbers_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   numbers_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   diagnostic = {
--     ctermbg = l_bufferbg_color,
--   },
--   diagnostic_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   diagnostic_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   hint = {
--     ctermbg = l_bufferbg_color,
--   },
--   hint_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   hint_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   hint_diagnostic = {
--     ctermbg = l_bufferbg_color,
--   },
--   hint_diagnostic_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   hint_diagnostic_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   info = {
--     ctermbg = l_bufferbg_color,
--   },
--   info_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   info_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   info_diagnostic = {
--     ctermbg = l_bufferbg_color,
--   },
--   info_diagnostic_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   info_diagnostic_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   warning = {
--     ctermbg = l_bufferbg_color,
--   },
--   warning_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   warning_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   warning_diagnostic = {
--     ctermbg = l_bufferbg_color,
--   },
--   warning_diagnostic_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   warning_diagnostic_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   error = {
--     ctermbg = l_bufferbg_color,
--   },
--   error_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   error_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   error_diagnostic = {
--     ctermbg = l_bufferbg_color,
--   },
--   error_diagnostic_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   error_diagnostic_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   modified = {
--     ctermbg = l_bufferbg_color,
--   },
--   modified_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   modified_selected = {
--     ctermbg = l_bufferbg_color,
--   },
--   duplicate_selected = {
--     ctermbg = l_bufferbg_color,
--     italic = true,
--   },
--   duplicate_visible = {
--     ctermbg = l_bufferbg_color,
--     italic = true,
--   },
--   duplicate = {
--     ctermbg = l_bufferbg_color,
--     italic = true,
--   },
--   separator_selected = {
--     ctermbg = l_bufferbg_color,
--   },
--   separator_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   separator = {
--     ctermbg = l_bufferbg_color,
--   },
--   indicator_visible = {
--     ctermbg = l_bufferbg_color,
--   },
--   indicator_selected = {
--     ctermbg = l_bufferbg_color,
--   },
--   pick_selected = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   pick_visible = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   pick = {
--     ctermbg = l_bufferbg_color,
--     bold = true,
--     italic = true,
--   },
--   offset_separator = {
--     ctermbg = l_bufferbg_color,
--   },
--   trunc_marker = {
--     ctermbg = l_bufferbg_color,
--   },
-- }
