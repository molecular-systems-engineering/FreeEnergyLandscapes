-- fix_mdbook_refs.lua
-- Convert HTML anchors like
--   <a href="#sec:Theory" data-reference-type="ref" ...>[sec:Theory]</a>
-- into Markdown links [sec:Theory](#sec:Theory)

function RawInline(el)
  if el.format ~= "html" then
    return nil
  end

  -- Match anchors with href="#...":
  local href, text = el.text:match('<a%s+[^>]-href="#([^"]+)"[^>]*>(.-)</a>')
  if not href then
    return nil
  end

  -- Clean inner text
  local label = text:gsub("%s+", " ")
  label = label:gsub("^%s*%[", ""):gsub("%]%s*$", "")  -- drop surrounding [ ]

  return pandoc.Link({ pandoc.Str(label) }, "#" .. href)
end

