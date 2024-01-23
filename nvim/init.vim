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
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " theme
    Plug 'EdenEast/nightfox.nvim'

    " bufferline
    Plug 'akinsho/bufferline.nvim'

    " snippets
    Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.0.0', 'do': 'make install_jsregexp'}

    " code commenting
    Plug 'numToStr/Comment.nvim'

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

    " splitting/joining blocks of code
    Plug 'Wansmer/treesj'

    " surround selections (ys, ds, cs)
    Plug 'kylechui/nvim-surround'

    " auto closing of quotes
    Plug 'Raimondi/delimitMate'

    " seamless navigation between vim & tmux
    Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" -----------------------------------------------------------------------------
" file types 
" -----------------------------------------------------------------------------

" syntax needs to be on for php files to keep indentation correct
au BufRead,BufNewFile *.php set syntax=on

" Makefiles need tab indentation
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" Laravel templates
au BufRead,BufNewFile *.blade.php set filetype=html.blade
au BufRead,BufNewFile *.blade.php set syntax=html

" Silverstripe templates
au BufRead,BufNewFile *.ss set filetype=html.silverstripe
au BufRead,BufNewFile *.ss set syntax=html

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
set foldmethod=manual
set foldlevel=10

" fold toggle mapping
nnoremap zu za
onoremap zu <C-C>za
vnoremap zu zf

nnoremap gL $
nnoremap gl ^

" colors & theme
syntax on
set termguicolors

lua << EOF
-- Theme setup
local Shade = require("nightfox.lib.shade")
require('nightfox').setup({
    options = {
        styles = {
            comments = "italic",
        },
    },
    palettes = {
        nightfox = {
            bg1 = "#27313F", -- main bg
            bg0 = "#1F2732", -- Dark bg (status line and float)
            bg2 = "#252F3C", -- Lighter bg (colorcolm folds)
            bg3 = "#2D3848", -- Lighter bg (cursor line)
            bg4 = "#43556A", -- Conceal, border fg

            comment = "#42586E",
            white   = { base = "#B4BDC3", bright = "#EEF0F1", dim = "#7D8C97" },
            blue   = { base = "#4A8AEA", bright = "#86AADF", dim = "#5978A6" },
            magenta = Shade.new("#1A6BE5", 0, 0),
            orange   = { base = "#D88142", bright = "#EFC9AF", dim = "#965E36" },
            yellow    = { base = "#C6A339", bright = "#E4CB81", dim = "#8F7A3D" },
            green    = { base = "#8AA88A", bright = "#BDDBBD", dim = "#6A7A6A" },
            red    = { base = "#D65C5C", bright = "#EF9090", dim = "#A65A5A" },

            sel0 = "#313E4D",
            sel1 = "#3C4B5D",

            pink    = Shade.new("#f7cd7a", 0, 0),
            cyan    = { base = "#6994FF", bright = "#A4BEFF", dim = "#7895DE" },
            black   = Shade.new("#000000", 0.15, -0.15),

        }
    },
    specs = {
        nightfox = {
            syntax = {
                type        = "white", -- FooController, public
                builtin0    = "blue.bright", -- this, return
                builtin1    = "white", -- Illuminate
                keyword     = "blue.bright", -- class, extends
                bracket     = "white.dim",
                comment     = "comment",
                func        = "blue",
                preproc     = "blue.bright", -- use
                string      = "green",
                variable    = "blue.bright",
                conditional = "magenta",
                number      = "orange",

                const       = "white",
                operator    = "blue.dim",
                ident       = "magenta", --[[ Exception, self ]]

                builtin2    = "white",
                builtin3    = "white",
                field       = "white",
                regex       = "white",
                statement   = "white",
                dep         = "white",
            }
        }
    },
    groups = {
        nightfox = {
            LineNr = { fg = "palette.comment" },
            CursorLineNr = { fg = "palette.white.dim" },
            Normal = { fg = "palette.white" },
            NormalFloat = { bg = "#1E262F" },
            NormalNC = { bg = "#222B35" },
            EndOfBuffer = { fg = "palette.comment" },
            TelescopeNormal = { bg = "#1f242c", fg = "palette.white" },
            TelescopeBorder = { bg = "#1f242c" },

            Search = { bg = "palette.white.dim", fg = "palette.bg1" },
            IncSearch = { bg = "palette.white.bright", fg = "palette.bg1" },
            StatusLine = { bg = "palette.bg0", fg = "#3B4B5F" },
            WildMenu = { bg = "palette.bg0", fg = "#3B4B5F" },
            Todo = { bg = "none" },

            ["@type"] = { fg = "palette.magenta" }, -- FooController
            ["@type.builtin"] = { fg = "palette.magenta" }, -- string, array
            ["@type.definition"] = { fg = "palette.magenta" }, -- as SpecialType
            ["@property"] = { fg = "palette.blue" }, -- protected $test, $this->test

            ["@storageclass"] = { fg = "palette.white" }, -- visibility/life-time/etc. modifiers (e.g. `static`)
            ["@attribute"] = { fg = "palette.white" }, -- attribute annotations (e.g. Python decorators)
            ["@field"] = { fg = "palette.white" }, -- For fields.

            ["@constant"] = { fg = "palette.blue.bright" }, -- For constants
            ["@constant.builtin"] = { fg = "palette.magenta" }, -- For constant that are built in the language: nil in Lua.

            ["@namespace"] = { fg = "palette.yellow" }, -- For identifiers referring to modules and namespaces.
            ["@symbol"] = { fg = "palette.green" },

            ["@method"] = { fg = "palette.blue" }, -- For method calls and definitions.
            ["@exception"] = { fg = "palette.blue" },
            ["@function.builtin"] = { fg = "palette.blue" },

            ["@punctuation.delimiter"] = { fg = "palette.white.dim" }, -- For delimiters ie: semicolon
            ["@punctuation.bracket"] = { fg = "palette.blue.dim" }, -- For brackets and parenthesis.
            ["@boolean"] = { fg = "palette.orange" },
        }
    }
})
EOF

