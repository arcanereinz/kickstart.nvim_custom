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

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    opts = function()
      return require("custom.plugins.configs.others").gitsigns
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
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
      options = {
        indicator = {
          icon = '▎✧ ', -- this should be omitted if indicator style is not 'icon'
          -- icon = '▎Ɵ Ѻ ϟ Ѿ ֍ ✪ ☆  ϟឬឬឿ ', -- this should be omitted if indicator style is not 'icon'
          style = 'icon',
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        color_icons = true,
      },
    },
    config = function(_, opts)
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
}
