-- myst_figures.lua
-- Convert standalone images in paragraphs into MyST {figure} directives,
-- preserving LaTeX math in captions.

local utils = require 'pandoc.utils'

-- Convert LaTeX-ish widths like 0.5\textwidth -> "50%"
local function width_to_pct(width)
  if not width then
    return nil
  end
  local num = width:match("([%d%.]+)\\textwidth")
             or width:match("([%d%.]+)\\\\textwidth")
  if num then
    local n = tonumber(num)
    if n then
      return string.format("%.0f%%", n * 100.0)
    end
  end
  return width
end

-- Turn a list of inlines into Markdown, keeping math as $...$ / $$...$$
local function caption_to_markdown(inlines)
  local out = {}
  for _, el in ipairs(inlines) do
    if el.t == "Math" then
      local delim = (el.mathtype == "DisplayMath") and "$$" or "$"
      table.insert(out, delim .. el.text .. delim)
    elseif el.t == "Str" then
      table.insert(out, el.text)
    elseif el.t == "Space" then
      table.insert(out, " ")
    elseif el.t == "SoftBreak" or el.t == "LineBreak" then
      table.insert(out, " ")
    else
      -- fallback for Emph, Strong, etc.
      table.insert(out, utils.stringify(el))
    end
  end
  return table.concat(out)
end

function Para(el)
  if #el.content ~= 1 then
    return el
  end

  local img = el.content[1]
  if img.t ~= "Image" then
    return el
  end

  local attr  = img.attr or img.attributes or {}
  local id    = attr.identifier or attr.id or ""
  local attrs = attr.attributes or {}
  local src   = img.src
  local caption = caption_to_markdown(img.caption or {})

  local raw_width = attrs and attrs["width"] or nil
  local width = width_to_pct(raw_width)

  local lines = {}
  table.insert(lines, "```{figure} " .. src)

  if id ~= "" then
    table.insert(lines, ":name: " .. id)
  end
  if width and width ~= "" then
    table.insert(lines, ":width: " .. width)
  end
  if caption ~= "" then
    table.insert(lines, caption)
  end

  table.insert(lines, "```")

  return pandoc.RawBlock("markdown", table.concat(lines, "\n"))
end

