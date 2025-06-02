oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"), width = 8, height = 5  )
setwd(this.dir)
###############################


par(mar=c(3.75,4.25,0,0))

ICP <- 6 + arima.sim(model = list(ar = 0.75), n = 4000)
do <- c(seq(0,19.9,by=0.1) , rep(20,600) , rev(seq(0,19.9,by=0.1)))
ICP[2500:3499] <- ICP[500:1499] + do
ICP[3500:4000] <- ICP[1500:2000] + 2

plot(ICP[1:2499], type="l",lwd=2,axes = F,ann = F, xlim=c(1,4000), ylim=c(min(ICP),max(ICP)))

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Segundos", side=1, line=2.5,cex = 2)
mtext("Presión intra-craneana", side=2, line=2.5,cex = 2)



plot(ICP[1:2499], type="l",lwd=2,axes = F,ann = F, xlim=c(1,4000), ylim=c(min(ICP),max(ICP)))

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Segundos", side=1, line=2.5,cex = 2)
mtext("Presión intra-craneana", side=2, line=2.5,cex = 2)

segments(x0=0,x1=4000, y0=6,y1=6, lwd=3, lty=2, col=rgb(0.3,0.7,0.2))
text(3000,5,"Simulación",srt=0, cex=1.5)



plot(ICP, type="l",lwd=2,axes = F,ann = F)

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Segundos", side=1, line=2.5,cex = 2)
mtext("Presión intra-craneana", side=2, line=2.5,cex = 2)


segments(x0=0,x1=4000, y0=6,y1=6, lwd=3, lty=2, col=rgb(0.3,0.7,0.2))
text(3000,5,"Simulación",srt=0, cex=1.5)


plot(ICP, type="l",lwd=2,axes = F,ann = F)

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Segundos", side=1, line=2.5,cex = 2)
mtext("Presión intra-craneana", side=2, line=2.5,cex = 2)

segments(x0=3000,x1=3000, y0=6,y1=26, lwd=3, col=rgb(0.8,0.2,0.2))
text(2900,15,"Efecto Causal",srt=90, cex=1.5)

segments(x0=2900,x1=3100, y0=26,y1=26, lwd=3, col=rgb(0.8,0.2,0.2))
segments(x0=2900,x1=3100, y0=6,y1=6, lwd=3, col=rgb(0.8,0.2,0.2))

segments(x0=0,x1=4000, y0=6,y1=6, lwd=3, lty=2, col=rgb(0.3,0.7,0.2))
text(3000,5,"Simulación",srt=0, cex=1.5)



# library("CausalImpact")
# data <- cbind(ICP,rep(6,4000))
# impact <- CausalImpact(data, c(1,2499), c(2500,4000))
# plot(impact)

#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
#########################################
