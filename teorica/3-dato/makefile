pdf:
	pdflatex 3-dato.tex

full:
	make -C ../../auxiliar
	make -C figuras
	pdflatex 3-dato.tex

3-dato.jpg:
	convert -density 300 3-dato.pdf[0] -resize 100% 3-dato.jpg

