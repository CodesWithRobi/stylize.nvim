local M = {}
local style_maps = require("stylize.styles").maps

function M.stylize_range(range, style)
  local map = style_maps[style]
  if not map then
    vim.notify("Stylize: unsupported style '" .. style .. "'", vim.log.levels.ERROR)
    return
  end

  local bufnr = 0
  local start_row = range.start - 1
  local end_row = range.finish

  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row, false)
  if #lines == 0 then return end

  for i, line in ipairs(lines) do
    local new_line = {}
    for c in line:gmatch(".") do
      table.insert(new_line, map[c] or c)
    end
    lines[i] = table.concat(new_line)
  end

  vim.api.nvim_buf_set_lines(bufnr, start_row, end_row, false, lines)
end

function M.setup()
  vim.api.nvim_create_user_command("Stylize", function(opts)
    local range = { start = opts.line1, finish = opts.line2 }
    M.stylize_range(range, opts.fargs[1])
  end, {
    nargs = 1,
    range = true,
    desc = "Stylize selected lines (bold, italic, monospace)",
    complete = function()
      return { "bold", "italic", "monospace" }
    end,
  })

  vim.keymap.set("v", "<leader>sb", ":'<,'>Stylize bold<CR>", { desc = "Stylize Bold" })
  vim.keymap.set("v", "<leader>si", ":'<,'>Stylize italic<CR>", { desc = "Stylize Italic" })
  vim.keymap.set("v", "<leader>sm", ":'<,'>Stylize monospace<CR>", { desc = "Stylize Monospace" })
end

return M
