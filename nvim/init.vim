" -----------------------------------------------------------------------------
" auto-install vim-plug
" -----------------------------------------------------------------------------
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall
    "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" -----------------------------------------------------------------------------
" plugins
" -----------------------------------------------------------------------------
call plug#begin('~/.config/nvim/autoload/plugged')

    " theme
    Plug 'mhartington/oceanic-next'
    Plug 'lifepillar/vim-solarized8'

    " bufferline
    Plug 'akinsho/bufferline.nvim'

    " snippets
    Plug 'SirVer/ultisnips'

    " terminal inside vim
    Plug 'akinsho/toggleterm.nvim'

    Plug 'jiangmiao/auto-pairs'

    Plug 'neovim/nvim-lspconfig'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'

call plug#end()

" -----------------------------------------------------------------------------
" plugin settings
" -----------------------------------------------------------------------------
lua <<EOF

-- Bufferline setup
require("bufferline").setup{
    options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false
    }
}

--  Toggleterm setup
require("toggleterm").setup{
    open_mapping = [[<f1>]],
    direction = 'horizontal',
    size = 40,
    shade_terminals = true
}

-- LSP Setup
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = false,
        underline = false,
        virtual_text = {
            spacing = 4,
        }
    }
)

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>I', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

require'lspconfig'.intelephense.setup{
    on_attach = on_attach
}

local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        layout_config = {
            width = 0.9,
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-p>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
            },
            n = {
                ["<C-p>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
            }
        }
    }
}

require('telescope').setup({
    extensions = {
        file_browser = {
            hidden = true,
            grouped = true,
            sorting_strategy = 'ascending',
            mappings = {
                i = {
                    ["<C-s>"] = actions.close,
                },
                n = {
                    ["<C-s>"] = actions.close,
                }
            }
        },
    },
})

require("telescope").load_extension "file_browser"

EOF
 
" snippet settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-c>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.dotfiles/nvim/ultisnips']

" telescope settings
nnoremap <c-p> <cmd>Telescope find_files<cr>
nnoremap <a-r> <cmd>Telescope lsp_document_symbols<cr>
nnoremap ® <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>fr <cmd>Telescope resume<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>

" -----------------------------------------------------------------------------
" base settings 
" -----------------------------------------------------------------------------

" no arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" colors & theme
syntax on
set termguicolors
set background=dark
colorscheme OceanicNext

" this 'fixes' the toggleterm background in a strange and unknown way
highlight xxx ctermbg=0

" search down into subfolders but ignore certain folders
set path+=**
set wildignore+=**/node_modules/** 

" display all matching files on tab completion
set wildmenu

" define leader
let mapleader=" "

" remaping for german keyboard
" set langmap=^`,#',ö\\;,&^
set langmap=^`,&^
" noremap öö :normal [[<cr>
" noremap ää :normal ]]<cr>

set clipboard^=unnamed

filetype plugin indent on

set hidden
set noswapfile

"search will be case-sensitive if it contains an uppercase letter
set ignorecase
set smartcase

" tab settings
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set copyindent

" set column rulers
set colorcolumn=80,120

" relative/hybrid line numbers
set number relativenumber
set nu rnu

" open splits below/right current buffer
set splitright
set splitbelow

" highlight current line
set cursorline

" scroll offset
set scrolloff=4

" qq to record, Q to replay
nnoremap Q @q

" autocenter while jumping to search results
nnoremap n nzz
nnoremap N Nzz

" autocompletion
" set omnifunc=syntaxcomplete#Complete
set completeopt=menu
set pumheight=10

" select with enter key when completion menu is open
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" cycle popup with c-space or j or k
inoremap <expr> j pumvisible() ? "\<c-n>" : "j"
inoremap <expr> k pumvisible() ? "\<c-p>" : "k"

" keep visual mode active after indenting
vmap > >gv
vmap < <gv

" show help always in vertical split
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

" hide explore banner
let g:netrw_banner=0

" -----------------------------------------------------------------------------
" shortcuts 
" -----------------------------------------------------------------------------

" navigate windows
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k

" alt+j (mac) to move line up
nnoremap º :m .+1<CR>==
nnoremap <A-j> :m .+1<CR>==

" alt+k (mac) to move line down
nnoremap ∆ :m .-2<CR>==
nnoremap <A-k> :m .-2<CR>==

" switch buffers with tab & shift+tab
noremap <tab> :bnext<cr>
noremap <s-tab> :bprevious<cr>

" open file browser
map <c-s> :Telescope file_browser<cr>
" autocmd BufEnter * map <c-s> :Explore<cr>
