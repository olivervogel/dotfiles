return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    main = "nvim-treesitter.configs",
    opts = {
        ensure_installed = {
            "vim",
            "vimdoc",
            "query",
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
            "cpp",
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
        }
    }
}
