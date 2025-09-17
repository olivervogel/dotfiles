return {
   "EdenEast/nightfox.nvim",
   version = "^3.10",
   lazy = false,
   priority = 1000,
   init = function()
      vim.cmd([[colorscheme nightfox]])
      vim.cmd([[syntax on]])
      vim.opt.termguicolors = true
   end,
   opts = function()
      local Shade = require("nightfox.lib.shade")
      return {
         options = {
            styles = {
               comments = "italic",
            },
         },
         palettes = {
            nightfox = {
               bg1 = "#27313F", -- main bg
               bg0 = "#1F2732", -- Dark bg (status line and float)
               bg2 = "#252F3C", -- Lighter bg (colorcolm folds)
               bg3 = "#2D3848", -- Lighter bg (cursor line)
               bg4 = "#43556A", -- Conceal, border fg

               comment = "#42586E",
               white = { base = "#B4BDC3", bright = "#EEF0F1", dim = "#7D8C97" },
               blue = { base = "#4A8AEA", bright = "#86AADF", dim = "#5978A6" },
               magenta = Shade.new("#1A6BE5", 0, 0),
               orange = { base = "#D88142", bright = "#EFC9AF", dim = "#965E36" },
               yellow = { base = "#C6A339", bright = "#E4CB81", dim = "#8F7A3D" },
               green = { base = "#8AA88A", bright = "#BDDBBD", dim = "#6A7A6A" },
               red = { base = "#D65C5C", bright = "#EF9090", dim = "#A65A5A" },

               selection = "#52607A",

               pink = Shade.new("#f7cd7a", 0, 0),
               cyan = { base = "#6994FF", bright = "#A4BEFF", dim = "#7895DE" },
               black = Shade.new("#000000", 0.15, -0.15),
            }
         },
         specs = {
            nightfox = {
               syntax = {
                  type = "white", -- FooController, public
                  builtin0 = "blue.bright", -- this, return
                  builtin1 = "white", -- Illuminate
                  keyword = "blue.bright", -- class, extends
                  bracket = "white.dim",
                  comment     = "comment",
                  func = "blue",
                  preproc = "blue.bright", -- use
                  string = "green",
                  variable = "blue.bright",
                  conditional = "magenta",
                  number = "orange",

                  const = "white",
                  operator = "blue.dim",
                  ident = "magenta", --[[ Exception, self ]]

                  builtin2 = "white",
                  builtin3 = "white",
                  field = "white",
                  regex = "white",
                  statement = "white",
                  dep = "white",
               }
            }
         },
         groups = {
            nightfox = {
               LineNr = { fg = "palette.comment" },
               CursorLineNr = { fg = "palette.white.dim" },
               Normal = { fg = "palette.white" },
               NormalFloat = { bg = "#1E262F" },
               NormalNC = { bg = "#222B35" },
               EndOfBuffer = { fg = "palette.comment" },
               TelescopeNormal = { bg = "#1f242c", fg = "palette.white" },
               TelescopeBorder = { bg = "#1f242c" },

               Search = { bg = "palette.selection", fg = "palette.white.bright" },
               IncSearch = { bg = "palette.white.bright", fg = "palette.bg1" },
               StatusLine = { bg = "palette.bg0", fg = "#3B4B5F" },
               WildMenu = { bg = "palette.bg0", fg = "#3B4B5F" },
               Todo = { bg = "none" },

               ["@type"] = { fg = "palette.magenta" }, -- FooController
               ["@type.builtin"] = { fg = "palette.magenta" }, -- string, array
               ["@type.definition"] = { fg = "palette.magenta" }, -- as SpecialType
               ["@property"] = { fg = "palette.blue" }, -- protected $test, $this->test

               ["@storageclass"] = { fg = "palette.white" }, -- visibility/life-time/etc. modifiers (e.g. `static`)
               ["@attribute"] = { fg = "palette.white" }, -- attribute annotations (e.g. Python decorators)
               ["@field"] = { fg = "palette.white" }, -- For fields.

               ["@constant"] = { fg = "palette.blue.bright" }, -- For constants
               ["@constant.builtin"] = { fg = "palette.magenta" }, -- For constant that are built in the language: nil in Lua.

               ["@module"] = { fg = "palette.yellow" }, -- For identifiers referring to modules and namespaces.
               ["@symbol"] = { fg = "palette.green" },

               ["@method"] = { fg = "palette.blue" }, -- For method calls and definitions.
               ["@exception"] = { fg = "palette.blue" },
               ["@function.builtin"] = { fg = "palette.blue" },

               ["@punctuation.delimiter"] = { fg = "palette.white.dim" }, -- For delimiters ie: semicolon
               ["@punctuation.bracket"] = { fg = "palette.blue.dim" }, -- For brackets and parenthesis.
               ["@boolean"] = { fg = "palette.orange" },
            }
         }
      }
   end
}
