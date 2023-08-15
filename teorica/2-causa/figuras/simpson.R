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
 par(mar=c(3,3,0,0))
set.seed(0)

N = 200
sismoA = rnorm(N,6,1)
sismoB = rnorm(N,4,1)
sismoC = rnorm(N,2,1)
derrumbesA = sismoA + rnorm(N,0,1.8) - 8
derrumbesB = sismoB + rnorm(N,0,1.8) - 4
derrumbesC = sismoC + rnorm(N,0,1.8) - 0
sismos = c(sismoA, sismoB, sismoC)
derrumbes = c(derrumbesA,derrumbesB,derrumbesC)


plot(sismoA,derrumbesA, xlim=c(min(sismos),max(sismos)), ylim=c(min(derrumbes),max(derrumbes)) ,pch=19,axes=F, xlab="", ylab="", col=rgb(0,0,0,0.5))
points(sismoB,derrumbesB, pch=19,col=rgb(0,0,0,0.5))
points(sismoC,derrumbesC, pch=19,col=rgb(0,0,0,0.5))

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,  cex.axis=0.6,tck=0.015)
mtext(text ="Derrumbes" ,side =2 ,line=1.5,cex=1.75)
mtext(text ="Intensidad del sismo" ,side =1 ,line=1.5,cex=1.75)
# abline(h=1,lty=3)
# abline(h=0,lty=3)

abline(summary(lm(derrumbes  ~ sismos)), lwd=3 )


plot(sismoA,derrumbesA, xlim=c(min(sismos),max(sismos)), ylim=c(min(derrumbes),max(derrumbes)) ,pch=19,axes=F, xlab="", ylab="", col=rgb(0.3,0.3,0.7,0.6))
points(sismoB,derrumbesB, pch=19,col=rgb(0.3,0.7,0.3,0.6))
points(sismoC,derrumbesC, pch=19,col=rgb(0.7,0.3,0.3,0.6))


axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,  cex.axis=0.6,tck=0.015)
mtext(text ="Derrumbes" ,side =2 ,line=1.5,cex=1.75)
mtext(text ="Intensidad del sismo" ,side =1 ,line=1.5,cex=1.75)
# abline(h=1,lty=3)
# abline(h=0,lty=3)

abline(summary(lm(derrumbesA  ~ sismoA)), lwd=3, col=rgb(0.3,0.3,0.7))
#abline(a=-8,b=1, lwd=3, col=rgb(0.3,0.3,0.7))
#abline(a=-4,b=1, lwd=3, col=rgb(0.3,0.7,0.3))
abline(summary(lm(derrumbesB  ~ sismoB)), lwd=3, col=rgb(0.3,0.7,0.3))
#abline(a=0,b=1, lwd=3, col=rgb(0.7,0.3,0.3))
abline(summary(lm(derrumbesC  ~ sismoC)), lwd=3, col=rgb(0.7,0.3,0.3))





######
dev.off()
#system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
