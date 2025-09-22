return {
   "L3MON4D3/LuaSnip",
   version = "^2.3",
   build = "make install_jsregexp",
   keys = {
      { 
         "<tab>", function()
            if require("luasnip").expand_or_jumpable() then
               require("blink.cmp").hide()
               require("luasnip").expand_or_jump()
            else
               -- press tab key
               vim.api.nvim_feedkeys(
                  vim.api.nvim_replace_termcodes("<Tab>", true, true, true),
                  "n",
                  true
               )
            end
         end, mode = "i", silent = true 
      },
      { 
         "<tab>", function()
            require("luasnip").jump(1)
         end, mode = "s", noremap = true, silent = true
      },
      { 
         "<s-tab>", function()
            require("luasnip").jump(-1)
         end, mode = "s", noremap = true, silent = true 
      },
      { 
         "<C-n>", function()
            if require("luasnip").choice_active() then
               require("luasnip").change_choice(1)
            elseif require('blink.cmp').is_visible() then
               require('blink.cmp').select_next()
            else
               -- default: press <C-n>
               vim.api.nvim_feedkeys(
                  vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
                  "n",
                  true
               )
            end
         end, mode = { "i", "s" }, noremap = true, silent = true 
      },
      { 
         "<C-p>", function()
            if require("luasnip").choice_active() then
               require("luasnip").change_choice(-1)
            elseif require('blink.cmp').is_visible() then
               require('blink.cmp').select_prev()
            else
               -- default: press <C-p>
               vim.api.nvim_feedkeys(
                  vim.api.nvim_replace_termcodes("<C-p>", true, true, true),
                  "n",
                  true
               )
            end
         end, mode = { "i", "s" }, noremap = true, silent = true 
      },
   },
   init = function()
      local ls = require("luasnip")
      local ls_types = require("luasnip.util.types")
      local snippet_node = require("luasnip.nodes.snippet").S
      local fmt = require("luasnip.extras.fmt").fmt

      require("luasnip.loaders.from_lua").lazy_load({ 
         paths = { "~/.config/nvim/lua/snippets" }
      })

      ls.filetype_extend("vue", {"html"})
      ls.filetype_extend("blade", {"html"})
      ls.filetype_extend("twig", {"html"})
      ls.filetype_extend("silverstripe_html", {"html"})
      ls.filetype_extend("zsh", {"sh"})
      ls.filetype_extend("markdown_inline", {"markdown"})

      local function maybe_leave_snippet()
         if
            (vim.v.event.new_mode == 'n')
            and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require('luasnip').session.jump_active
            then
               require('luasnip').unlink_current()
            end
         end

         -- leave snippets when you leave to mode
         vim.api.nvim_create_autocmd({ "ModeChanged" }, {
            pattern = "*",
            callback = maybe_leave_snippet,
         })
      end,
      opts = function()
         local ls = require("luasnip")
         local ls_types = require("luasnip.util.types")
         local snippet_node = require("luasnip.nodes.snippet").S
         local fmt = require("luasnip.extras.fmt").fmt
         local ftf = require("luasnip.extras.filetype_functions")

         return {
            history = false,
            enable_autosnippets = true,
            update_events = 'TextChanged,TextChangedI',
            ft_func = ftf.from_pos_or_filetype,
            load_ft_func = ftf.extend_load_ft({
               html = {"javascript", "php"}, -- also load javascript for html context
               vue = {"javascript", "html"}
            }),
            snip_env = {
               -- just copied because of https://github.com/L3MON4D3/LuaSnip/issues/566#issuecomment-1233022044
               sn = require("luasnip.nodes.snippet").SN,
               t = require("luasnip.nodes.textNode").T,
               f = require("luasnip.nodes.functionNode").F,
               i = require("luasnip.nodes.insertNode").I,
               c = require("luasnip.nodes.choiceNode").C,
               d = require("luasnip.nodes.dynamicNode").D,
               r = require("luasnip.nodes.restoreNode").R,
               l = require("luasnip.extras").lambda,
               rep = require("luasnip.extras").rep,
               p = require("luasnip.extras").partial,
               m = require("luasnip.extras").match,
               n = require("luasnip.extras").nonempty,
               dl = require("luasnip.extras").dynamic_lambda,
               fmt = require("luasnip.extras.fmt").fmt,
               fmta = require("luasnip.extras.fmt").fmta,
               conds = require("luasnip.extras.expand_conditions"),
               types = require("luasnip.util.types"),
               events = require("luasnip.util.events"),
               parse = require("luasnip.util.parser").parse_snippet,
               ai = require("luasnip.nodes.absolute_indexer"),
               -- custom below here
               trim = function(string)
                  return string:match "^%s*(.-)%s*$"
               end,
               -- customize default behaviour of default node
               s = ls.extend_decorator.apply(snippet_node, {}, { 
                  -- set default behaviour: snippets expand only if trigger word
                  -- is the first word on the line or is preceded by one or more whitespace characters.
                  -- Also snippets dont expand inside an active snippet
                  condition = function(line_to_cursor, matched_trigger, captures)
                     local trigger_pos, _ = string.find(line_to_cursor, matched_trigger)
                     local char_before_trigger = string.sub(line_to_cursor, trigger_pos - 1, trigger_pos -1)
                     return ls.in_snippet() == false and (char_before_trigger == " " or char_before_trigger == "")
                  end
               }),
               -- create inline node
               s_inline = ls.extend_decorator.apply(snippet_node, {}, { 
                  -- set inline behaviour: snippets expand everywhere but inside active snippets
                  condition = function(line_to_cursor, matched_trigger, captures)
                     return ls.in_snippet() == false
                  end
               })
            },
            ext_opts = {
               [ls_types.snippet] = {
                  active = {
                     hl_group = "Comment",
                  },
                  passive = {
                     hl_group = "Comment",
                  },
                  visited = {
                     hl_group = "Comment",
                  },
                  unvisited = {
                     hl_group = "Comment",
                  },
               },
               [ls_types.choiceNode] = {
                  active = {
                     virt_text = {{"", "Variable"}}
                  },
               }
            },
         }
      end
   }
