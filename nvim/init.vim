set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source $HOME/.config/nvim/vim-plug/plugins.vim
source ~/.vimrc

lua <<EOF
require("nvim-treesitter.configs").setup {
    highlight = { enable = true },
}

vim.cmd 'colorscheme material'

require("toggleterm").setup{
    open_mapping = [[<c-space>]],
    direction = 'horizontal',
    size = 20
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
