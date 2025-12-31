return {
   "akinsho/bufferline.nvim",
   version = "^4.7",
   lazy = false,
   opts = {
      options = {
         show_buffer_close_icons = false,
         show_close_icon = false,
         show_tab_indicators = false,
         sort_by = "id",
         persist_buffer_sort = false,
         numbers = "ordinal"
      }
   },
   keys = {
      { "<leader>1", function() require("bufferline").go_to(1, true) end, desc = "Go to buffer 1" },
      { "<leader>2", function() require("bufferline").go_to(2, true) end, desc = "Go to buffer 2" },
      { "<leader>3", function() require("bufferline").go_to(3, true) end, desc = "Go to buffer 3" },
      { "<leader>4", function() require("bufferline").go_to(4, true) end, desc = "Go to buffer 4" },
      { "<leader>5", function() require("bufferline").go_to(5, true) end, desc = "Go to buffer 5" },
      { "<leader>6", function() require("bufferline").go_to(6, true) end, desc = "Go to buffer 6" },
      { "<leader>7", function() require("bufferline").go_to(7, true) end, desc = "Go to buffer 7" },
      { "<leader>8", function() require("bufferline").go_to(8, true) end, desc = "Go to buffer 8" },
      { "<leader>9", function() require("bufferline").go_to(9, true) end, desc = "Go to buffer 9" },
      { "<leader>0", function() require("bufferline").go_to(10, true) end, desc = "Go to buffer 10" },
   }
}
