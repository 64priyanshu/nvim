local buffer_cwd = {}

-- Restore CWD when entering a buffer window
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("RestoreCwd", { clear = true }),
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if buffer_cwd[buf] then
      vim.api.nvim_set_current_dir(buffer_cwd[buf])
    end
  end,
})

-- Save CWD when leaving a buffer window
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = vim.api.nvim_create_augroup("SaveCwd", { clear = true }),
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    buffer_cwd[buf] = vim.fn.getcwd()
  end,
})

-- Remove CWD entry when buffer is deleted or wiped
vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
  group = vim.api.nvim_create_augroup("RemoveCwd", { clear = true }),
  callback = function(args)
    buffer_cwd[args.buf] = nil
  end,
})
