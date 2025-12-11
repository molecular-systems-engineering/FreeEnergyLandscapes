-- textbox_div.lua
-- Convert Pandoc Divs representing \textbox into MyST fenced divs
--   ::: textbox    ->   :::{.textbox} ... :::

local utils = require 'pandoc.utils'

local function has_class(el, class)
  if not el.classes then return false end
  for _, c in ipairs(el.classes) do
    if c == class then return true end
  end
  return false
end


function Div(el)
  if el.identifier == "textbox" or has_class(el, "textbox") then
    -- Convert the Div's contents back to markdown
    local inner = pandoc.write(pandoc.Pandoc(el.content), "markdown")
    local s = ":::{important}\n:icon: false\n" .. inner .. "\n:::"
    return pandoc.RawBlock("markdown", s)
  end
  if el.identifier == "marginnote" or has_class(el, "marginnote") then
    -- Convert the Div's contents back to markdown
    local inner = pandoc.write(pandoc.Pandoc(el.content), "markdown")
    local s = ":::{aside}\n" .. inner .. "\n:::"
    return pandoc.RawBlock("markdown", s)
  end

  return el
end

