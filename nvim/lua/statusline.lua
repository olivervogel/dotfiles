-- statusline setup
vim.opt.statusline = " "
vim.opt.statusline:append("%f") -- full file path
vim.opt.statusline:append(" ")
vim.opt.statusline:append("%=") -- align right
vim.opt.statusline:append("%-5(%p%%%)") -- percentual position in buffer
vim.opt.statusline:append("%-5(%l:%c%)") -- line & column number
vim.opt.statusline:append("%8{(&fenc!=''?&fenc:&enc)} (%{&ff})") -- encoding
vim.opt.statusline:append(" ")
