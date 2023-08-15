oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
nom <-paste0(nombre,".pdf")
pdf(nom,width = 8, height = 5 )
##############################

grilla <- seq(-6,6,0.05)

laplace <- function(x,mu,b){
  return( (1/(2*b)) * exp( -abs(x-mu)/b )   )
} 



plot(grilla, laplace(grilla,0,1),type="l",col=rgb(0.75,0,0.25,1)
     ,axes=F,ylab="",xlab="",lwd=2)
points(grilla, dnorm(grilla,0,1),type="l",col=rgb(0,0.75,0.25,1),lwd=2)
points(grilla, dt(grilla,3),type="l",col=rgb(0,0.33,0.66,1),lwd=2,lty=2)
axis(1)

legend(0.6,laplace(0,0,1),col = c(rgb(0.75,0,0.25,1),rgb(0,0.75,0.25,1),rgb(0,0.33,0.66,1)),legend = c("Laplace distribution", "Normal distribution","Student distribution 3 DF"),bty="n",cex=1.25,lwd=2,lty=c(1,1,2))

##############333
dev.off()
setwd(oldwd)
par(oldpar, new=F)
system(paste("pdfcrop --margins '0 0 0 0' ",nom,nom))