all:
	pdflatex -interaction=nonstopmode main.tex

compile: pdf clean
	
pdf: 
	pdflatex main.tex
	pdflatex main.tex
	pdflatex main.tex
	pdflatex main.tex

clean: 
	@echo "Cleaning..."	
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
	- rm -f *~
