oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"), width = 8, height = 5  )
setwd(this.dir)
##################################################


complejidad = seq(2, 7.3,by=0.01)



train_error = exp(-complejidad / 2)
test_error = train_error + exp(complejidad / 2 - 5)

plot(complejidad, train_error,type="l",axes=F,xlab="",ylab="",lwd=3, col=rgb(0.2,0.6,0.2))
lines(complejidad, test_error, lwd=3, col=rgb(0.8,0.2,0.2))


axis(side=1,  labels=NA,cex.axis=0.6,tck=0.015)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
mtext(text ="Error" ,side =2,line=1,cex=2)
mtext(text ="Complejidad" ,side =1,line=1,cex=2)
text(6, 0.22, "Evaluación",srt=18, cex=2, col=rgb(0.7,0.2,0.2))
text(6, 0.08, "Entrenamiento",srt=-10, cex=2, col=rgb(0.2,0.6,0.2))



######
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
