-- nvim-treesitter plugin is currently only used to ensure that the parsers
-- are installed might be removed completely in the future. It is also a
-- dependency of treesj.nvim

local ensure_installed = {
   "php",
   "javascript",
   "typescript",
   "json",
   "html",
   "vue",
   "css",
   "scss",
   "cpp",
   "twig",
}

return {
   "nvim-treesitter/nvim-treesitter",
   build = ":TSUpdate",
   config = function()
      local installed = require("nvim-treesitter.config").get_installed()
      local installed_set = {}
      for _, lang in ipairs(installed) do
         installed_set[lang] = true
      end

      local missing = vim.tbl_filter(function(lang)
         return not installed_set[lang]
      end, ensure_installed)

      if #missing > 0 then
         require("nvim-treesitter.install").install(missing)
      end

      vim.api.nvim_create_autocmd("FileType", {
         callback = function(ev)
            local lang = vim.treesitter.language.get_lang(ev.match)
            if lang and vim.treesitter.language.add(lang) then
               vim.treesitter.start(ev.buf, lang)
            end
         end,
      })
   end,
}
