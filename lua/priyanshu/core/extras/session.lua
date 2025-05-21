-- Set up sessiondir
local sessions_dir = vim.fn.expand("$HOME") .. "/.vim/sessions"

-- Create sessiondir if it doesn't exist
vim.fn.mkdir(sessions_dir, "p")

-- Variable to store the current session name
local current_session = nil

-- Autocommand to detect and store the session file name in the Global variable when sourcing a session
vim.api.nvim_create_autocmd("SessionLoadPost", {
  group = vim.api.nvim_create_augroup("LoadSession", { clear = true }),
  callback = function()
    local session_file = vim.v.this_session
    if session_file ~= "" then
      current_session = session_file
    end
  end,
})

-- Keybinding with function to save a session that asks name in prompt
vim.keymap.set("n", "<leader>ss", function()
  if current_session then
    vim.cmd("mksession! " .. current_session)
    vim.notify("Session saved to: " .. current_session, vim.log.levels.INFO)
  else
    vim.ui.input({ prompt = "Session name: " }, function(session_name)
      if session_name and session_name ~= "" then
        local date_time = tostring(os.date("%b%d_%H%M")):lower()
        local session_filename = session_name .. "_" .. date_time .. ".vim"
        local session_path = sessions_dir .. "/" .. session_filename
        vim.cmd("mksession! " .. session_path)
        current_session = session_path
        vim.notify("Session saved to: " .. current_session, vim.log.levels.INFO)
      else
        vim.notify("Session name is required.", vim.log.levels.ERROR)
      end
    end)
  end
end, { silent = true })
