#!/bin/sh
#
# do_stats - run the typical set of stats for OpenSSL
#
# 

# https://mermaid.js.org/syntax/sankey.html
# https://github.com/mermaid-js/mermaid-cli

# https://github.com/showdownjs/showdown
# https://github.com/showdownjs/showdown/wiki/CLI-tool

# md2html.js is a wrapper script around showdown
# showdown makehtml -p github -c tables -c simplifiedAutoLink -i all-time-detail-out.md -o all-time-detail-out-2.html

MD2HTML="node $HOME/work/product_docs/scripts/md2html.js"

SHOWDOWN="showdown makehtml -p github -c tables -c simplifiedAutoLink "
MMDC="mmdc"


$SHOWDOWN -i ml-dsa-external-mu-edit.md -o ml-dsa-external-mu.html
$MMDC -i ml-dsa-external-mu-edit.md -o ml-dsa-external-mu.md

