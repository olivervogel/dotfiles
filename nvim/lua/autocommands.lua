-- restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})

-- syntax needs to be on for php files to keep indentation correct
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.php" },
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "php")
        vim.api.nvim_buf_set_option(buf, "syntax", "on")
    end,
})

-- Makefiles need tab indentation
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "make" },
    callback = function()
        vim.opt.expandtab = false
        vim.opt.shiftwidth = 8
        vim.opt.softtabstop = 0
    end,
})

-- Laravel templates
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.blade.php" },
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "html.blade")
        vim.api.nvim_buf_set_option(buf, "syntax", "html")
    end,
})

-- Silverstripe templates
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.ss" },
    callback = function()
        vim.api.nvim_buf_set_option(buf, "filetype", "html.silverstripe")
        vim.api.nvim_buf_set_option(buf, "syntax", "html")
    end,
})

-- show help always in vertical split
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.txt" },
    callback = function()
        if vim.bo.buftype == "help" then
            vim.cmd[[wincmd L]]
        end
    end,
})
