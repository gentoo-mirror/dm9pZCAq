#!/bin/sed -nf

1iEGO_SUM=(

s/^\([^ ]\+\s[^ ]\+\).*/\t"\1"/p

$a)
