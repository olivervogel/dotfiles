set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source $HOME/.config/nvim/vim-plug/plugins.vim
source ~/.vimrc

lua <<EOF
require("nvim-treesitter.configs").setup {
    highlight = { enable = true },
}
vim.cmd 'colorscheme material'
EOF
