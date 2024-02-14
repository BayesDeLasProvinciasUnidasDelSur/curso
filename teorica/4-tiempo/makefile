pdf:
	pdflatex 4-tiempo.tex

full:
	make -C ../../auxiliar
	make -C figuras
	pdflatex 4-tiempo.tex

4-tiempo.jpg:
	convert -density 300 4-tiempo.pdf[0] -resize 100% 4-tiempo.jpg

