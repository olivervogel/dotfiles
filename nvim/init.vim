set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
source $HOME/.config/nvim/vim-plug/plugins.vim

lua <<EOF
require("nvim-treesitter.configs").setup {
    highlight = { enable = true },
}
vim.cmd 'colorscheme material'
EOF
