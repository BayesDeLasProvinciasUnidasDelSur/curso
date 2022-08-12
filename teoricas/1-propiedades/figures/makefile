all:
	julia main.jl

practica: pdf/simple_gamble.pdf pdf/simple_gamble_incesto.pdf

remake: clear_all all

pdf/simple_gamble_incesto.pdf:
	/usr/bin/python3 simple_gamble_incesto.py

pdf/simple_gamble.pdf:
	/usr/bin/python3 simple_gamble.py

clear_all: 
	rm *.pdf
	rm *.png
