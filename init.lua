vim.opt.termguicolors = false

-- escape if key not convenient
vim.api.nvim_set_keymap('i', '<C-G>', '<ESC>', { noremap = true })

-- tabs
vim.api.nvim_set_keymap('n', '<Leader>tn', '<cmd>tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>tc', '<cmd>tabclose<CR>', { noremap = true })

-- buffers
vim.api.nvim_set_keymap('n', '<Tab>', '<cmd>bnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', '<cmd>bprev<CR>', { noremap = true })

-- quickfix
vim.api.nvim_set_keymap('n', ']q', '<cmd>cnfile<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[q', '<cmd>cpfile<CR>', { noremap = true })

-- copy to clipboard
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true })

-- use buffers instead of tabs due to plugin: romgrk/barbar.nvim
-- vim.api.nvim_set_keymap('n', 'gt', '<cmd>bnext<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', 'gT', '<cmd>bprev<CR>', { noremap = true })

local TAB_WIDTH = 2
vim.opt.shiftwidth = TAB_WIDTH
vim.opt.softtabstop = TAB_WIDTH
vim.opt.tabstop = TAB_WIDTH

vim.opt.expandtab = true
vim.opt.hlsearch = true

-- do not cut/copy to clipboard
vim.opt.clipboard = nil

-- set to 256 supported color scheme if not in gui mode
if vim.fn.has('gui_running') == 0 then
  vim.cmd.colorscheme('desert')
  -- alternatively: vim.cmd [[colorscheme desert]]
end

-- load ./custom/core/mappings.lua:general
require("custom.core.utils").load_mappings()
