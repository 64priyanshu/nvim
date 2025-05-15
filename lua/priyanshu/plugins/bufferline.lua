local M = {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      always_show_bufferline = false,
      sort_by = "insert_at_end",
      style_preset = {
        bufferline.style_preset.no_italic,
        bufferline.style_preset.no_bold,
      },
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          padding = 1,
        },
      },

      -- Diagnostics
      diagnostics = "nvim_lsp",
      diagnostics_update_on_event = true,
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and "E" or "W"
        return icon .. count
      end,
    },
  })

  -- Navigate Buffer
  vim.keymap.set("n", "L", "<CMD>BufferLineCycleNext<CR>", { silent = true })
  vim.keymap.set("n", "H", "<CMD>BufferLineCyclePrev<CR>", { silent = true })

  -- Reorder Buffers
  vim.keymap.set("n", "<leader>L", "<CMD>BufferLineMoveNext<CR>", { silent = true })
  vim.keymap.set("n", "<leader>H", "<CMD>BufferLineMovePrev<CR>", { silent = true })
end

return M
