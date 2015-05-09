#!/bin/bash

function replace() {
	cat "$1" | perl -pe "${2}g" > "$1~"
	mv -f "$1~" "$1"
}

function rep_quote() {
	replace "$1" 's/\s'$2'/ ``/'
	replace "$1" 's/'$2'([\., ?!\()\n])?/'\'\''$1/'
}

NAME=`basename "$1" .txt`
TMP="$NAME.tmp"
cp "$NAME.txt" $TMP

replace $TMP 's/^\s*\* *(.*)\n+/\\people{$1}\n/'
replace $TMP 's/^\s*\- *(.*)\n+/\\soul{\1}\n/'
replace $TMP 's/^\s*\– *(.*)\n+/\\soul{\1}\n/'

rep_quote $TMP \"
rep_quote $TMP \”
rep_quote $TMP \“


#replace $TMP 's/\s"/ ``/'
#replace $TMP 's/"([\., ?!])/'\'\''$1/'

#replace $TMP 's/”([\., ?!])/'\'\''$1/'
#replace $TMP 's/\s”/ ``/'

#replace $TMP 's/\s“/ ``/'
#replace $TMP 's/“([\., ?!])/'\'\''$1/'

replace $TMP 's/»/'\'\''/'
replace $TMP 's/«/``/'

replace $TMP 's/…/.../'
replace $TMP 's/^\n//'

mv $TMP "ready/$NAME.tex"
