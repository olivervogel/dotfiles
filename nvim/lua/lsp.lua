vim.opt.updatetime = 1000

vim.api.nvim_set_hl(0, "DiagnosticLineNrError", { bg = "#51202A", fg = "#FF0000", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticLineNrWarn",  { bg = "#51412A", fg = "#FFA500", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticLineNrInfo",  { bg = "#1E535D", fg = "#00FFFF", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticLineNrHint",  { bg = "#1E205D", fg = "#0000FF", bold = true })

vim.diagnostic.config({
   severity_sort = true,
   underline = false,
   virtual_text = false,
   signs = {
      text = {
         [vim.diagnostic.severity.ERROR] = "",
         [vim.diagnostic.severity.WARN] = "",
         [vim.diagnostic.severity.INFO] = "",
         [vim.diagnostic.severity.HINT] = "",
      },
      numhl = {
         [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
         [vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
         [vim.diagnostic.severity.HINT] = "DiagnosticLineNrHint",
         [vim.diagnostic.severity.INFO] = "DiagnosticLineNrInfo",
      },
   },
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>s", function() vim.diagnostic.jump({ count = -1 }) end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { noremap = true, silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
   callback = function(args)
      local bufnr = args.buf
      local opts = { noremap = true, silent = true, buffer = bufnr }

      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

      vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,     opts)
      vim.keymap.set("n", "gd",         vim.lsp.buf.definition,      opts)
      vim.keymap.set("n", "gi",         vim.lsp.buf.implementation,  opts)
      vim.keymap.set("n", "<leader>I",  vim.lsp.buf.signature_help,  opts)
      vim.keymap.set("n", "<leader>i",  vim.lsp.buf.hover,           opts)
      vim.keymap.set("n", "<leader>f",  function() vim.lsp.buf.format({ async = true }) end, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,     opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,          opts)
      vim.keymap.set("n", "<leader>r",  vim.lsp.buf.references,      opts)
   end,
})

vim.lsp.enable({ "intelephense", "html", "cssls", "eslint" })
