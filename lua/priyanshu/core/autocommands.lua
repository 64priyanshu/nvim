-- Prevent from automatically inserting comment leader when opening new line under a comment
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 80,
    })
  end,
})

-- Remove trailing whitespaces before saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0) -- Get the current cursor position
    vim.cmd([[%s/\s\+$//e]]) -- Perform the substitution to remove trailing spaces
    vim.api.nvim_win_set_cursor(0, pos) -- Restore the cursor position
  end,
})

-- Exit these windows/buffers pressing <ESC> or q
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "help",
    "lspinfo",
    "checkhealth",
    "qf",
    "terminal",
  },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<CMD>close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<CMD>close<CR>", { noremap = true, silent = true })
    vim.cmd("setlocal nobuflisted")
  end,
})

-- Exit command-line window pressing <ESC> or q
vim.api.nvim_create_autocmd("CmdWinEnter", {
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<CMD>close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<CMD>close<CR>", { noremap = true, silent = true })
  end,
})

-- Set filetype=terminal for terminal windows/buffers
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.opt.filetype = "terminal"
      vim.cmd.startinsert() -- Start in insert mode
    end
  end,
})
