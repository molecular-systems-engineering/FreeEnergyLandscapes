#!/bin/bash
if [ $# -lt 1 ] ; then
 echo "Usage: $0  input.tex"
 exit
fi
out=`echo $1 | sed 's/\.tex/\.md/'`
echo 'converting to '$out
sed -e 's/\\,/ /g'  -e 's/\\entry/\\textbf/g' $1 | pandoc  --from=latex --to=markdown+tex_math_double_backslash  --citeproc  --reference-location=block --bibliography=`dirname $1`/additional.bib  --bibliography=`dirname $1`/zotero.bib --metadata reference-section-title="References" --lua-filter=`dirname $0`/pretty_refs.lua  --lua-filter=`dirname $0`/textbox_div.lua --lua-filter=`dirname $0`/myst_figures.lua --lua-filter=`dirname $0`/clean_bibliography_header.lua  --lua-filter=`dirname $0`/clean_header_labels.lua > $out

