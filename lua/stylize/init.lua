local M = {}
local style_maps = require("stylize.styles").maps

function M.stylize_range(start_row, start_col, end_row, end_col, style)
  local map = style_maps[style]
  if not map then
    vim.notify("Stylize: unsupported style '" .. style .. "'", vim.log.levels.ERROR)
    return
  end

  local bufnr = 0
  local text = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})

  for i, line in ipairs(text) do
    local new_line = {}
    for c in line:gmatch(".") do
      table.insert(new_line, map[c] or c)
    end
    text[i] = table.concat(new_line)
  end

  vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, text)
end

function M.setup()
  vim.api.nvim_create_user_command("Stylize", function(opts)
    local mode = vim.fn.mode()
    local start_pos = vim.api.nvim_buf_get_mark(0, "<")
    local end_pos = vim.api.nvim_buf_get_mark(0, ">")

    M.stylize_range(start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2], opts.fargs[1])
  end, {
    nargs = 1,
    range = true,
    desc = "Stylize selected text (bold, italic, monospace)",
    complete = function()
      return { "bold", "italic", "monospace" }
    end,
  })

  vim.keymap.set("v", "<leader>sb", ":Stylize bold<CR>", { desc = "Stylize Bold" })
  vim.keymap.set("v", "<leader>si", ":Stylize italic<CR>", { desc = "Stylize Italic" })
  vim.keymap.set("v", "<leader>sm", ":Stylize monospace<CR>", { desc = "Stylize Monospace" })
end

return M
