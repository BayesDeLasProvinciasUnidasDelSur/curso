# Seminario grupo bayes exactas-UBA 

Manual de uso de git https://git-scm.com/book/en/v2

## Prácticas de uso

### ```.gitignore```

**Atención**: El archivo ```.gitignore``` ignora *TODOS* los archivos *SALVO* algunas extensiones específicas a archivos fuentes. 

QUEREMOS: Solo archivo de código fuente. Si actualemnte está siendo ignorado un archivo fuente, agregarlo en el ```.gitignore```.

NO QUEREMOS: pdf, imágenes, datos, archivos "office" (.doc .docx .odt), muchos etceteras.

### Buenas prácticas

- *Antes de empezar a trabajar:* hacer ``` git pull origin master```. 

- *Al terminar de trabajar:* hacer un ``` git commit``` e inmediatemente compartirlo con el resto con ``` git push origin master```. 

##### ```git pull --rebase```

**Recomendación:** Antes de hacer ``` push ``` se recomienda hacer ```git pull --rebase```, para traer eventuales modificaciones que hayan ocurrido en el ```origin``` no vistas previamente.
De esta forma, los conflictos se recuelven localmente.

##### ```.bib```

**Reglas de estilo**: las claves de las citas del archivo ``` .bib``` se espera que sigan el siguiente esquema: 

`
    apellido1999-resumenDelTitulo
`

### ```biblio/```

Estructura:

- ```bayes.bib```
- ```pdf.sh```
- ```pdf/```

El archivo ``` pdf.sh``` requiere como parámetro una clave del archivo ``` bayes.bib``` y descarga en el carpeta ``` pdf/``` el archivo especificado en el item ``` url={}```



