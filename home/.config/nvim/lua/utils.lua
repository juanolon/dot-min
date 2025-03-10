local mathmode = require('treesitter/mathmode')

-- TODO use some config..
local use_treesiter = true

-- TODO update to vim.keymap.set("v", "<Tab>", ">gv", {remap=true})
local M = {}
function M.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.in_mathzone()
    if use_treesiter then
        return mathmode.in_mathzone()
    end
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

function M.in_comment()
    if use_treesiter then
        return mathmode.in_comment()
    end
    return vim.fn["vimtex#syntax#in_comment"]() == 1
end

function M.in_text()
  if use_treesiter then
    return mathmode.in_text(true)
  end

  return not M.in_mathzone()
end

function M.no_backslash(line_to_cursor, matched_trigger)
  return not line_to_cursor:find("\\%a+$", -#line_to_cursor)
end


function M.pipe(fns)
  return function(...)
    for _, fn in ipairs(fns) do
      if not fn(...) then
        return false
      end
    end

    return true
  end
end

function M.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. M.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

return M
