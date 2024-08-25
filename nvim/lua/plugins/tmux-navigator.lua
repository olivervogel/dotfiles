return {
    "christoomey/vim-tmux-navigator",
    keys = {
        { "<c-h>", ":TmuxNavigateLeft<cr>", desc = "tmux left", silent = true },
        { "<c-j>", ":TmuxNavigateDown<cr>", desc = "tmux down", silent = true },
        { "<c-k>", ":TmuxNavigateUp<cr>", desc = "tmux up", silent = true },
        { "<c-l>", ":TmuxNavigateRight<cr>", desc = "tmux right", silent = true },
    },
    init = function()
        vim.g.tmux_navigator_no_mappings = 1
        vim.g.tmux_navigator_preserve_zoom = 1
    end
}
