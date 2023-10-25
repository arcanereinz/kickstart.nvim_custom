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

-- vim.api.nvim_set_keymap('n', '<Leader>rr', '<Plug>DBUI_ToggleResultLayout', { noremap = true })
-- vim.api.nvim_set_keymap("n", "<Plug>DBUI_ToggleResultLayout", ":lua require('rest-nvim').run()<CR>", { noremap = true})

-- use buffers instead of tabs due to plugin: romgrk/barbar.nvim
-- vim.api.nvim_set_keymap('n', 'gt', '<cmd>bnext<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', 'gT', '<cmd>bprev<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>dw', '<Plug>(DBUI_SaveQuery)', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>E', '<Plug>(DBUI_EditBindParameters)', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<Leader>S', '<Plug>(DBUI_ExecuteQuery)', { noremap = true })
-- vim.api.nvim_set_keymap('v', '<Leader>S', '<Plug>(DBUI_ExecuteQuery)', { noremap = true })

-- ================== --
-- neovide neovim gui --
-- ================== --
-- shorted cursor animation (set to 0 for disable)
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.005
end

-- ===================== --
-- vim-dadbod-completion --
-- ===================== --
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

-- kristijanhusak/vim-dadbod-ui: auto expand for DBUI
-- vim.cmd [[
--   autocmd User DBUIOpened call s:open_db()
-- 
--   function! s:open_db()
--     "Find db.
--     call search('dev')
--     "Open db
--     norm o
--     "Find tables
--     call search('Tables')
--     "Open tables
--     norm o
--   endfunction
-- ]]

-- ========= --
-- rest.nvim --
-- ========= --
-- rest.nvim key bindings [NOTE: rename file extension to .http for this to work]
-- https://www.reddit.com/r/neovim/comments/n6cdnl/my_first_neovim_plugin_restnvim/
-- NOTE: add below content to file: ~/.config/nvim/ftdetect/http.vim

-- map <leader>rr to http rest request
-- autocmd BufRead,BufNewFile *.http		set filetype=http
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--   pattern = {"*.http"},
--   callback = function(_) -- ev
--     vim.opt.filetype = 'http'
--   end
-- })

-- keybindings for rest.nvim
vim.api.nvim_set_keymap('n', '<Plug>RestNvim', ':lua require("rest-nvim").run()<CR>', { noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>rr', '<Plug>RestNvim<CR><C-W>W<C-W>W', { noremap = true })
vim.opt.splitright = true

-- ============== --
-- customizations --
-- ============== --

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
end

-- load ./custom/core/mappings.lua:general
require("custom.core.utils").load_mappings()
