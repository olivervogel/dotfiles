-- no arrow keys
vim.api.nvim_set_keymap('', '<Up>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('', '<Down>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('', '<Left >', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('', '<Up>', '<Nop>', { noremap = true })

-- set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- save with <leader>w
vim.api.nvim_set_keymap('', '<leader>w', ':w<cr>', { noremap = true })

-- remaping for german keyboard
vim.api.nvim_set_keymap('n', '^', '`', { noremap = true })
vim.api.nvim_set_keymap('n', '&', '^', { noremap = true })

-- fold toggle mapping
vim.api.nvim_set_keymap('n', 'zu', 'za', { noremap = true })
vim.api.nvim_set_keymap('o', 'zu', '<C-C>za', { noremap = true })
vim.api.nvim_set_keymap('v', 'zu', 'zf', { noremap = true })

-- alt+j (mac) to move line up
vim.api.nvim_set_keymap('n', 'º', ':m .+1<cr>==', { noremap = true })
vim.api.nvim_set_keymap('n', '<a-j>', ':m .+1<cr>==', { noremap = true })

-- alt+k (mac) to move line down
vim.api.nvim_set_keymap('n', '∆', ':m .-2<cr>==', { noremap = true })
vim.api.nvim_set_keymap('n', '<a-k>', ':m .-2<cr>==', { noremap = true })

-- switch buffers with tab & shift+tab
vim.api.nvim_set_keymap('', '<tab>', ':bnext<cr>', { noremap = true })
vim.api.nvim_set_keymap('', '<s-tab>', ':bprevious<cr>', { noremap = true })
vim.api.nvim_set_keymap('', '<a-tab>', ':bprevious<cr>', { noremap = true })

-- yank into system clipboard
vim.api.nvim_set_keymap('v', '<c-c>', '"+y"', { noremap = true })

-- deselect search
vim.api.nvim_set_keymap('', '<leader><leader>', ':nohl<cr>', { noremap = true })

-- search and replace current cursor position
vim.api.nvim_set_keymap('n', '<leader>sc', 'yiw:%s/<c-r>0//g<left><left>', {})
vim.api.nvim_set_keymap('n', '<leader>ss', ':%s//g<Left><Left>', {})
vim.api.nvim_set_keymap('n', '<leader>sl', 'yiw:s/<c-r>0//g<Left><Left>', {})

-- scroll up/down with backspace/enter
vim.api.nvim_set_keymap('n', '<cr>', '<c-d>', { noremap = true })
vim.api.nvim_set_keymap('n', '<bs>', '<c-u>', { noremap = true })

-- navigate back changelist (back with alt-backspace. forward with alt-enter)
vim.api.nvim_set_keymap('n', '<m-bs>', 'g;zz', { noremap = true })
vim.api.nvim_set_keymap('n', '…', 'g,zz', { noremap = true })

-- navigation to next/prev function with alt-#/alt-plus
vim.api.nvim_set_keymap('n', '‘', ']mzz', { noremap = true })
vim.api.nvim_set_keymap('n', '±', '[mzz', { noremap = true })

-- repeat last command line command
vim.api.nvim_set_keymap('n', '<leader>zz', '@:', { noremap = true })

-- qq to record, Q to replay
vim.api.nvim_set_keymap('n', 'Q', '@q', { noremap = true })

-- autocenter while jumping to search results
vim.api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true })

-- keep visual mode active after indenting
vim.api.nvim_set_keymap('v', '>', '>gv', {})
vim.api.nvim_set_keymap('v', '<', '<gv', {})

-- switch to next item in quickfix list (option-shift-[.])
vim.api.nvim_set_keymap('n', '÷', ':cnext<cr>', { noremap = true, silent = true })
-- switch to prev. item in quickfix list (option-shift-[,])
vim.api.nvim_set_keymap('n', '˛', ':cprev<cr>', { noremap = true, silent = true })

-- reload file to saved state
vim.api.nvim_set_keymap('n', '<f5>', ':e!<cr>', { noremap = true, silent = true })

-- delete buffer (option-shift-[w])
vim.api.nvim_set_keymap('n', '„', ':bd<cr>', { noremap = true, silent = true })

-- add semicolor to end of line (option-shift-a)
vim.api.nvim_set_keymap('n', 'Å', 'A;<esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'Å', '<esc>A;<esc>', { noremap = true, silent = true })

-- mappings to run commands in certain tmux panes
vim.api.nvim_set_keymap('n', '<leader>bd', '!tmux send -t 1 "wide build" Enter<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rt', '!tmux send -t 1 "docker-compose run tests" Enter<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ra', '!tmux send -t 1 "docker-compose run analysis" Enter<cr>', { noremap = true, silent = true })
-- nnoremap <silent> <leader>bl :silent exe "!tmux send -t 1 'git blame % -L " . eval(line('.')) . "," . eval(line('.')) . "' Enter"<cr>

-- todo: translate to lua
vim.cmd [[
" :W should behave the same way as :w
command -bar -nargs=* -complete=file -range=% -bang Write <line1>,<line2>write<bang> <args>

" :Q should behave the same way as :q
command! Q :q
]]

-- toggle quickfix list
function toggle_quickfix_list()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
        if win["quickfix"] == 1 then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
end

-- bind toggle quickfix list (option-shift-[-])
vim.api.nvim_set_keymap('n', '—', [[:lua toggle_quickfix_list()<cr>]], { noremap = true, silent = true })
