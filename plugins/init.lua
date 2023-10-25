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
    -- opts = function()
    --   return require 'custom.plugins.configs.nvimtree'
    -- end,
    opts = {
      renderer = {
        highlight_git = true,
        icons = {
          glyphs = {
            default = "󰈚",
            symlink = "",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
              symlink_open = "",
              arrow_open = "",
              arrow_closed = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
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
    "NvChad/nvterm",
    init = function()
      require("custom.core.utils").load_mappings "nvterm"
    end,
    opts = {
      terminals = {
        type_opts = {
          horizontal = { location = "rightbelow", split_ratio = .3, },
          vertical = { location = "rightbelow", split_ratio = .3 },
        },
      },
    },
    config = function(_, opts)
      require("nvterm").setup(opts)
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
    'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      -- colorize top buffer bar
      highlights = function()
        local l_buffergb_color = 233
        return {
          close_button_selected = {
            ctermbg = l_buffergb_color,
          },
          buffer_selected = {
            ctermbg = l_buffergb_color,
            bold = true,
            italic = true,
          },
          modified_selected = {
            ctermbg = l_buffergb_color,
          },
          separator_selected = {
            ctermbg = l_buffergb_color,
          },
          indicator_selected = {
            ctermbg = l_buffergb_color,
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
      require("bufferline").setup(opts)
    end,
  },

  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
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
  --                       filetype = { 'neo-tree', "neo-tree-popup", "notify" },
  --                       -- if the buffer type is one of following, the window will be ignored
  --                       buftype = { 'terminal', "quickfix" },
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
  --     require("neo-tree").setup(opts)
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
    "rest-nvim/rest.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("rest-nvim").setup({
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = true,
      })
    end
  },

  -- fix uneven windows during dir diffing
  {
    'kwkarlwang/bufresize.nvim',
    enabled = true,
    opts = {
      register = {
        keys = {
          { "n", "<leader>w<", "30<C-w><", { noremap = true, silent = true, desc = 'Shrink left window' } },
          { "n", "<leader>w>", "30<C-w>>", { noremap = true, silent = true, desc = 'Enlarge left window' } },
          { "n", "<leader>w+", "10<C-w>+", { noremap = true, silent = true, desc = 'Enlarge bottom window' } },
          { "n", "<leader>w-", "10<C-w>-", { noremap = true, silent = true, desc = 'Shrink bottom window' } },
          { "n", "<leader>w_", "<C-w>_", { noremap = true, silent = true, desc = 'Enlarge vertically (max)' } },
          { "n", "<leader>w=", "<C-w>=", { noremap = true, silent = true, desc = 'Equalize all window' } },
          { "n", "<leader>w|", "<C-w>|", { noremap = true, silent = true, desc = 'Enlarge horizontally (max)' } },
          { "n", "<leader>wo", "<C-w>|<C-w>_", { noremap = true, silent = true, desc = 'Enlarge vertically and horizonally (max)' } },
        },
        trigger_events = { "BufWinEnter", "WinEnter" },
      },
      resize = {
        keys = {},
        trigger_events = { "VimResized" },
        increment = 5,
      },
    },
    config = function(_, opts)
        require('bufresize').setup(opts)
    end
  },
}
