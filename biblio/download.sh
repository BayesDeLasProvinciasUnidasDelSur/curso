#!/bin/bash

if [ $# \> 0 ]
then
    sed -n "/$1/,/^}/p" bayes.bib | grep url | grep -o '{.*}' | sed  's/{/"/g' | sed 's/}/"/g' | xargs wget --adjust-extension -O pdf/$1
else
    items=$(cat bayes.bib | grep @ | awk -F '{' '{print $2}' | awk -F ',' '{print $1}')
    for i in $items
    do
        if [ ! -f "pdf/$i" ]
	then
	    sed -n "/$i/,/^}/p" bayes.bib | grep url | grep -o '{.*}' | sed  's/{/"/g' | sed 's/}/"/g' | xargs wget --adjust-extension -O pdf/$i
        fi
    done
    echo "All biblio download"
fi



