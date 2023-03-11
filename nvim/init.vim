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
    Plug 'marko-cerovac/material.nvim'

    " bufferline
    Plug 'akinsho/bufferline.nvim'

    " snippets
    Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.1.0', 'do': 'make install_jsregexp'}

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

" *.vue should be handled as html
au BufRead,BufNewFile *.vue set filetype=html
au BufRead,BufNewFile *.vue set syntax=html

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
set foldmethod=manual
set foldlevel=10

" fold toggle mapping
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
        borders = true,
    },
    high_visibility = {
        lighter = false,
        darker = false,
    },
    styles = {
        comments = {
            italic = true,
            bold = false
        }
    },
    plugins = {
       "nvim-cmp",
       "telescope",
    },
    custom_colors = function(colors)
        colors.editor.disabled = "#2e464b"
        colors.backgrounds.floating_windows = "#162326"
    end
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    command = "normal zx",
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

" navigate back changelist 
" back with alt-backspace
nnoremap <M-BS> g;
" forward with alt-enter which is mapped by iterm to special char
nnoremap … g,

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
    shade_terminals = true,
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
            "vendor",
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
        ['<c-n>'] = {
            i = cmp.config.disable
        },
        ['<c-p>'] = {
            i = cmp.config.disable
        }
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' },
    })
})

-- snippet settings
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
        elixir = {"heex"},
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

ls.filetype_extend("heex", {"html"})

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
nnoremap <c-s> :Telescope file_browser path=%:p:h<cr>
nnoremap <c-f> :Telescope oldfiles<cr>

" snippet mappings
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes
imap <silent><expr> <C-n> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-n>'
smap <silent><expr> <C-n> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-n>'
imap <silent><expr> <C-p> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-p>'
smap <silent><expr> <C-p> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-p>'
