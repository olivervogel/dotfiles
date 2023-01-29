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

    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'tag': 'v0.7.2', 'do': ':TSUpdate'}

    " theme
    Plug 'marko-cerovac/material.nvim', {'commit': '88e1d132cc7b27a8304b897873384bee343b2d2c'}

    " bufferline
    Plug 'akinsho/bufferline.nvim'

    " snippets
    Plug 'SirVer/ultisnips'

    " code commenting
    Plug 'numToStr/Comment.nvim'

    " terminal inside vim
    Plug 'akinsho/toggleterm.nvim'

    " language server setup
    Plug 'neovim/nvim-lspconfig'

    " linter to display PSR issues
    Plug 'mfussenegger/nvim-lint'

    " telescope stack
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'

    " cmp stack
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'

    " easier html tag writing
    Plug 'tpope/vim-ragtag'

    " auto closing of quotes
    Plug 'Raimondi/delimitMate'

    " seamless navigation between vim & tmux
    Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" -----------------------------------------------------------------------------
" file types 
" -----------------------------------------------------------------------------

" *.heex should be handled as html
" au BufRead,BufNewFile *.heex set filetype=heex
au BufRead,BufNewFile *.heex set filetype=eelixir
au BufRead,BufNewFile *.heex set syntax=html
au FileType heex UltiSnipsAddFiletypes html

" *.vue should be handled as javascript
au BufRead,BufNewFile *.vue set filetype=javascript
au BufRead,BufNewFile *.vue set syntax=javascript

" *.blade should be handled as html
au BufRead,BufNewFile *.blade.php set filetype=html
au BufRead,BufNewFile *.blade.php set syntax=html

" -----------------------------------------------------------------------------
" base settings 
" -----------------------------------------------------------------------------

" no arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" lsp needs low updatetime in this config
set updatetime=1000

" code folding settings
set foldmethod=indent
set foldlevel=10

nnoremap zu za
onoremap zu <C-C>za
vnoremap zu zf

" colors & theme
syntax on
set termguicolors

lua << EOF
require('material').setup({
    contrast = {
        floating_windows = true,
        non_current_windows = true,
        line_numbers = true
    },
    disable = {
		borders = true
	},
})
EOF
let g:material_style = "oceanic"
colorscheme material

