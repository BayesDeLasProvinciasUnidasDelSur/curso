all: montyHall_6.pdf 


china.pdf:
	Rscript main.R china.R

baseEmpirica.pdf:
	Rscript main.R baseEmpirica.R

agricultura.pdf:
	pdflatex agricultura.tex

forkingPath.pdf:
	Rscript main.R forkingPath.R

montyHall_6.pdf:
	pdflatex montyHall_0.tex
	pdflatex montyHall_1.tex
	pdflatex montyHall_2.tex
	pdflatex montyHall_3.tex
	pdflatex montyHall_4.tex
	pdflatex montyHall_5.tex
	pdflatex montyHall_6.tex



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

