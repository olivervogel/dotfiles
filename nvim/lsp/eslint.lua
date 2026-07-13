return {
   cmd = { "vscode-eslint-language-server", "--stdio" },
   filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
      "svelte",
      "astro",
   },
   root_markers = {
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      ".eslintrc.json",
      "eslint.config.js",
      "eslint.config.mjs",
      "eslint.config.cjs",
      "eslint.config.ts",
      "package.json",
      ".git",
   },
   settings = {
      validate = "on",
      useESLintClass = false,
      experimental = { useFlatConfig = false },
      codeActionOnSave = { mode = "all" },
      format = true,
      quiet = false,
      onIgnoredFiles = "off",
      rulesCustomizations = {},
      run = "onType",
      problems = { shortenToSingleLine = false },
      nodePath = "",
      workingDirectory = { mode = "location" },
      codeAction = {
         disableRuleComment = { enable = true, location = "separateLine" },
         showDocumentation = { enable = true },
      },
   },
   handlers = {
      ["eslint/openDoc"] = function(_, result)
         if result then
            vim.ui.open(result.url)
         end
         return {}
      end,
      ["eslint/confirmESLintExecution"] = function(_, result)
         if result then
            return 4 -- approved
         end
      end,
      ["eslint/probeFailed"] = function()
         vim.notify("ESLint probe failed.", vim.log.levels.WARN)
         return {}
      end,
      ["eslint/noLibrary"] = function()
         vim.notify("Unable to find ESLint library.", vim.log.levels.WARN)
         return {}
      end,
   },
}
