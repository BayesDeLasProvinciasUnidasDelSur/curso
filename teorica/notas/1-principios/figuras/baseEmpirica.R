###########################################
# Header
oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"))
setwd(this.dir)
#setwd("~/Desktop/genEx/imagenes/")
#####################################

par(mar=c(0.3,0.3,0.3,0.3))



elipse <- function(x,x0=0, y0=0, a=1.5, b=1){
  y1 = sqrt((1 -  ((x-x0)^2)/(a^2))*(b^2))+y0
  y2 = y0 - sqrt((1 -  ((x-x0)^2)/(a^2))*(b^2))
  return(list("y1"=y1,"y2"=y2)) 
}

draw.elipse <- function(a,b=1,x0=0,y0=0,fill=F,col=rgb(0,0,0),...){
  x <- seq(-a+x0,a+x0,by=0.01)
  y <- elipse(x,a=a,b=b,x0=x0,y0=y0)
  lines(x,y$y1,...)
  lines(x,y$y2,...)
  if(fill){
    polygon(c(x,rev(x)),c(y$y1,rep(0,length(y$y1))),col=col,border=F )
    polygon(c(x,rev(x)),c(y$y2,rep(0,length(y$y2))),col=col,border=F )
  }
}

plot(0,0,type="l",ylim=c(-5,5),xlim=c(-2,8) ,ylab = "",xlab="",axes=F)
draw.elipse(a=0.5,b=0.5,x0=0,fill=T,lwd=2)
draw.elipse(a=2,b=1,x0=1, lwd=2, fill=T, col=rgb(0,0,0,0.2))
draw.elipse(a=3.5,b=1.5,x0=2, fill=T, col=rgb(0,0,0,0.2),  lwd=2)
draw.elipse(a=5,b=2,x0=3,lwd=2)
text(1.5,0.0,expression(MEB[1]),cex=1.5)
text(4,0.0,expression(MEB[2]),cex=1.5)
text(6.5,0.0,expression(TD),cex=1.5)
text(0,0,expression(EEB),cex=1.5,col=rgb(0.85,0.85,0.85))

plot(0,0,type="l",ylim=c(-5,5),xlim=c(-2,8) ,ylab = "",xlab="",axes=F)
draw.elipse(a=0.5,b=0.5,x0=0,fill=T,lwd=2)
draw.elipse(a=2,b=1,x0=1, lwd=2, fill=T, col=rgb(0,0,0,0.2))
draw.elipse(a=3.5,b=1.5,x0=2, fill=T, col=rgb(0,0,0,0.2),  lwd=2)
draw.elipse(a=5,b=2,x0=3,lwd=2)
text(1.5,0.0,expression(BEM[1]),cex=1.5)
text(4,0.0,expression(BEM[2]),cex=1.5)
text(6.5,0.0,expression(DT),cex=1.5)
text(0,0,expression(BEE),cex=1.5,col=rgb(0.85,0.85,0.85))

plot(0,0,type="l",ylim=c(-5,5),xlim=c(-2,8) ,ylab = "",xlab="",axes=F)
draw.elipse(a=0.66,b=0.66,x0=0,fill=T,lwd=2, col=rgb(0.15,0.15,0.15))
draw.elipse(a=2,b=1,x0=1, fill=T, col=rgb(0,0,0,0.2), lwd=2)
draw.elipse(a=3.5,b=1.5,x0=2, lwd=2)
text(1.5,0.0,"Skill",cex=1.5)
text(4.15,0.0,"Life history",cex=1.5)
text(0,0,"Result",cex=1.5,col=rgb(1,1,1))



#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
system(paste0("pdfcrop --margins '0 0 0 0' ",nombre,".pdf ",nombre,".pdf"))
#########################################

