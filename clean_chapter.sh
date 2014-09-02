#!/bin/bash

function replace() {
	cat "$1" | perl -pe "${2}g" > "$1~"
	mv -f "$1~" "$1"
}

function rep_quote() {
	replace "$1" 's/\s'$2'/ ``/'
	replace "$1" 's/'$2'([\., ?!\()])/'\'\''$1/'
}

NAME=`basename "$1" .txt`
cp "$NAME.txt" "$NAME.tmp"

replace "$NAME.tmp" 's/^\s*\* *(.*)\n+/\\people{$1}\n/'
replace "$NAME.tmp" 's/^\s*\- *(.*)\n+/\\soul{\1}\n/'
replace "$NAME.tmp" 's/^\s*\– *(.*)\n+/\\soul{\1}\n/'

rep_quote "$NAME.tmp" \"
rep_quote "$NAME.tmp" \”
rep_quote "$NAME.tmp" \“


#replace "$NAME.tmp" 's/\s"/ ``/'
#replace "$NAME.tmp" 's/"([\., ?!])/'\'\''$1/'

#replace "$NAME.tmp" 's/”([\., ?!])/'\'\''$1/'
#replace "$NAME.tmp" 's/\s”/ ``/'

#replace "$NAME.tmp" 's/\s“/ ``/'
#replace "$NAME.tmp" 's/“([\., ?!])/'\'\''$1/'

replace "$NAME.tmp" 's/»/'\'\''/'
replace "$NAME.tmp" 's/«/``/'

replace "$NAME.tmp" 's/…/.../'
replace "$NAME.tmp" 's/^\n//'

mv "$NAME.tmp" "$NAME.tex"
