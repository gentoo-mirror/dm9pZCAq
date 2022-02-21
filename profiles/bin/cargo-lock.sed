#!/bin/sed -nf

1iCRATES="

/^name\s\+/{$!{
	N
	s/^name\s\+=\s\+"\([^"]\+\)"\nversion\s\+=\s\+"\([^"]\+\)"$/\t\1-\2/p
}}

$a\\t${P}
$a"
