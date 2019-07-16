#!/bin/bash
sed -n "/$1/,/^}/p" bayes.bib | grep url | grep -o '{.*}' | sed  's/{/"/g' | sed 's/}/"/g' | xargs wget -O pdf/$1.pdf
