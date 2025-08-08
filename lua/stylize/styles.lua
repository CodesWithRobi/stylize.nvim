local M = {}

local function map_range(start_char, unicode_start)
  local map = {}
  for i = 0, 25 do
    map[string.char(start_char + i)] = vim.fn.nr2char(unicode_start + i)
  end
  return map
end

local function map_numbers(unicode_start)
  local map = {}
  for i = 0, 9 do
    map[tostring(i)] = vim.fn.nr2char(unicode_start + i)
  end
  return map
end

M.maps = {
  bold = vim.tbl_extend("force",
    map_range(65, 0x1D400),
    map_range(97, 0x1D41A),
    map_numbers(0x1D7CE)
  ),

  italic = vim.tbl_extend("force",
    map_range(65, 0x1D434),
    map_range(97, 0x1D44E)
  ),

  bold_italic = vim.tbl_extend("force",
    map_range(65, 0x1D468),
    map_range(97, 0x1D482)
  ),

  monospace = vim.tbl_extend("force",
    map_range(65, 0x1D670),
    map_range(97, 0x1D68A),
    map_numbers(0x1D7F6)
  )
}

return M

