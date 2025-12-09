-- math_fix.lua
-- Normalize TeX subscripts inside math so Markdown doesn't turn `_x` into italics.
--
-- Examples:
--   x_i         -> x_{i}
--   \Omega_j    -> \Omega_{j}
--   already x_{i} stays as x_{i}
--   \_x (literal underscore) is NOT changed.

local function normalize_subscripts(tex)
  -- 1) Handle underscore at start: _x -> _{x}
  tex = tex:gsub("^_(%w)", "_{%1}")

  -- 2) Handle underscores preceded by a non-backslash char:
  --    a_x -> a_{x}, \_x is untouched (because of the [^\\] guard)
  tex = tex:gsub("([^\\])_(%w)", "%1_{%2}")

  return tex
end

function Math(el)
  el.text = normalize_subscripts(el.text)
  return el
end

