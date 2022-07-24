oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0("pdf/",nombre,".pdf"))
setwd(this.dir)
##################################################


y <- seq(-10,10,by=0.01)
p_y_contrain <- dnorm(y,0,1)
p_y_flexible <- dnorm(y,0,4)

plot(y,p_y_contrain,type="l",axes=F,xlab="",ylab="",ylim=c(-0.2,0.4),lwd=2)
lines(y,p_y_flexible,type="l",lty=2,lwd=2)
axis(side=2, at = c(0,0.1,0.2,0.3,0.4), labels=NA,cex.axis=0.6,tck=0.015)
mtext(text ="P(D|M) = Evidencia" ,side =2,line=1,cex=1.33,at = 0.2)

segments(-1.8,-0.05,-1.6,0.4,lty=3)
segments(1.8,-0.05,1.6,0.4,lty=3)
text(0,-0.025, "Ganan los\n simples",srt=0, cex=1)
text(6,-0.025, "Ganan los\n complejos",srt=0, cex=1)
text(-6,-0.025, "Ganan los\n complejos",srt=0, cex=1)

legend(2,0.3,lty = c(1,2),lwd=c(2,2),
       legend = c("Modelo simple","Modelo complejo"),bty = "n",cex = 1.2)


######
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
