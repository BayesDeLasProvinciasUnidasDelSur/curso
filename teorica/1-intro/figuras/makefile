all: R tex python julia

R:
	/usr/bin/Rscript main.R
	- rm Rplots.pdf

tex:
	for i in $(shell ls *.tex); do pdflatex $$i;done

python:
	for i in $(shell ls *.py); do python3 $$i;done

julia:
	julia monty_hall_selection.jl
