oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"), width = 8, height = 5 )
setwd(this.dir)
##################################################

N <- 10
logN <- log(seq(10))

plot(logN, pch=19,   axes=F, xlab="", ylab="", lwd=3, xlim=c(0,11))
axis(side=1, labels=NA,at=seq(0,N+1), cex.axis=0.6,tck=0.015)
axis(side=2, labels=NA, cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=seq(N),cex.axis=1.5,line=-0.45)
mtext(text ="log k" ,side =2 ,line=0.5,cex=1.5)


plot(logN, pch=19,   axes=F, xlab="", ylab="", lwd=3, xlim=c(0,11))
lines(logN, lwd=1)
axis(side=1, labels=NA,at=seq(0,N+1), cex.axis=0.6,tck=0.015)
axis(side=2, labels=NA, cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=seq(N),cex.axis=1.5,line=-0.45)
mtext(text ="log k" ,side =2 ,line=0.5,cex=1.5)

for (k in seq(1,10)){
    polygon(c(k-0.5,k+0.5,k+0.5,k-0.5),c(0,0,log(k),log(k)),  col=rgb(0,0,0,0.3))
}


######
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
