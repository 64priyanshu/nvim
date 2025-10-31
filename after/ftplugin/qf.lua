-- Add the cfilter plugin (see :Cfilter)
vim.cmd.packadd("cfilter")

-- Keymap to jump around error list (QF)
vim.keymap.set("n", "[Q", "<CMD>colder<CR>", { silent = true })
vim.keymap.set("n", "]Q", "<CMD>cnewer<CR>", { silent = true })

-- Remove entries from the quickfix(qf) list
local function remove_qf_items()
  -- Get current qf list's items/entries, title and index
  local qf = vim.fn.getqflist({ items = true, title = true, idx = 0 })
  local items, title, current_idx = qf.items, qf.title, qf.idx
  -- Get current mode
  local mode = vim.fn.mode()
  -- Item(s) selection range
  local start_line, end_line

  if mode:match("[vV]") then -- Visual/Visual Line mode
    start_line, end_line = vim.fn.line("v"), vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
  else -- Normal mode
    start_line = vim.fn.line(".")
    end_line = start_line
  end

  -- Ensure we don't remove out-of-range items
  start_line = math.max(1, math.min(start_line, #items))
  end_line = math.max(1, math.min(end_line, #items))

  -- Calculate no. of items deleted
  local delete_count = end_line - start_line + 1

  -- Remove qf items in reverse order to avoid index shifting issues
  for i = end_line, start_line, -1 do
    table.remove(items, i)
  end

  -- Replace the current qf list with our new modified items table keeping the same qf list name
  vim.fn.setqflist({}, "r", { items = items, title = title })

  -- Prevent cursor going out-of-bounds and close qf window if all items are deleted
  if #items > 0 then
    local new_idx = current_idx
    -- If active qf entry was among the deleted items range, set the index to first item of the qf list
    if current_idx >= start_line and current_idx <= end_line then
      new_idx = 1
    -- If active qf entry was below the deleted items range then do some calculation to preserve the active qf entry
    elseif current_idx > end_line then
      new_idx = math.max(1, current_idx - delete_count)
    end
    -- Set the correct active entry for the qf
    vim.fn.setqflist({}, "r", { idx = new_idx })
    -- Cursor position in the updated qf list
    vim.api.nvim_win_set_cursor(0, { math.min(start_line, #items), 0 })
  else
    vim.cmd("cclose")
  end

  -- Exit Visual mode after the operation
  if mode:match("[vV]") then
    vim.api.nvim_input("<Esc>")
  end
end

-- Set keymaps for removing Quickfix entries utilizing above function
vim.keymap.set("n", "dd", remove_qf_items, { buffer = true })
vim.keymap.set("x", "d", remove_qf_items, { buffer = true })
