-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leader Key
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true -- Convert tabs to spaces with '>' and '<' commands
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt.laststatus = 3 -- Use a single statusline for all windows instead of having own separate statusline

vim.opt.pumheight = 20 -- Completion window height
vim.opt.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line
vim.opt.breakindent = true -- Wrapped line will continue visually indented
vim.opt.linebreak = true -- Doesn't allow breaking line in the middle of a word
vim.opt.swapfile = false -- Disable creating a swap file
vim.opt.backup = false -- Disable creating backup
vim.opt.undofile = true -- Create a undofile
vim.opt.wrap = true -- Enable Line Wrap
vim.opt.showcmd = false -- Disable showing commands in the last line of screen
vim.opt.incsearch = true -- While typing a search command, highlight the first matching pattern
vim.opt.hlsearch = true -- Highlights all occurrences of the search pattern
vim.opt.updatetime = 100 -- Make Neovim more responsive
vim.opt.scrolloff = 8 -- Keep 8 lines above and below the cursor

vim.opt.termguicolors = true

-- Change Insert-mode cursor to a block cursor
vim.opt.guicursor = {
	"n-v-c:block",
	"i-ci:block-blinkon1",
	"r-o:hor20",
}

vim.opt.undodir = (os.getenv("USERPROFILE") or os.getenv("HOME")) .. "/.vim/undodir" -- Store undofiles in this directory (USERPROFILE for Win, HOME for Linux)
