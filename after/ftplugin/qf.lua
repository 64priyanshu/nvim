-- Add the cfilter plugin (see :Cfilter)
vim.cmd.packadd("cfilter")

-- Keymap to jump around error list (QF)
vim.keymap.set("n", "[Q", "<CMD>colder<CR>", { silent = true })
vim.keymap.set("n", "]Q", "<CMD>cnewer<CR>", { silent = true })

-- Remove Quickfix entries
local removeQfList = function()
  local qf_info = vim.fn.getqflist({ items = true, title = true })
  local qf_items = qf_info.items -- Retrieve the current QuickFix list entries and store them in the items table
  local qf_title = qf_info.title -- Retrieve the current QuickFix list entries title before modifications

  local mode = vim.fn.mode() -- Retrieve current mode
  local start_line, end_line

  if mode == "v" or mode == "V" then -- Check if Visual or Visual-Line mode
    start_line = vim.fn.line("v") -- Get the starting line of the visual selection
    end_line = vim.fn.line(".") -- Get the current cursor line (end of selection)
    -- Ensure start_line is always ≤ end_line by swapping if needed
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
  else -- Normal mode
    start_line = vim.fn.line(".")
    end_line = start_line -- Set both start and end lines to current line
  end

  -- Ensure we don't remove out-of-range items
  local qf_len = #qf_items
  start_line = math.max(1, math.min(start_line, qf_len))
  end_line = math.max(1, math.min(end_line, qf_len))

  for i = end_line, start_line, -1 do -- Remove items in reverse order to avoid index shifting issues
    table.remove(qf_items, i) -- Remove the item at position i from the items table
  end

  -- Update current quickfix list with our modified items table keeping the title same, "r" flag means replace existing list
  vim.fn.setqflist({}, "r", { items = qf_items, title = qf_title })

  -- Prevent cursor going out-of-bounds
  if #qf_items > 0 then
    local new_line = math.min(start_line, #qf_items)
    vim.api.nvim_win_set_cursor(0, { new_line, 0 })
  else
    vim.cmd("cclose") -- Close QuickFix list if empty
  end

  -- If in visual mode, return to normal mode
  if mode == "v" or mode == "V" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end
end

-- Set keymaps for removing Quickfix entries utilizing above function
vim.keymap.set("n", "dd", removeQfList, { buffer = true })
vim.keymap.set("x", "d", removeQfList, { buffer = true })