colorscheme nightfox

" search down into subfolders but ignore certain folders
set path+=**
set wildignore+=**/node_modules/** 

" display all matching files on tab completion
set wildmenu

" define leader
let mapleader="\<space>"

" remaping for german keyboard
nnoremap ^ `
nnoremap & ^

filetype plugin indent on

" hidden buffers
set hidden

" delete buffer and keep split with :Bd
command Bd bp\|bd \#

" disable swapfile
set noswapfile

"search will be case-sensitive if it contains an uppercase letter
set ignorecase
set smartcase

" tab settings
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=0
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

" qq to record, Q to replay
nnoremap Q @q

" autocenter while jumping to search results
nnoremap n nzz
nnoremap N Nzz

" autocompletion
set completeopt=menu,menuone
set pumheight=10

" select with enter key when completion menu is open
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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

lua << EOF
-- disable mouse
vim.opt.mouse = ""

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})
EOF

" -----------------------------------------------------------------------------
" shortcuts & mappings
" -----------------------------------------------------------------------------

" navigate windows
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_preserve_zoom = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" navigate in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

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
nmap <Leader>sl yiw:s/<c-r>0//g<Left><Left>


" scroll up/down with backspace/enter
nnoremap <cr> <c-d>
nnoremap <bs> <c-u>

" navigate back changelist 
" back with alt-backspace
nnoremap <M-BS> g;
" forward with alt-enter which is mapped by terminal to special char
nnoremap … g,

" navigation to next/prev function with alt-#/alt-plus
nnoremap ‘ ]mzz
nnoremap ± [mzz

" repeat last command line command
nnoremap <Leader>zz @:

" :W should behave the same way as :w
command -bar -nargs=* -complete=file -range=% -bang Write <line1>,<line2>write<bang> <args>

" :Q should behave the same way as :q
command! Q :q

" -----------------------------------------------------------------------------
" statusline settings
" -----------------------------------------------------------------------------

set statusline=
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

" switch to buffers directly via bufferline
nnoremap <silent><leader>1 <cmd>lua require("bufferline").go_to_buffer(1, true)<cr>
nnoremap <silent><leader>2 <cmd>lua require("bufferline").go_to_buffer(2, true)<cr>
nnoremap <silent><leader>3 <cmd>lua require("bufferline").go_to_buffer(3, true)<cr>
nnoremap <silent><leader>4 <cmd>lua require("bufferline").go_to_buffer(4, true)<cr>
nnoremap <silent><leader>5 <cmd>lua require("bufferline").go_to_buffer(5, true)<cr>
nnoremap <silent><leader>6 <cmd>lua require("bufferline").go_to_buffer(6, true)<cr>
nnoremap <silent><leader>7 <cmd>lua require("bufferline").go_to_buffer(7, true)<cr>
nnoremap <silent><leader>8 <cmd>lua require("bufferline").go_to_buffer(8, true)<cr>
nnoremap <silent><leader>9 <cmd>lua require("bufferline").go_to_buffer(9, true)<cr>

" toggle quickfix list
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

" bind toggle quickfix list (option-shift-[-])
nnoremap <silent>— :call ToggleQuickFix()<cr>

" switch to next item in quickfix list (option-shift-[.])
nnoremap <silent>÷ :cnext<cr>
" switch to prev. item in quickfix list (option-shift-[,])
nnoremap <silent>˛ :cprev<cr>

" reload file to saved state
nnoremap <silent><F5> :e!<cr>

" delete buffer (option-shift-[w])
nnoremap <silent>„ :bd<cr>

" add semicolor to end of line (option-shift-a)
nnoremap <silent>Å A;<esc>
inoremap <silent>Å <esc>A;<esc>

" -----------------------------------------------------------------------------
" plugin settings
" -----------------------------------------------------------------------------
lua << EOF

-- Bufferline setup
require("bufferline").setup{
    options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        sort_by = "insert_at_end",
        numbers = "ordinal"
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
    on_attach = on_attach,
    settings = {
        intelephense = {
            stubs = {
                "ast",
                "bcmath",
                "bz2",
                "calendar",
                "Core",
                "crypto",
                "ctype",
                "curl",
                "date",
                "dba",
                "decimal",
                "dio",
                "dom",
                "ds",
                "eio",
                "enchant",
                "Ev",
                "event",
                "exif",
                "expect",
                "fann",
                "FFI",
                "ffmpeg",
                "fileinfo",
                "filter",
                "fpm",
                "ftp",
                "gd",
                "gearman",
                "geoip",
                "geos",
                "gettext",
                "gmagick",
                "gmp",
                "gnupg",
                "grpc",
                "hash",
                "http",
                "ibm_db2",
                "iconv",
                "igbinary",
                "imagick",
                "imap",
                "inotify",
                "interbase",
                "intl",
                "json",
                "judy",
                "ldap",
                "leveldb",
                "libevent",
                "libsodium",
                "libvirt-php",
                "libxml",
                "lua",
                "LuaSandbox",
                "lzf",
                "mailparse",
                "mapscript",
                "mbstring",
                "mcrypt",
                "memcache",
                "memcached",
                "meminfo",
                "meta",
                "ming",
                "mongo",
                "mongodb",
                "mosquitto-php",
                "mqseries",
                "msgpack",
                "mssql",
                "mysql",
                "mysql_xdevapi",
                "mysqli",
                "ncurses",
                "newrelic",
                "oauth",
                "oci8",
                "odbc",
                "openssl",
                "parallel",
                "Parle",
                "pcntl",
                "pcov",
                "pcre",
                "pdflib",
                "PDO",
                "pdo_ibm",
                "pdo_mysql",
                "pdo_pgsql",
                "pdo_sqlite",
                "pgsql",
                "Phar",
                "phpdbg",
                "posix",
                "pq",
                "pspell",
                "pthreads",
                "radius",
                "random",
                "rar",
                "rdkafka",
                "readline",
                "recode",
                "redis",
                "Reflection",
                "regex",
                "rpminfo",
                "rrd",
                "SaxonC",
                "session",
                "shmop",
                "simple_kafka_client",
                "SimpleXML",
                "snappy",
                "snmp",
                "soap",
                "sockets",
                "sodium",
                "solr",
                "SPL",
                "SplType",
                "SQLite",
                "sqlite3",
                "sqlsrv",
                "ssh2",
                "standard",
                "stats",
                "stomp",
                "suhosin",
                "superglobals",
                "svm",
                "svn",
                "swoole",
                "sybase",
                "sync",
                "sysvmsg",
                "sysvsem",
                "sysvshm",
                "tidy",
                "tokenizer",
                "uopz",
                "uploadprogress",
                "uuid",
                "uv",
                "v8js",
                "wddx",
                "win32service",
                "winbinder",
                "wincache",
                "wordpress",
                "xcache",
                "xdebug",
                "xdiff",
                "xhprof",
                "xlswriter",
                "xml",
                "xmlreader",
                "xmlrpc",
                "xmlwriter",
                "xsl",
                "xxtea",
                "yaf",
                "yaml",
                "yar",
                "zend",
                "Zend OPcache",
                "ZendCache",
                "ZendDebugger",
                "ZendUtils",
                "zip",
                "zlib",
                "zmq",
                "zookeeper",
                "zstd"
            }
        }
    }
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

-- telescope: ignore large files in preview
local previewers = require("telescope.previewers")
local previewers_utils = require('telescope.previewers.utils')
local preview_maker_ignore_large_files = function(filepath, bufnr, opts)
  opts = opts or {}
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then
        previewers_utils.job_maker({
            "echo",
            "Preview not available. File is too large.",
        }, bufnr, opts)
    else
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            ".DS_Store",
            "node_modules",
            "deps",
            "vendor",
            ".git/",
            ".vscode/",
            ".cache/",
            ".gitkeep",
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
        buffer_previewer_maker = preview_maker_ignore_large_files,
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
                "%.git",
                "%.DS_Store",
                "%.cache"
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
        "json",
        "html",
        "vue",
        "css",
        "scss",
        "markdown",
        "lua",
        "cpp"
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    indent = {
        enable = false
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "Ø", -- set to `false` to disable one of the mappings
            node_incremental = "Ø",
            scope_incremental = false,
            node_decremental = "Û",
        },
    },
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

-- ----------------------------------------------
-- snippet settings
-- ----------------------------------------------

local ls = require("luasnip")
local ls_types = require("luasnip.util.types")
local snippet_node = require("luasnip.nodes.snippet").S
local fmt = require("luasnip.extras.fmt").fmt

require("luasnip.loaders.from_lua").lazy_load({ 
    paths = { "~/.config/nvim/luasnip/snippets" }
})

ls.config.setup({
    history = false,
    enable_autosnippets = true,
    update_events = 'TextChanged,TextChangedI',
    ft_func = require("luasnip.extras.filetype_functions").from_pos_or_filetype,
    load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
        html = {"javascript", "php"}, -- also load javascript for html context
        vue = {"javascript", "html"}
    }),
    snip_env = {
        -- just copied because of https://github.com/L3MON4D3/LuaSnip/issues/566#issuecomment-1233022044
        sn = require("luasnip.nodes.snippet").SN,
        t = require("luasnip.nodes.textNode").T,
        f = require("luasnip.nodes.functionNode").F,
        i = require("luasnip.nodes.insertNode").I,
        c = require("luasnip.nodes.choiceNode").C,
        d = require("luasnip.nodes.dynamicNode").D,
        r = require("luasnip.nodes.restoreNode").R,
        l = require("luasnip.extras").lambda,
        rep = require("luasnip.extras").rep,
        p = require("luasnip.extras").partial,
        m = require("luasnip.extras").match,
        n = require("luasnip.extras").nonempty,
        dl = require("luasnip.extras").dynamic_lambda,
        fmt = require("luasnip.extras.fmt").fmt,
        fmta = require("luasnip.extras.fmt").fmta,
        conds = require("luasnip.extras.expand_conditions"),
        types = require("luasnip.util.types"),
        events = require("luasnip.util.events"),
        parse = require("luasnip.util.parser").parse_snippet,
        ai = require("luasnip.nodes.absolute_indexer"),
        -- custom below here
        trim = function(string)
            return string:match "^%s*(.-)%s*$"
        end,
        -- customize default behaviour of default node
        s = ls.extend_decorator.apply(snippet_node, {}, { 
            -- set default behaviour: snippets expand only if trigger word
            -- is the first word on the line or is preceded by one or more whitespace characters.
            -- Also snippets dont expand inside an active snippet
            condition = function(line_to_cursor, matched_trigger, captures)
                local trigger_pos, _ = string.find(line_to_cursor, matched_trigger)
                local char_before_trigger = string.sub(line_to_cursor, trigger_pos - 1, trigger_pos -1)
                return ls.in_snippet() == false and (char_before_trigger == " " or char_before_trigger == "")
            end
        }),
        -- create inline node
        s_inline = ls.extend_decorator.apply(snippet_node, {}, { 
            -- set inline behaviour: snippets expand everywhere but inside active snippets
            condition = function(line_to_cursor, matched_trigger, captures)
                return ls.in_snippet() == false
            end
        })
    },
    ext_opts = {
        [ls_types.snippet] = {
            active = {
                hl_group = "Comment",
            },
            passive = {
                hl_group = "Comment",
            },
            visited = {
                hl_group = "Comment",
            },
            unvisited = {
                hl_group = "Comment",
            },
        },
        [ls_types.choiceNode] = {
            active = {
                virt_text = {{"", "Variable"}}
            },
        }
    },
})

ls.filetype_extend("vue", {"html"})
ls.filetype_extend("zsh", {"sh"})

function maybe_leave_snippet()
    if
        (vim.v.event.new_mode == 'n')
        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require('luasnip').session.jump_active
    then
        require('luasnip').unlink_current()
    end
end

-- leave snippets when you leave to normal mode
vim.api.nvim_command([[
    autocmd ModeChanged * lua maybe_leave_snippet()
]])

-- ----------------------------------------------
-- nvim-cmp config
-- ----------------------------------------------
local cmp = require'cmp'

cmp.setup({
    completion = {
        -- autocomplete = false
        keyword_length = 2
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<cr>'] = cmp.mapping.confirm({ select = true }),
        ['<c-u>'] = cmp.mapping.scroll_docs(-4),
        ['<c-d>'] = cmp.mapping.scroll_docs(4),
        ["<c-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif ls.choice_active() then
                ls.change_choice(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<c-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif ls.choice_active() then
                ls.change_choice(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<c-space>'] = cmp.config.disable 
    }),
    sources = cmp.config.sources({
        {
            name = 'nvim_lsp'
        },
        {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    -- search all buffers
                    return vim.api.nvim_list_bufs()
                end
            }
        },
    }, {
    })
})

-- trees setup
local tsj = require('treesj')
local langs = {--[[ configuration for languages ]]}
tsj.setup({
  use_default_keymaps = false,
  check_syntax_error = true,
  max_join_length = 120,
  cursor_behavior = 'hold',
  notify = true,
  -- langs = lu._prepare_presets(langs.presets),
  dot_repeat = true,
})

vim.keymap.set('n', '<leader>m', tsj.toggle)
vim.keymap.set('n', '<leader>M', function()
    tsj.toggle({ split = { recursive = true } })
end)

-- nvim-surround setup
require("nvim-surround").setup({})

EOF

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
nnoremap <leader>fz :Telescope current_buffer_fuzzy_find<cr>
nnoremap <c-s> :Telescope file_browser path=%:p:h<cr>
nnoremap <c-f> :Telescope oldfiles<cr>

" mappings to run commands in certain tmux panes
nnoremap <silent> <leader>bd :silent !tmux send -t 1 'wide build' Enter<cr>
nnoremap <silent> <leader>rt :silent !tmux send -t 1 'docker-compose run --rm tests' Enter<cr>
nnoremap <silent> <leader>ra :silent !tmux send -t 1 'docker-compose run --rm analysis' Enter<cr>
nnoremap <silent> <leader>bl :silent exe "!tmux send -t 1 'git blame % -L " . eval(line('.')) . "," . eval(line('.')) . "' Enter"<cr>

" snippet mappings
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
