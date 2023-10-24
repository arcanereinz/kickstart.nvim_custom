vim.opt.termguicolors = false
vim.api.nvim_set_keymap('i', '<C-G>', '<ESC>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tn', '<cmd>tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tc', '<cmd>tabclose<CR>', { noremap = true })

local TAB_WIDTH = 2
vim.opt.shiftwidth = TAB_WIDTH
vim.opt.softtabstop = TAB_WIDTH
vim.opt.tabstop = TAB_WIDTH

vim.opt.expandtab = true

-- set to 256 supported color scheme if not in gui mode
if vim.fn.has('gui_running') == 0 then
  vim.cmd.colorscheme('desert')
  -- alternatively: vim.cmd [[colorscheme desert]]
end
