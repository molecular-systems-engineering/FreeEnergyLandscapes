-- clean_bibliography_header.lua
-- Remove attributes from the "References" / bibliography header only.

local function has_class(el, name)
  for _, c in ipairs(el.classes) do
    if c == name then
      return true
    end
  end
  return false
end

function Header(el)
  -- Match the bibliography header that Pandoc generates
  if el.identifier == "bibliography" or el.identifier == "references" or has_class(el, "unnumbered") then
    el.identifier = ""
    el.classes = {}
    el.attributes = {}
    return el
  end

  -- anything else: leave unchanged
  return nil
end

