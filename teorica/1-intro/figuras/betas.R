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

#
k1 <- 10
n1 <- 10
k2 <- 96/2
n2 <- 50
k3 <- 93*2
n3 <- 200

p <- seq(-1,1,by=0.001)
plot(p,dbeta(p,k3+1,n3-k3+1) , type="l", axes=F, xlab="", ylab="", lwd=3, col=rgb(0.2,0.4,0.8), xlim=c(0.60,1))
lines(p,dbeta(p,k2+1,n2-k2+1) , lwd=3, col=rgb(0.7,0.4,0.3))
lines(p,dbeta(p,k1+1,n1-k1+1) , lwd=3, col=rgb(0.4,0.7,0.4))
abline(v=1,lty=3,col=rgb(0,0,0,0.4))


axis(side=4, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA, at=seq(0.6,1,by=0.1), cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=seq(0.6,1,by=0.1),cex.axis=1.5,line=-0.45)

legend(0.6,20,pch=19, legend=c("100%, n=10", "  96%, n=50", "  93%, n=200"),col=rev(c(rgb(0.2,0.4,0.8), rgb(0.7,0.4,0.3), rgb(0.4,0.7,0.4))),  bty = "n",cex = 1.75,)

#mtext(text ="p" ,side =1 ,line=1.5,cex=1.5)



######
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
