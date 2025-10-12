-- Prevent from automatically inserting comment leader when opening new line under a comment
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NoAutoComment", { clear = true }),
  pattern = "*",
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- Create parent directory of the file if it doesn't exist
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("CreateDirectory", { clear = true }),
  pattern = "*",
  callback = function()
    local fpath = vim.fn.expand("<afile>")
    local dir = vim.fn.fnamemodify(fpath, ":p:h")
    if vim.fn.isdirectory(dir) ~= 1 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
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
  group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0) -- Get the current cursor position
    vim.cmd([[%s/\s\+$//e]]) -- Perform the substitution to remove trailing spaces
    vim.api.nvim_win_set_cursor(0, pos) -- Restore the cursor position
  end,
})

-- Exit these windows/buffers pressing <ESC> or q
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("CloseWinOnEsc", { clear = true }),
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
  group = vim.api.nvim_create_augroup("CloseCmdOnEsc", { clear = true }),
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<CMD>close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<CMD>close<CR>", { noremap = true, silent = true })
    vim.cmd("setlocal nobuflisted")
  end,
})

-- Set filetype=terminal for terminal windows/buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("Terminal", { clear = true }),
  pattern = "term://*",
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.opt.filetype = "terminal"
      vim.cmd.startinsert() -- Start in insert mode
    end
  end,
})

-- Save View

-- Autocommand to save view state on exiting buffer window
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = vim.api.nvim_create_augroup("SaveViewState", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! mkview")
    end
  end,
})

-- Autocommand to load view state and center screen on entering a buffer window
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("LoadViewState", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! loadview")
      vim.cmd("normal! zz")
    end
  end,
})
