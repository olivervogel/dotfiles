return {
   "saghen/blink.cmp",
   version = '1.*',
   -- event = { "BufReadPre", "BufNewFile" }
   init = function()
      vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { fg = '#5978A6', bg = '#27313F', bold = false, italic = false })
      vim.api.nvim_set_hl(0, 'BlinkCmpKind', { fg = '#5978A6', bg = '#27313F', bold = false, italic = false })
      vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', { fg = '#4A8AEA', bg = '#2D3848', bold = false, italic = false })
      vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { fg = '#7D8C97', bg = '#27313F', bold = false, italic = false })
   end,
   opts = {
      keymap = {
         preset = 'enter',
         ['<Tab>'] = {}, -- configured via luasnip
         ['<C-n>'] = {}, -- configured via luasnip
         ['<C-p>'] = {}, -- configured via luasnip
         ['<C-x>'] = { -- close completion menu on <C-x>
            function(cmp)
               cmp.cancel()
               return
            end,
            'fallback'
         }, 
      },
      sources = {
         min_keyword_length = 2, -- show completion only after at least two characters has been typed
         default = {
            'lsp',
            'buffer',
            'path',
         },
         providers = {
            lsp = { 
               fallbacks = {} -- always show buffer sources (even if lsp has results)
            },
            buffer = {
               opts = {
                  -- buffer completion from all open buffers: filter to only "normal" buffers
                  get_bufnrs = function()
                     return vim.tbl_filter(function(bufnr)
                        return vim.bo[bufnr].buftype == ''
                     end, vim.api.nvim_list_bufs())
                  end
               }
            },
            lines = {
               name = 'Lines',
               module = 'sources.lines',
            }
         } 
      },
      fuzzy = {
         -- always prioritize exact matches
         sorts = {
            'exact',
            -- defaults
            'score',
            'sort_text',
         },
      },
      completion = {
         menu = {
            min_width = 60,
            border = 'rounded',
            draw = {
               align_to = 'none',
               columns = {
                  { 
                     "label",
                     "label_description",
                     gap = 2,
                  },
                  {
                     "kind",
                     "kind_icon",
                     gap = 2,
                  }
               },
               components = {
                  label = {
                     width = { max = 25 },
                     text = function(ctx)
                        if ctx.kind == 'Method' or ctx.kind == 'function' then
                           return ctx.label .. ctx.label_detail .. "~"
                        else
                           return ctx.label .. ctx.label_detail
                        end
                     end
                  },
                  label_description = {
                     width = { max = 30 },
                     text = function(ctx) return ctx.label_description end,
                     highlight = 'BlinkCmpMenu',
                  },
               }
            }
         }
      }
   }
}
