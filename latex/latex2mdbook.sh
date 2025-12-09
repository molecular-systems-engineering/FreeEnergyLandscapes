#!/bin/bash
if [ $# -lt 1 ] ; then
 echo "Usage: $0  input.tex"
 exit
fi
out=`echo $1 | sed 's/\.tex/\.md/'`
#pandoc $1 --from=latex --to=gfm+tex_math_dollars --citeproc  --lua-filter=`dirname $0`/fix_mdbook_refs.lua -o $out
#pandoc $1 --from=latex --to=gfm+tex_math_dollars --citeproc  -o - | `dirname $0`/postprocess_refs.py > $out
pandoc $1 --from=latex --to=markdown+tex_math_double_backslash   --lua-filter=`dirname $0`/math_fix.lua  --citeproc   --bibliography=`dirname $1`/../additional.bib --bibliography=`dirname $1`/../zotero.bib | `dirname $0`/convert_dollars.sh  | `dirname $0`/postprocess_refs.py |  pandoc --from=markdown+citations --to=markdown --citeproc --bibliography=`dirname $1`/../additional.bib  --bibliography=`dirname $1`/../zotero.bib  > $out

