all: R julia

R:
	/usr/bin/Rscript main.R
	- rm Rplots.pdf

julia:
	julia monty_hall_selection.jl

tex:
	for i in $(shell ls *.tex); do pdflatex $$i;done

python:
	for i in $(shell ls *.py); do python3 $$i;done

