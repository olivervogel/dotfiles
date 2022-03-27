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
    
    " theme
    " Plug 'mhartington/oceanic-next'
    Plug 'lifepillar/vim-solarized8'

    " ncm
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-cssomni'
    Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}
    Plug 'fgrsnau/ncm2-otherbuf'

    " phpactor
    Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
    Plug 'phpactor/ncm2-phpactor'
    
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

    " bufferline
    Plug 'akinsho/bufferline.nvim'
    
    Plug 'junegunn/vim-slash'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'

call plug#end()
