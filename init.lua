-- ==================
-- custom keybindings
-- ==================
-- escape if key not convenient (insert mode)
vim.api.nvim_set_keymap('i', '<C-g>', '<C-\\><C-n>', { noremap = true, desc = 'Escapse inside terminal' })
-- terminal mode for :terminal or <M-i> or <leaer>tt
vim.api.nvim_set_keymap('t', '<C-g>', '<C-\\><C-n>', { noremap = true, desc = 'Escapte inside terminal' })

-- buffers
vim.api.nvim_set_keymap('n', 'ge', '<cmd>bnext<CR>', { noremap = true, desc = 'Next buffer' })
vim.api.nvim_set_keymap('n', 'gw', '<cmd>bprev<CR>', { noremap = true, desc = 'Previous buffer' })
vim.api.nvim_set_keymap('n', 'go', '<cmd>enew<CR>', { noremap = true, desc = 'New buffer' })
vim.api.nvim_set_keymap('n', 'ga', '<cmd>:bdelete<CR>', { noremap = true, desc = 'Close tab' })

-- tabs
vim.api.nvim_set_keymap('n', 'gO', '<cmd>tabnew<CR>', { noremap = true, desc = 'Open new tab' })

-- quickfix
vim.api.nvim_set_keymap('n', ']q', '<cmd>cnfile<CR>', { noremap = true, desc = 'Goto next quickfix file' })
vim.api.nvim_set_keymap('n', '[q', '<cmd>cpfile<CR>', { noremap = true, desc = 'Goto previous quickfix file' })

-- escape terminal mode via Ctrl+w
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { noremap = true, silent = true })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { noremap = true, silent = true })
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { noremap = true, silent = true })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { noremap = true, silent = true })

-- @todo to paste in telescope map ctrl+p to <C-r>"
-- copy/paste to/from clipboard
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, desc = 'Copy to clipboard' })

-- specific neovide settings to make work as expected
if vim.g.neovide then
  -- copy in visual mode
  vim.keymap.set('v', '<D-c>', '"+y', { noremap = true, desc = 'Copy to clipboard' })

  -- paste in mode: https://neovide.dev/faq.html
  vim.keymap.set('t', '<D-v>', '<C-\\><C-o>"+p', { noremap = true, silent = true })
  vim.keymap.set('v', '<D-v>', '"+p', { noremap = true, silent = true })
  vim.keymap.set('n', '<D-v>', '"+p', { noremap = true, desc = 'Paste from clipboard' })
  vim.keymap.set('i', '<D-v>', '<C-o>"+p', { noremap = true, desc = 'Paste from clipboard' })
  vim.keymap.set('c', '<D-v>', '<C-R>+')

  -- select all
  vim.keymap.set('n', '<D-a>', 'ggVG', { noremap = true, silent = true })
  vim.keymap.set('v', '<D-a>', '<ESC>ggVG', { noremap = true, silent = true })
  vim.keymap.set('i', '<D-a>', '<ESC>ggVG', { noremap = true, silent = true })

  -- toggle comments
  vim.api.nvim_set_keymap('n', '<D-/>', '<Leader>/', { noremap = false, desc = 'Toggle comment' })
  vim.api.nvim_set_keymap('v', '<D-/>', '<Leader>/', { noremap = false, desc = 'Toggle comment' })

  -- fix for terminal: make alt key function as meta key
  vim.g.neovide_input_macos_alt_is_meta = true

  -- if root switch to home
  -- lcd $HOME/Projects
  if vim.env.PWD == '/' then
    vim.cmd.lcd(vim.env.HOME)
  end
end

-- markdown preview
vim.keymap.set('n', '<C-s>', '<Plug>MarkdownPreview', { noremap = true, desc = 'Markdown Preview' })
vim.keymap.set('n', '<M-s>', '<Plug>MarkdownPreviewStop', { noremap = true, desc = 'Markdown Stop' })
vim.keymap.set('n', '<C-p>', '<Plug>MarkdownPreviewToggle', { noremap = true, desc = 'Markdown Toggle' })

-- show code documentation
-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, noremap = true })
-- vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, { silent = true, noremap = true })

-- go to next git match (]m [m), ":Git log -- %" for current file
vim.api.nvim_set_keymap('n', '<Leader>gh', ':Git log --graph --decorate --date-order --stat<CR><CR>', { noremap = true, desc = 'Goto [h]istory' })
vim.api.nvim_set_keymap('n', '<Leader>gl', ':Git log --graph --decorate --date-order --stat -- %<CR><CR>', { noremap = true, desc = 'Goto fi[l]e history' })
-- @todo install undotree

