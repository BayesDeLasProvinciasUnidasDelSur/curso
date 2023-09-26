RELEASE/2023.1/0-programa.pdf:
	make -C RELEASE/2023.1/

source:
	git remote set-url origin git@git.exactas.uba.ar:bayes/seminario.git

mirror:
	git remote set-url --add origin git@github.com:BayesDeLasProvinciasUnidasDelSur/curso.git
