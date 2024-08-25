return {
   "nvim-telescope/telescope.nvim",
   version = "^0.1.8",
   lazy = true,
   dependencies = { 
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim'
   },
   keys = { 
      { "<c-p>", ":Telescope find_files hidden=true<cr>", desc = "Find files" },
      { "<leader>ff", ":Telescope find_files<cr>", desc = "Find files" },
      { "<c-s>", ":Telescope file_browser path=%:p:h<cr>", desc = "Browse current buffer's directory" },
      { "<c-f>", ":Telescope oldfiles<cr>", desc = "Find old files" },
      { "<a-r>", ":Telescope lsp_document_symbols<cr>", desc = "Find lsp symbols" },
      { "®", ":Telescope lsp_document_symbols<cr>", desc = "Find lsp symbols" },
      { "<leader>fs", ":Telescope live_grep<cr>", desc = "Find string" },
      { "<leader>fc", ":Telescope grep_string<cr>", desc = "Find string under cursor" },
      { "<leader>fb", ":Telescope buffers<cr>", desc = "Find buffer" },
      { "<leader>fh", ":Telescope help_tags<cr>", desc = "Find in help" },
      { "<leader>gs", ":Telescope git_status<cr>", desc = "Find git status" },
      { "<leader>fr", ":Telescope resume<cr>", desc = "Resume last search results" },
      { "<leader>fq", ":Telescope quickfix<cr>", desc = "Find quickfix list" },
      { "<leader>fm", ":Telescope marks<cr>", desc = "Find mark" },
      { "<leader>fz", ":Telescope current_buffer_fuzzy_find<cr>", desc = "Find in current buffer" },
   },
   opts = function()
      local actions = require('telescope.actions')
      local previewers = require("telescope.previewers")
      local previewers_utils = require('telescope.previewers.utils')

      -- preview ignores large files
      local preview_maker_ignore_large_files = function(filepath, bufnr, opts)
         opts = opts or {}
         filepath = vim.fn.expand(filepath)
         vim.loop.fs_stat(filepath, function(_, stat)
            if not stat then return end
            if stat.size > 100000 then
               previewers_utils.job_maker({
                  "echo",
                  "Preview not available. File is too large.",
               }, bufnr, opts)
            else
               previewers.buffer_previewer_maker(filepath, bufnr, opts)
            end
         end)
      end

      return {
         defaults = {
            file_ignore_patterns = {
               ".DS_Store",
               "node_modules",
               "deps",
               "vendor",
               ".git/",
               ".vscode/",
               ".cache/",
               ".gitkeep",
            },
            vimgrep_arguments = {
               'rg',
               '--hidden',
               '--color=never',
               '--no-heading',
               '--with-filename',
               '--line-number',
               '--column',
               '--smart-case',
               '-u'
            },
            buffer_previewer_maker = preview_maker_ignore_large_files,
            layout_config = {
               width = 0.9,
            },
            mappings = {
               i = {
                  ["<esc>"] = actions.close,
                  ["<C-p>"] = actions.close,
                  ["<C-j>"] = actions.move_selection_next,
                  ["<C-k>"] = actions.move_selection_previous
               },
               n = {
                  ["<C-p>"] = actions.close,
                  ["<C-j>"] = actions.move_selection_next,
                  ["<C-k>"] = actions.move_selection_previous
               }
            }
         },
         extensions = {
            file_browser = {
               file_ignore_patterns = {
                  "%.git",
                  "%.DS_Store",
                  "%.cache"
               },
               hidden = true,
               grouped = true,
               sorting_strategy = 'ascending',
               mappings = {
                  i = {
                     ["<C-s>"] = actions.close,
                  },
                  n = {
                     ["<C-s>"] = actions.close,
                  }
               }
            }
         },
      }
   end,
}
