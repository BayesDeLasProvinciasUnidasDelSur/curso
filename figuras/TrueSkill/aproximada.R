###########################################
# Header
oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"),width = 8, height = 5  )
setwd(this.dir)
#setwd("~/gaming/materias/inferencia_bayesiana/trabajoFinal/imagenes")
#####################################

par(mar=c(5,3.75,.75,.75))

xs <- seq(-3,4,by=0.01)
#N(mu=1.288, sigma=0.794)



plot(xs,dnorm(xs,1,1), type="l",lwd=1,axes = F,ann = F, ylim=c(0,max(dnorm(xs,1.288, 0.794))))


axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, las=0,cex.axis=1.5,line=-0.6)

mtext(text ="P( Diferencia | Gana )" ,side =2 ,line=1,cex=1.75)
mtext(text ="Diferencia",side =1 ,line=1.75,cex=2)
abline(v=1, lty=3)

legend(-3.3,max(dnorm(xs,1.288, 0.794)), bty = "n", cex=1.5, lty=c(1), lwd=1 , legend = c("Prior exacto"))


plot(xs,(xs>0)*dnorm(xs,1,1)/(1-pnorm(0,1,1)), type="l",lwd=3,axes = F,ann = F,ylim=c(0,max(dnorm(xs,1.288, 0.794))))
lines(xs,dnorm(xs,1,1))



axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, las=0,cex.axis=1.5,line=-0.6)

mtext(text ="P( Diferencia | Gana )" ,side =2 ,line=1,cex=1.75)
mtext(text ="Diferencia",side =1 ,line=1.75,cex=2)
abline(v=1, lty=3)

legend(-3.3,max(dnorm(xs,1.288, 0.794)), bty = "n", cex=1.5, lty=c(1,1), lwd=c(1,3) , legend = c("Prior exacto", "Posterior exacto"))

plot(xs,dnorm(xs,1.288, 0.794), type="l",lwd=3,axes = F,ann = F,lty=2, ylim=c(0,max(dnorm(xs,1.288, 0.794))))
lines(xs,(xs>0)*dnorm(xs,1,1)/(1-pnorm(0,1,1)), lty=1,lwd=3)
lines(xs,dnorm(xs,1,1))

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, las=0,cex.axis=1.5,line=-0.6)
abline(v=1, lty=3)

mtext(text ="P( Diferencia | Gana )" ,side =2 ,line=1,cex=1.75)
mtext(text ="Diferencia",side =1 ,line=1.75,cex=2)

legend(-3.3,max(dnorm(xs,1.288, 0.794)), bty = "n", cex=1.5, lty=c(1,1,2), lwd=c(1,3,3) , legend = c("Prior exacto", "Posterior exacto", "Posterior aproximado"))

#######################################
# end 
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
#########################################
