-- Add the cfilter plugin (see :Cfilter)
vim.cmd.packadd("cfilter")

-- Keymap to jump around error list (QF)
vim.keymap.set("n", "[Q", "<CMD>colder<CR>", { silent = true })
vim.keymap.set("n", "]Q", "<CMD>cnewer<CR>", { silent = true })

-- Remove Quickfix entries
local removeQfList = function()
	local items = vim.fn.getqflist() -- Retrieves the current QuickFix list entries and stores them in the items table
	local mode = vim.fn.mode() -- Retrieve current mode
	local start_line, end_line

	if mode == "v" or mode == "V" then -- Check if Visual or Visual-Line mode
		start_line = vim.fn.line("v") -- Gets the starting line of the visual selection
		end_line = vim.fn.line(".") -- Gets the current cursor line (end of selection)
		-- Ensures start_line is always ≤ end_line by swapping if needed
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
	else -- Normal mode
		start_line = vim.fn.line(".")
		end_line = start_line -- Set both start and end lines to current line
	end

	-- Ensure we don't remove out-of-range items
	local qf_len = #items
	start_line = math.max(1, math.min(start_line, qf_len))
	end_line = math.max(1, math.min(end_line, qf_len))

	-- Remove items in reverse order to avoid index shifting issues
	for i = end_line, start_line, -1 do
		table.remove(items, i) -- Removes the item at position i from the items table
	end
	vim.fn.setqflist(items, "r") -- Update current quickfix list with our modified items table, "r" flag means replace existing list

	-- Prevent cursor going out-of-bounds
	if #items > 0 then
		local new_line = math.min(start_line, #items)
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
vim.keymap.set("n", "dd", removeQfList, { silent = true, buffer = true })
vim.keymap.set("x", "d", removeQfList, { silent = true, buffer = true })
