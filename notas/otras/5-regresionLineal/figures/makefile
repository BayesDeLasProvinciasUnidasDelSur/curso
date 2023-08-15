all: R julia python

R:
	/usr/bin/Rscript main.R
	- rm Rplots.pdf

julia:
	for i in $(shell ls *.jl); do julia $$i;done

python:
	for i in $(shell ls *.py); do python3 $$i;done

