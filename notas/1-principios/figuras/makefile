all: tex R jl

jl:
	julia monty_hall_selection.jl

R:
	Rscript main.R

tex:
	pdflatex montyHall_0.tex
	pdflatex montyHall_1.tex
	pdflatex montyHall_2.tex
	pdflatex montyHall_3.tex
	pdflatex montyHall_4.tex
	pdflatex montyHall_5.tex
	pdflatex montyHall_6.tex
	pdflatex montyHall_7.tex
	pdflatex montyHall_8.tex
	pdflatex montyHall_model_0.tex
	pdflatex montyHall_model_1.tex
	pdflatex montyHall_model_2.tex
	pdflatex montyHall_model.tex



clean:
	- rm -f Rplots.pdf
	- rm -f *.log
	- rm -f *.soc
	- rm -f *.toc
	- rm -f *.aux
	- rm -f *.out
	- rm -f main.idx
	- rm -f *.bbl
	- rm -f *.bbg
	- rm -f *.dvi
	- rm -f *.blg
	- rm -f *.lof
	- rm -f *.nav
	- rm -f *.snm
	- rm -f *~

