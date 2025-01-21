oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"), width = 8, height = 5  )
setwd(this.dir)
###############################

par(mar=c(3.75,4.25,0.5,0.5))

Q_c = 3
Q_s = 1.2
p = 0.5

laverage_grilla = seq(0,1,by=0.01)

tasa_de_crecimiento <- function(Q, p, l){
    # (1-l)^(1-p) * ((1-l) + l*Q)^p
    return ((1-l)^(1-p) * ((1-l) + l*Q)^p )
}

col_cara =  rgb(0.3,0.6,0.3)
col_sello = rgb(0.6,0.3,0.3)

plot(laverage_grilla, tasa_de_crecimiento(Q_c, p, laverage_grilla), type="l", lwd=3, col=col_cara,  axes = F,ann = F )
lines(laverage_grilla, tasa_de_crecimiento(Q_s, (1-p),laverage_grilla), col=col_sello, lwd=3 )
abline(v=0.25, lty=2)
abline(h=1, lty=2)

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1,labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,at = c(0,1), side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,at = c(0.25), side=1,cex.axis=1.25,line=-0.3)
axis(lwd=0,at = c(0,1),side=2,cex.axis=1.5,line=-0.3)
axis(lwd=0,at = c(round(max(tasa_de_crecimiento(Q_c, p, laverage_grilla)),3) ),side=2,cex.axis=1.25,line=-0.3,las=1)
mtext("Laverage", side=1, line=2.5,cex = 2)
mtext("Tasa de crecimiento", side=2, line=2.5,cex = 2)


legend(0.5,0.35,pch=19,legend = c("Cara", "Sello"),bty = "n",cex = 1.5, col=c(col_cara,col_sello))






#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
#########################################
