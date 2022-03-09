" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall
    "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " material theme
    Plug 'marko-cerovac/material.nvim'

    " phpactor
    Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
    
    " terminal inside vim
    Plug 'akinsho/toggleterm.nvim'
    
    " snippets
    Plug 'SirVer/ultisnips'

    " ale for linting
    Plug 'dense-analysis/ale'

    " nerdtree
    Plug 'preservim/nerdtree'
    
    " comments
    Plug 'tpope/vim-commentary'
    
    " fzf
    Plug '~/.zsh/pack/fzf'

    " shade
    Plug 'sunjon/shade.nvim'

call plug#end()
