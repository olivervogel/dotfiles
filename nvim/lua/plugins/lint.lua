return {
   "mfussenegger/nvim-lint",
   event = { "BufReadPre", "BufNewFile" },
   init = function()
      require('lint').linters_by_ft = {
         php = {'phpcs'}
      }
      require('lint.linters.phpcs').args = {
         '-q',
         '--standard=psr12',
         '--report=json',
         '-'
      }
      vim.api.nvim_create_autocmd({ 'BufRead', 'TextChanged', 'InsertLeave' }, {
         pattern = { "*" },
         callback = function()
            require('lint').try_lint()
         end,
      })
   end,
}
