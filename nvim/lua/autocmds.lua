require "nvchad.autocmds"

-- Custom autocmd to handle nvdash vs nvim-tree opening
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local args = vim.fn.argv()
    
    -- If opened with a directory argument (like "nvim .")
    if #args == 1 and vim.fn.isdirectory(args[1]) == 1 then
      -- Close nvdash by deleting the buffer with filetype nvdash
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype == "nvdash" then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
      -- Open nvim-tree using the correct API
      require("nvim-tree.api").tree.open()
    -- If opened with a file, close nvdash
    elseif #args > 0 then
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype == "nvdash" then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end
    -- If opened with no arguments, nvdash loads automatically from chadrc.lua
  end,
})

-- Smart relative line numbers: relative in normal mode, absolute in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})
