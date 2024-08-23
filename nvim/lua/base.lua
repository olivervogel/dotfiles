-- code folding settings
vim.opt.foldmethod = "manual"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4
vim.opt.foldtext = ""

-- search down into subfolders
vim.opt.path:append "**"

-- display all matching files on tab completion
vim.opt.wildmenu = true

-- hidden buffers
vim.opt.hidden = true

-- disable swapfile
vim.opt.swapfile = false

-- search will be case-sensitive if it contains an uppercase letter
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- tab settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0
vim.opt.autoindent = true
vim.opt.copyindent = true

-- set column rulers
vim.opt.colorcolumn = "80,120"

-- relative/hybrid line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.rnu = true

-- open splits below/right current buffer
vim.opt.splitright = true
vim.opt.splitbelow = true

-- highlight current line
vim.opt.cursorline = true

-- autocompletion
vim.opt.completeopt = "menu,menuone"
vim.opt.pumheight = 10

-- hide explore banner
vim.g.netrw_banner = 0

-- disable mouse
vim.opt.mouse = ""
