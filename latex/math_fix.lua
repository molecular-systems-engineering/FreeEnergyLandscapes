-- math_fix.lua
-- Inside math, escape all underscores so Markdown doesn't treat them as emphasis.
-- Example:
--   x_i       -> x\_i
--   x_{i}     -> x\_{i}
--   \_i       -> \_i (already escaped, left alone)

function Math(el)
  local t = el.text

  -- Escape '_' that are not already escaped
  -- 1) Leading '_'
  t = t:gsub("^_", "\\_")
  -- 2) '_' preceded by a non-backslash
  t = t:gsub("([^\\])_", "%1\\_")

  el.text = t
  return el
end

