all: pdf png

pdf: R python tex

R:
	Rscript main.R

python: pdf/example1.pdf pdf/example2.pdf

tex: linearModel 

pdf/example1.pdf:
	python3 example1.py
	echo "Done" pdf/example1.pdf

pdf/example2.pdf:
	python3 example2.py
	echo "Done" pdf/example2.pdf

linearModel: pdf/linearModel.pdf clean_tex

pdf/linearModel.pdf:
	pdflatex -output-directory=pdf/ linearModel.tex 
	
png: 
	# "If you have problems with 'convert', verify your rights in the ImageMagick policy.xml file.
	# "If you don't know how to solve it, run:"
	# "sudo mv /etc/<ImageMagick-path>/policy.xml /etc/<ImageMagick-path>/policy.xml.off"
	- rm -f png/*
	- convert -density 75 pdf/*  -set filename:fname '%t' 'png/%[filename:fname].png'

clean_img:
	- rm -f pdf/*
	- rm -f png/*

clean_tex: 
	- rm -f pdf/*.log
	- rm -f pdf/*.soc
	- rm -f pdf/*.toc
	- rm -f pdf/*.aux
	- rm -f pdf/*.out
	- rm -f pdf/main.idx
	- rm -f pdf/*.bbl
	- rm -f pdf/*.bbg
	- rm -f pdf/*.dvi
	- rm -f pdf/*.blg
	- rm -f pdf/*.lof
	- rm -f pdf/*.nav
	- rm -f pdf/*.snm
	- rm -f pdf/*~


