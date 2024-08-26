return {
   'numToStr/Comment.nvim',
   event = { "BufReadPre", "BufNewFile" },
   version = "^0.8",
   config = true,
   init = function()
      local comment = require('Comment.ft')
      comment({'blade', 'silverstripe_html'}, comment.get('html'))
   end
}
