return {
   "mfussenegger/nvim-lint",
   event = { "BufReadPre", "BufNewFile" },
   config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
         php = { "phpcs" },
      }

      local function set_phpcs_args()
         local filepath = vim.api.nvim_buf_get_name(0)

         if filepath == "" then
            filepath = "stdin.php"
         end

         -- todo: adjust formatter (from lsp to phpcbf)
         lint.linters.phpcs.args = {
            "-q",
            "--stdin-path=" .. filepath,
            "--report=json",
            "-",
         }
      end

      vim.api.nvim_create_autocmd({
         "BufEnter",
         "BufWritePost",
      }, {
         callback = function()
            set_phpcs_args()
            lint.try_lint("phpcs")
         end,
      })
   end,
}
