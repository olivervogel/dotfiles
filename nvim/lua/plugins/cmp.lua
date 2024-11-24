return {
   "hrsh7th/nvim-cmp",
   event = { "BufReadPre", "BufNewFile" },
   dependencies = { 
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
   },
   init = function()
      vim.opt.completeopt = "menu,menuone"
      vim.opt.pumheight = 10
      vim.cmd([[
      inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
      ]])
   end,
   opts = function()
      local cmp = require("cmp")

      return {
         completion = {
            keyword_length = 2
         },
         window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
         },
         mapping = cmp.mapping.preset.insert({
            ["<cr>"] = cmp.mapping.confirm({ select = true }),
            ["<c-u>"] = cmp.mapping.scroll_docs(-4),
            ["<c-d>"] = cmp.mapping.scroll_docs(4),
            ["<c-p>"] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_prev_item()
               elseif require("luasnip").choice_active() then
                  require("luasnip").change_choice(-1)
               else
                  fallback()
               end
            end, { "i", "s" }),
            ["<c-n>"] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_next_item()
               elseif require("luasnip").choice_active() then
                  require("luasnip").change_choice(1)
               else
                  fallback()
               end
            end, { "i", "s" }),
            ["<c-space>"] = cmp.config.disable 
         }),
         sources = {
            { name = "nvim_lsp" },
            {
               name = "buffer",
               option = {
                  get_bufnrs = function()
                     return vim.api.nvim_list_bufs() -- search all buffers
                  end
               }
            },
         },
         sorting = {
            comparators = {
               cmp.config.compare.offset,
               cmp.config.compare.exact,
               cmp.config.compare.score,
               cmp.config.compare.recently_used,
               cmp.config.compare.kind,
               cmp.config.compare.sort_text,
               cmp.config.compare.length,
               cmp.config.compare.order,
            }
         },
         matching = {
            disallow_fuzzy_matching = true,
            disallow_fullfuzzy_matching = true,
            disallow_partial_fuzzy_matching = true,
            disallow_partial_matching = false,
            disallow_prefix_unmatching = true,
      },
      }
   end
}
