-- pretty_refs.lua
-- Replace \ref{sec:...} with a link whose text is the section title.

local headers = {}

-- Collect section titles by their identifiers
function Header(el)
  if el.identifier and el.identifier ~= "" then
    headers[el.identifier] = pandoc.utils.stringify(el.content)
  end
end

function Link(el)
  if el.attributes["reference-type"] == "ref" then
    local refid = el.attributes["reference"]

    -- drop Pandoc's extra attributes so no {...} appears in Markdown
    el.attributes = {}

    local title = headers[refid]
    if title then
      -- Use the header text as the link text
      el.content = { pandoc.Str(title) }
    else
      -- fallback: just show the label itself (sec:Computing)
      el.content = { pandoc.Str(refid) }
    end

    return el
  end

  return nil
end

