pdf:
	pdflatex 1-intro.tex

fig:
	make -C makefile

full: 
	make -C ../../auxiliar
	make -C figuras
	pdflatex 1-intro.tex


1-intro.jpg:
	convert -density 300 1-intro.pdf[0] -resize 100% 1-intro.jpg
