-- myst_clean_headers.lua
-- Converts LaTeX headers with identifiers into MyST target labels:
--   \section{Theory}\label{sec:theory}
-- =>
--   (sec:theory)=
--   # Theory

function Header(el)
  -- Apply when writing any Markdown-ish format
  if not FORMAT:match("markdown") then
    return nil
  end

  local id = el.identifier
  if not id or id == "" then
    return nil
  end

  -- Prevent pandoc from also emitting "{#id}" on the header line
  el.identifier = ""

  -- Render just this header as Markdown (preserves inline formatting in title)
  local heading_md = pandoc.write(pandoc.Pandoc({el}), "markdown")
  heading_md = heading_md:gsub("%s+$", "") -- trim trailing whitespace/newlines

  -- Emit label + header as ONE RawBlock to avoid a blank line between them
  local out = "(" .. id .. ")=\n" .. heading_md
  return pandoc.RawBlock("markdown", out)
end

