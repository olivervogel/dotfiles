set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source $HOME/.config/nvim/vim-plug/plugins.vim
source ~/.vimrc

set background=light
colorscheme solarized8

lua <<EOF
--  require("nvim-treesitter.configs").setup {
--      highlight = { enable = true },
--  }

-- local opts = { noremap=true, silent=true }
-- vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- local on_attach = function(client, bufnr)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- end

-- require'lspconfig'.intelephense.setup{
--     on_attach = on_attach
-- }

-- vim.cmd 'colorscheme OceanicNext'

-- require('neoscroll').setup({})
-- 
-- local t = {}
-- t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '90', [['sine']]}}
-- t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '90', [['sine']]}}
-- t['<C-k>'] = {'scroll', {'-vim.wo.scroll', 'true', '90', [['sine']]}}
-- t['<C-j>'] = {'scroll', { 'vim.wo.scroll', 'true', '90', [['sine']]}}
-- t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '250'}}
-- t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '250'}}
-- t['zz']    = {'zz', {'90'}}
-- t['zt']    = {'zt', {'90'}}
-- t['zb']    = {'zb', {'90'}}
-- 
-- require('neoscroll.config').set_mappings(t)

require("toggleterm").setup{
    open_mapping = [[<f1>]],
    direction = 'horizontal',
    size = 40,
    shade_terminals = true
}

require("bufferline").setup{
    options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false
    }
}

EOF
