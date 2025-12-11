#!/bin/bash
if [ $# -lt 1 ] ; then
 echo "Usage: $0  input.tex"
 exit
fi
out=`echo $1 | sed 's/\.tex/\.md/'`
echo 'converting to '$out
#pandoc $1 --from=latex --to=gfm+tex_math_dollars --citeproc  --lua-filter=`dirname $0`/fix_mdbook_refs.lua -o $out
#pandoc $1 --from=latex --to=gfm+tex_math_dollars --citeproc  -o - | `dirname $0`/postprocess_refs.py > $out
# pandoc $1 --from=latex --to=markdown+tex_math_double_backslash  --citeproc  --reference-location=block --bibliography=`dirname $1`/../additional.bib  --bibliography=`dirname $1`/../zotero.bib --metadata reference-section-title="References" --lua-filter=`dirname $0`/math_fix.lua  | `dirname $0`/convert_dollars.sh  | `dirname $0`/postprocess_refs.py |  pandoc --from=markdown --to=markdown   > $out
sed 's/\\,/ /g' $1 | pandoc  --from=latex  --to=markdown+tex_math_double_backslash  --citeproc  --reference-location=block --bibliography=`dirname $1`/../additional.bib  --bibliography=`dirname $1`/../zotero.bib --metadata reference-section-title="References" --lua-filter=`dirname $0`/textbox_div.lua --lua-filter=`dirname $0`/myst_figures.lua  > $out