-- Replace word under cursor across entire buffer
-- source: https://www.youtube.com/watch?v=N-X_zjU5INs
-- source: https://github.com/exosyphon/nvim/blob/43dc5cd2a903671e711f7f58ef070d1641c0b8b6/lua/exosyphon/remaps.lua#L47
vim.keymap.set("n", "<Leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left>]], { desc = "Replace under word" })

-- keymap for tpope/vim-repeat to fix .
vim.cmd [[
  silent! call repeat#set("\<Plug>Lightspeed_;_sx", v:count)
]]

-- <tab> and <c-i> same so remapping <c-i> to <m-o>
-- also alt+shift works but ctrl+shift does not work so must lowercase o
-- vim.api.nvim_set_keymap('n', '<M-o>', '<C-i>', { noremap = true }) -- noremap needed

-- ===============
-- git keybindings
-- ===============
-- review got logs:
--    ":Git log --stat" to show diff, hit "enter" on commit, ]\ to go next to file, hit "enter" on file, "dq" to close file, "ctrl-o" to go back to git file comparion
-- diff this file and close
--    open diff using "<Leader>gd" and close using "<Leader>tc"
vim.api.nvim_set_keymap('n', '<Leader>gd', '<cmd>Git difftool -y<CR>', { noremap = true, desc = "Open git difftool" })

-- vim.api.nvim_set_keymap('n', '<Leader>rr', '<Plug>DBUI_ToggleResultLayout', { noremap = true })
-- vim.api.nvim_set_keymap("n", "<Plug>DBUI_ToggleResultLayout", ":lua require('rest-nvim').run()<CR>", { noremap = true})

-- use buffers instead of tabs due to plugin: romgrk/barbar.nvim
-- vim.api.nvim_set_keymap('n', 'gt', '<cmd>bnext<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', 'gT', '<cmd>bprev<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>dw', '<Plug>(DBUI_SaveQuery)', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>E', '<Plug>(DBUI_EditBindParameters)', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>S', '<Plug>(DBUI_ExecuteQuery)', { noremap = true })
-- vim.api.nvim_set_keymap('v', '<Leader>S', '<Plug>(DBUI_ExecuteQuery)', { noremap = true })

-- ==================
-- neovide neovim gui
-- ==================
if vim.g.neovide then
  -- shorted cursor animation (set to 0 for disable)
  vim.g.neovide_cursor_animation_length = 0.005
  -- preserve when reopening
  vim.g.remember_window_size = true
end

-- =====================
-- vim-dadbod-completion
-- =====================
-- used by kristijanhusak/vim-dadbod-completion for word completion
vim.cmd [[
  autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })

  " Source is automatically added, you just need to include it in the chain complete list
  let g:completion_chain_complete_list = {
      \   'sql': [
      \    {'complete_items': ['vim-dadbod-completion']},
      \   ],
      \ }
  " Make sure `substring` is part of this list. Other items are optional for this completion source
  let g:completion_matching_strategy_list = ['exact', 'substring']
  " Useful if there's a lot of camel case items
  let g:completion_matching_ignore_case = 1
]]

vim.opt.splitright = true

-- ==============
-- customizations
-- ==============

-- able to use macOS terminal with 256 colors
vim.opt.termguicolors = false

-- tab expand/width
local TAB_WIDTH = 2
vim.opt.shiftwidth = TAB_WIDTH
vim.opt.softtabstop = TAB_WIDTH
vim.opt.tabstop = TAB_WIDTH
vim.opt.expandtab = true

-- search highlighting
vim.opt.hlsearch = true

-- do not cut/copy to clipboard
vim.opt.clipboard = nil

-- set to 256 supported color scheme if not in gui mode
if vim.fn.has('gui_running') == 0 then
  vim.cmd.colorscheme('desert')
  -- must set hightlight after colorscheme
  -- to show DiagnosticError: <leader><space>
  vim.cmd.highlight('debugPC', 'ctermfg=50')
  vim.cmd.highlight('DiagnosticError', 'ctermfg=202') -- orange red or 208 orange
  vim.cmd.highlight('Pmenu', 'ctermbg=238') -- set background panel menu
end

-- increase time for syntax highlighting
vim.opt.redrawtime = 5000

-- vim.api.nvim_set_hl(0, 'debugPC', {
--   cterm = 'reverse',
--   ctermfg = 3,
--   gui = 'reverse',
--   guifg = '#666666',
-- })

-- load ./custom/core/mappings.lua:general
require("custom.core.utils").load_mappings()
