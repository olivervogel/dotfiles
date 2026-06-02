function run_phpcbf()
  local filepath = vim.api.nvim_buf_get_name(0)

  if filepath == "" then
    vim.notify("No file associated with current buffer", vim.log.levels.WARN)
    return
  end

  local cmd = { "phpcbf", "-q", filepath }

  vim.system(cmd, {}, function(obj)
    if obj.code ~= 0 then
      vim.schedule(function()
        vim.notify("phpcbf failed:\n" .. (obj.stderr or ""), vim.log.levels.ERROR)
      end)
    else
      vim.schedule(function()

         -- reload buffer from disk
        vim.cmd("checktime")
        vim.notify("phpcbf completed", vim.log.levels.INFO)
      end)
    end
  end)
end
