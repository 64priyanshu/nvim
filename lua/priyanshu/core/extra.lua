--[[ LOGDIR ]]

-- Set up logdir and logfile paths
local logdir = vim.fn.expand("$HOME") .. "/.vim/logdir"
local logfile = logdir .. "/log.txt"

-- Create logdir if it doesn't exist
vim.fn.mkdir(logdir, "p")

-- Autocommand to re-write (not append) vim messages in logs.txt on exiting
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		local messages = vim.fn.execute("messages")
		messages = messages:gsub("^\n+", ""):gsub("\n+$", "")
		vim.fn.writefile(vim.split(messages, "\n"), logfile)
	end,
})

--[[ SESSION (Works together with my fzf_session script) ]]

-- Set up sessiondir
local sessions_dir = vim.fn.expand("$HOME") .. "/.vim/sessions"

-- Create sessiondir if it doesn't exist
vim.fn.mkdir(sessions_dir, "p")

-- Variable to store the current session name
_G.current_session = nil

-- Autocommand to detect and store the session file name in the Global variable when sourcing a session
vim.api.nvim_create_autocmd("SessionLoadPost", {
	callback = function()
		local session_file = vim.v.this_session
		if session_file ~= "" then
			_G.current_session = session_file
		end
	end,
})

-- Keybinding with function to save a session that asks name in prompt
vim.keymap.set("n", "<leader>ss", function()
	if _G.current_session then
		vim.cmd("mksession! " .. _G.current_session)
		print("Session saved to: " .. _G.current_session)
	else
		vim.ui.input({ prompt = "Session name: " }, function(session_name)
			if session_name and session_name ~= "" then
				local date_time = tostring(os.date("%b%d_%H%M")):lower()
				local session_filename = session_name .. "_" .. date_time .. ".vim"
				local session_path = sessions_dir .. "/" .. session_filename
				vim.cmd("mksession! " .. session_path)
				_G.current_session = session_path
				print("Session saved to: " .. _G.current_session)
			else
				vim.api.nvim_echo({ { "Session name is required.", "ErrorMsg" } }, true, {})
			end
		end)
	end
end, { silent = true })
