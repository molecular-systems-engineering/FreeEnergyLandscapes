-- entry.lua
-- Turn \entry{...} into **...** when converting from LaTeX to Markdown.

-- Parse the LaTeX inside { ... } so inner markup (\emph, math, etc.) survives.
local function latex_to_inlines(s)
  io.stderr:write("entry.lua matched entry***********************************************\n")
  local doc = pandoc.read(s, "latex")
  local first = doc.blocks[1]
  if first and (first.t == "Para" or first.t == "Plain") then
    return first.content
  end
  return { pandoc.Str(s) }
end

local function handle_raw_inline(el)
  -- Only care about raw TeX/LaTeX inlines
  if el.format ~= "tex" and el.format ~= "latex" then
    return nil
  end

  local s = el.text
  local out = {}
  local last = 1
  local changed = false

  while true do
    -- find \entry{...} (non-greedy inside braces)
    local i, j, content = s:find("\\entry%s*{(.-)}", last)
    if not i then break end

    -- stuff before \entry
    if i > last then
      table.insert(out, pandoc.RawInline(el.format, s:sub(last, i - 1)))
    end

    -- bold version of the argument
    table.insert(out, pandoc.Strong(latex_to_inlines(content)))
    changed = true
    last = j + 1
  end

  if not changed then
    return nil -- no \entry here → leave element unchanged
  end

  -- trailing text after last \entry
  if last <= #s then
    table.insert(out, pandoc.RawInline(el.format, s:sub(last)))
  end

  return out
end

return {
  { RawInline = handle_raw_inline }
}