" search down into subfolders but ignore certain folders
set path+=**
set wildignore+=**/node_modules/** 

" display all matching files on tab completion
set wildmenu

" define leader
let mapleader="\<space>"

" remaping for german keyboard
set langmap=^`,&^

" set clipboard^=unnamed

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
" set smartindent

" turn on indenting for php
autocmd FileType php setlocal autoindent copyindent indentexpr=""

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

" qq to record, Q to replay
nnoremap Q @q

" autocenter while jumping to search results
nnoremap n nzz
nnoremap N Nzz

" autocompletion
" set omnifunc=syntaxcomplete#Complete
set completeopt=menu,menuone
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

" treat words with dash as whole word
set iskeyword+=-

lua << EOF
-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})
EOF

" -----------------------------------------------------------------------------
" commands and functions 
" -----------------------------------------------------------------------------

" close all buffers except current one
command! BufCurOnly execute '%bdelete|edit#|bdelete#'
nnoremap <c-b>o :BufCurOnly<cr>

" -----------------------------------------------------------------------------
" shortcuts & mappings
" -----------------------------------------------------------------------------

" navigate windows
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" alt+j (mac) to move line up
nnoremap º :m .+1<CR>==
nnoremap <A-j> :m .+1<CR>==

" alt+k (mac) to move line down
nnoremap ∆ :m .-2<CR>==
nnoremap <A-k> :m .-2<CR>==

" switch buffers with tab & shift+tab
noremap <tab> :bnext<cr>
noremap <S-tab> :bprevious<cr>
noremap <A-tab> :bprevious<cr>

" yank into system clipboard
vnoremap <C-c> "+y

" deselect search
noremap <leader><leader> :nohl<cr>

" search and replace current cursor position
nmap <Leader>sc yiw:%s/<c-r>0//g<Left><Left>
nmap <Leader>ss :%s//g<Left><Left>
nmap <Leader>sl :s//g<Left><Left>

" run current buffer as php script
autocmd FileType php noremap <leader>p :w!<cr>:!/opt/homebrew/bin/php %<cr>

" scroll up/down with backspace/enter
nnoremap <cr> <c-d>
nnoremap <bs> <c-u>

" repeat last command line command
nnoremap <Leader>zz @:

" :W should behave the same way as :w
command -bar -nargs=* -complete=file -range=% -bang Write <line1>,<line2>write<bang> <args>


" -----------------------------------------------------------------------------
" statusline settings
" -----------------------------------------------------------------------------

" define statusline color
hi User1 ctermfg=007 ctermbg=239 guibg=#304448 guifg=#647376

set statusline=
" set color
set statusline+=%1*
" add space
set statusline+=%(\ %)
" show full file path
set statusline+=%f
" add space
set statusline+=%(\ %)
" align right
set statusline+=%=
" percentual position in buffer
set statusline+=%-5(%p%%%)
" line & column number
set statusline+=%-5(%l:%c%)
" encoding
set statusline+=%8{(&fenc!=''?&fenc:&enc)}
set statusline+=\ (%{&ff})
" add space
set statusline+=%(\ %)

" -----------------------------------------------------------------------------
" plugin settings
" -----------------------------------------------------------------------------
lua << EOF

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
    direction = "float",
    shade_terminals = false,
    float_opts = {
        border = "none",
        width = 500,
        height = 500,
        highlights = {
            background = "Pmenu",
        }
    }
}

-- LSP Setup
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- set shortcuts for lsp commands
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>I', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

-- intelephense lsp
require('lspconfig').intelephense.setup {
    on_attach = on_attach
}

-- elixir lsp
require('lspconfig').elixirls.setup {
    cmd = {"/Users/oliver/elixir-ls/language_server.sh"},
    on_attach = on_attach
}

-- LSP diagnostic config
vim.diagnostic.config({
    severity_sort = true,
    signs = {
        -- severity = 1
    },
    underline = false,
    virtual_text = false
})

-- print diagnostic info in message area
-- function PrintDiagnostics(opts, bufnr, line_nr, client_id)
--     bufnr = bufnr or 0
--     line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
--     opts = opts or {['lnum'] = line_nr}
--
--     local line_diagnostics = vim.diagnostic.get(bufnr, opts)
--     if vim.tbl_isempty(line_diagnostics) then return end
--     local diagnostic_message = ""
--     for i, diagnostic in ipairs(line_diagnostics) do
--         if i == 1 then
--             diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
--             print(diagnostic_message)
--         end
--     end
--     vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
-- end
-- vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]

-- show diagnostic warning with line highlighting instead of symbol
vim.cmd [[
    highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
    highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
    highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
    highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]

-- telescope settings
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            ".DS_Store",
            "node_modules",
            "deps",
            ".git/",
            ".vscode/",
            ".cache/",
            "priv/static/assets/",
            ".gitkeep",
            ".elixir_ls",
            "_build"
        },
        vimgrep_arguments = {
            'rg',
            '--hidden',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '-u'
        },
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
    },
    extensions = {
        file_browser = {
            file_ignore_patterns = {
                ".git",
                ".elixir_ls",
                ".DS_Store",
                ".cache"
            },
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
            }
        }
    }

require("telescope").load_extension "file_browser"

-- treesitter config
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "vim",
        "php",
        "javascript",
        "typescript",
        "html",
        "vue",
        "css",
        "scss",
        "markdown",
        "erlang",
        "elixir",
        "heex",
        "lua"
    },
    highlight = {
        enable = true,
    }
}

-- linting settings
require('lint').linters_by_ft = {
    php = {'phpcs'}
}
vim.cmd([[ au BufRead * lua require('lint').try_lint() ]])
vim.cmd([[ au TextChanged * lua require('lint').try_lint() ]])
vim.cmd([[ au InsertLeave * lua require('lint').try_lint() ]])
-- vim.cmd([[ au BufWritePost * lua require('lint').try_lint() ]])

local phpcs = require('lint.linters.phpcs')
phpcs.args = {
    '-q',
    '--standard=psr12',
    '--report=json',
    '-'
}

-- enable numToStr/Comment plugin
require('Comment').setup()

-- nvim-cmp config
local cmp = require'cmp'

cmp.setup({
    completion = {
        autocomplete = false
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<c-space>'] = cmp.mapping.complete(),
        ['<cr>'] = cmp.mapping.confirm({ select = true }),
        ["<c-j>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item()
            end
        end, { "i", "s" }),
        ["<c-k>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, { "i", "s" }),
        ["<c-space>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item()
            else
                cmp.complete()
            end
        end, { "i", "s" }),
        ['<c-u>'] = cmp.mapping.scroll_docs(-4),
        ['<c-d>'] = cmp.mapping.scroll_docs(4),
        ['<esc>'] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' },
    })
})
EOF

" snippet settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-c>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.dotfiles/nvim/ultisnips']

" telescope settings
nnoremap <c-p> :Telescope find_files hidden=true<cr>
nnoremap <a-r> :Telescope lsp_document_symbols<cr>
nnoremap ® :Telescope lsp_document_symbols<cr>
nnoremap <leader>ff :Telescope find_files hidden=true<cr>

" telescope (f)ind (s)tring
nnoremap <leader>fs :Telescope live_grep<cr>

" telescope (f)ind string under (c)ursor
nnoremap <leader>fc :Telescope grep_string<cr>

nnoremap <leader>fb :Telescope buffers<cr>
nnoremap <leader>fh :Telescope help_tags<cr>
nnoremap <leader>gs :Telescope git_status<cr>
nnoremap <leader>fr :Telescope resume<cr>
nnoremap <leader>fq :Telescope quickfix<cr>
nnoremap <leader>fm :Telescope marks<cr>
nnoremap <c-s> :Telescope file_browser path=%:p:h<cr>
nnoremap <c-f> :Telescope oldfiles<cr>
