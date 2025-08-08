local M = {}
local style_maps = require("stylize.styles").maps

function M.stylize_visual(style)
  local map = style_maps[style]
  if not map then
    vim.notify("Stylize: unsupported style '" .. style .. "'", vim.log.levels.ERROR)
    return
  end

  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2]-1, end_pos[2], false)
  if #lines == 0 then return end

  lines[1] = string.sub(lines[1], start_pos[3])
  lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])

  for i, line in ipairs(lines) do
    local new_line = {}
    for c in line:gmatch(".") do
      table.insert(new_line, map[c] or c)
    end
    lines[i] = table.concat(new_line)
  end

  vim.api.nvim_buf_set_text(
    0,
    start_pos[2]-1, start_pos[3]-1,
    end_pos[2]-1, end_pos[3],
    lines
  )
end

function M.setup()
  vim.api.nvim_create_user_command("Stylize", function(opts)
    M.stylize_visual(opts.args)
  end, {
    nargs = 1,
    range = true,
    desc = "Stylize visual text (bold, italic, etc.)"
  })

  vim.keymap.set("v", "<leader>sb", ":<C-u>Stylize bold<CR>", { desc = "Stylize Bold" })
  vim.keymap.set("v", "<leader>si", ":<C-u>Stylize italic<CR>", { desc = "Stylize Italic" })
  vim.keymap.set("v", "<leader>sm", ":<C-u>Stylize monospace<CR>", { desc = "Stylize Monospace" })
end

return M
