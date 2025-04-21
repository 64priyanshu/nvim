-- <LEADER> keymaps

-- Quick file save/close action
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", "<CMD>bp|bd #<CR>", { silent = true })

-- Stop hlsearch
vim.keymap.set("n", "<leader>h", "<CMD>nohlsearch<CR>", { silent = true })

-- Search and replace word under the cursor
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("x", "<leader>sw", [["1y:%s/\<<C-r>1\>//gI<Left><Left><Left>]])

-- Line Wrap
vim.keymap.set("n", "<leader>lw", function()
  vim.wo.wrap = not vim.wo.wrap
  if vim.wo.wrap then
    vim.notify("Enabled line-wrap for this buffer.", vim.log.levels.INFO)
  else
    vim.notify("Disabled line-wrap for this buffer.", vim.log.levels.INFO)
  end
end, { silent = true })

-- Toggle Read-Only mode for current buffer
vim.keymap.set("n", "<leader>ro", function()
  vim.bo.modifiable = not vim.bo.modifiable
  if vim.bo.modifiable then
    vim.notify("Modifiable.", vim.log.levels.INFO)
  else
    vim.notify("Read only.", vim.log.levels.WARN)
  end
end, { silent = true })

-- Copy to system clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')

-- Keep the deleted text in black-hole register
vim.keymap.set({ "n", "x" }, "<leader>d", '"_d')

-- Copy current directory path to clipboard
vim.keymap.set("n", "<leader>cfp", function()
  local path = vim.fn.expand("%:p:h")
  vim.fn.setreg("+", path)
  vim.notify("Copied path to clipboard:\n" .. path, vim.log.levels.INFO)
end, { silent = true })

-- Terminal splits
vim.keymap.set("n", "<leader>t-", "<CMD>belowright 10split | term<CR>", { silent = true })
vim.keymap.set("n", "<leader>t|", "<CMD>botright 70vsplit | term<CR>", { silent = true })

-- <OTHER> keymaps and remaps

-- Create split and move cursor to new split
vim.keymap.set("n", "|", "<CMD>vsplit<CR><C-w>l", { silent = true })
vim.keymap.set("n", "-", "<CMD>split<CR><C-w>j", { silent = true })

-- Move Lines in Visual mode
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")

-- This function fixes screen flickering when pressing <C-d> from top of the file
local function lazy(keys)
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  return function()
    local old = vim.o.lazyredraw
    vim.o.lazyredraw = true
    vim.api.nvim_feedkeys(keys, "nx", false)
    vim.o.lazyredraw = old
  end
end

-- Cursor stays at the center of the screen
vim.keymap.set("n", "<C-d>", lazy("<C-d>zz"))
vim.keymap.set("n", "<C-u>", lazy("<C-u>zz"))

-- Cursor stays at the center of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Cursor stays at the current position after Joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Stay in Visual mode after changing Indent with < >
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Move around in Line wrap and record relative jumps (10k, 10j) in jumplists
vim.keymap.set("n", "j", function()
  return vim.v.count > 0 and "m'" .. vim.v.count .. "j" or "gj"
end, { expr = true })

vim.keymap.set("n", "k", function()
  return vim.v.count > 0 and "m'" .. vim.v.count .. "k" or "gk"
end, { expr = true })

-- Resize split with Arrow Keys
vim.keymap.set("n", "<Up>", "<CMD>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<Down>", "<CMD>resize -2<CR>", { silent = true })
vim.keymap.set("n", "<Right>", "<CMD>vertical resize +2<CR>", { silent = true })
vim.keymap.set("n", "<Left>", "<CMD>vertical resize -2<CR>", { silent = true })

-- Remap to move horizontally in command-line mode without using arrow key
vim.keymap.set("c", "<C-h>", "<Left>")
vim.keymap.set("c", "<C-l>", "<Right>")
