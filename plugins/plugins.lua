-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- disable due to incompatibility with vimr
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
  },

  -- turn on icons
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
}
