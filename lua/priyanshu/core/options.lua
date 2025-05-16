-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leader Key
vim.g.mapleader = " "

-- Enable usage of mouse
vim.opt.mouse = "a"

-- File Encoding
vim.opt.fileencoding = "utf-8"

-- Enable 24-bit RGB color (most terminals support this)
vim.opt.termguicolors = true

-- Line numbers and Relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and Spaces
vim.opt.expandtab = true -- Convert tabs to spaces with '>' and '<' commands
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent

-- UI
vim.opt.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.showcmd = true -- Enable showing (partial) commands in the last line of screen
vim.opt.showmode = false -- Disable showing current mode below statusline (eg: -- INSERT --)
vim.opt.scrolloff = 8 -- Keep 8 lines above and below the cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns to the left and right of the cursor
vim.opt.pumheight = 20 -- Completion window height
vim.opt.updatetime = 300 -- Make Neovim more responsive (4000ms default)

-- Cursor changes
vim.opt.guicursor = {
  "n-v-c:block,i-ci-ve-sm:block,r-cr:hor20,o:hor50",
  "i-ci-ve:blinkwait700-blinkoff400-blinkon250",
  "sm:blinkwait175-blinkoff150-blinkon175",
}

-- Windows
vim.opt.splitbelow = true -- Force all horizontal splits to go below the current window
vim.opt.splitright = true -- Force all vertical splits to go to the right of the current window

-- Line wrappings
vim.opt.wrap = true -- Enable Line Wrap
vim.opt.linebreak = true -- Disable breaking line in the middle of a word
vim.opt.breakindent = true -- Wrapped line will continue visually indented
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line

-- Text search
vim.opt.incsearch = true -- While typing a search command, highlight the first matching pattern
vim.opt.hlsearch = true -- Highlights all occurrences of the search pattern
vim.opt.ignorecase = true -- Searches are case-insensitive
vim.opt.smartcase = true -- Searches are case-insensitive unless there's a capital letter

-- Folds
function _G.customFold()
  -- Get the first and last lines of the fold
  local start_line = vim.fn.getline(vim.v.foldstart)
  local end_line = vim.fn.getline(vim.v.foldend)
  -- Calculate the number of lines in the fold
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  -- Return the formatted fold text
  return start_line .. " ... " .. end_line .. " 󰁂 " .. line_count .. " lines "
end

vim.opt.foldmethod = "manual" -- Folds are created manually
vim.opt.foldtext = "v:lua.customFold()"
vim.opt.foldcolumn = "1" -- Always show foldcolumn
vim.opt.fillchars:append({
  -- fold = " ",
  foldopen = "⏷",
  foldclose = "⏵",
  foldsep = "▏",
})

-- VIM files
vim.opt.swapfile = false -- Disable creating a swap file
vim.opt.backup = false -- Disable creating backup
vim.opt.undofile = true -- Create a undofile
vim.opt.undodir = vim.fn.expand("$HOME") .. "/.vim/undodir" -- Store undofiles in home/.vim/undodir/
