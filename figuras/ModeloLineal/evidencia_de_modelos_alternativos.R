oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0("pdf/",nombre,".pdf"),width = 8, height = 5 )
setwd(this.dir)
##################################################


par(mar=c(4,4,0,0))

y <- seq(-15,13,by=0.01)
p_y_contrain <- dnorm(y,0,1)
p_y_flexible <- dnorm(y,0,4)
p_y_rigido <- dnorm(y,-13,0.4)

plot(y,p_y_rigido,type="l",axes=F,xlab="",ylab="",lty=4,lwd=2)
lines(y,p_y_flexible,type="l",lty=2,lwd=2)
lines(y,p_y_contrain,type="l",lwd=2)
axis(side=2, at = seq(0,1,by=0.2), labels=NA,cex.axis=0.6,tck=0.015)
mtext(text =expression("P("~y[N]~"|"~x[N]~"=0.1,"~M[D]~")") ,side =2,line=1,cex=1.5,at = 0.5)
mtext(text =expression(y[N]) ,side =1,line=1,cex=1.5,at = 0)


segments(-1.8,-0.05,-1.8,1,lty=3)
segments(1.8,-0.05,1.8,1,lty=3)
segments(-11.6,-0.05,-11.6,1,lty=3)
text(0,0.5, "Gana \nsimple",srt=0, cex=1.5)
text(5,0.5, "Gana \ncomplejo",srt=0, cex=1.5)
text(-5,0.5, "Gana \ncomplejo",srt=0, cex=1.5)

legend(3,1,lty = c(1,2,4),lwd=c(2,2,1),
       legend = c(expression("Simple"~M[3]),expression("Complejo"~M[9]), expression("Rígido"~M[1])),bty = "n",cex = 1.5)


######
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0("pdf/",nombre,".pdf") ,paste0("pdf/",nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
