return {
   "Wansmer/treesj",
   opts = {
      use_default_keymaps = false,
      check_syntax_error = true,
      max_join_length = 120,
      cursor_behavior = 'hold',
      notify = true,
      dot_repeat = true,
   },
   keys = {
      { "<leader>m", function() require("treesj").toggle() end },
      { "<leader>M", function() require("treesj").toggle({ split = { recursive = true } }) end },
   }
}
