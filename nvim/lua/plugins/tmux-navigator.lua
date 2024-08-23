return {
    "christoomey/vim-tmux-navigator",
    keys = {
        { "<c-h>", ":TmuxNavigateLeft<cr>", desc = "tmux left" },
        { "<c-j>", ":TmuxNavigateDown<cr>", desc = "tmux down" },
        { "<c-k>", ":TmuxNavigateUp<cr>", desc = "tmux up" },
        { "<c-l>", ":TmuxNavigateRight<cr>", desc = "tmux right" },
    },
    init = function()
        vim.g.tmux_navigator_no_mappings = 1
        vim.g.tmux_navigator_preserve_zoom = 1
    end
}
