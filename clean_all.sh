#!/bin/bash

find . -name "*.txt" -print0 | while read -d $'\0' file
do
  ./clean_chapter.sh "$file"
done