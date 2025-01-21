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

set.seed(999)
trayectoria_cooperativa <- function(d=0,n=33,t=1000, reproduccion=1.5, supervivencia=0.6){
    res = matrix(nrow=n,ncol=t+1)
    res[,1] = 1.0
    i=2
    while (i <= t+1){
        cpr = sum(res[1:(n-d),i-1]) *(1/n)
        for (a in seq(n)){
            r = rbinom(0.5,n=1,size=1)
            if (r==0){
                rate = reproduccion
            }else{
                rate = supervivencia
            }
            if (a<=n-d){
                res[a,i] = cpr*rate
            }else{
                res[a,i] = (cpr+res[a,i-1])*rate
            }
        }
        i = i + 1
    }
    return(res)
}

data0 = trayectoria_cooperativa()
data1 = trayectoria_cooperativa(d=1)
data2 = trayectoria_cooperativa(d=2)



plot(log(data0[1,]), type="l",lwd=3, axes = F,ann = F, col=rgb(0.3,0.6,0.3,1), ylim=c(log(0.948)*1000,log(1.05)*1000))
segments(x0=1,x1=1001,y0=0,y1=log(1.05)*1000, lty=2)
segments(x0=1,x1=1001,y0=0,y1=log(0.6^(1/2)*1.5^(1/2))*1000, lty=2)


axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1,labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("log Riqueza", side=2, line=2.5,cex = 2)

legend(10,50,pch=19,legend = c("0 desertores"), col=c(rgb(0.3,0.6,0.3,1)),bty = "n",cex = 1.5)



plot(log(data0[1,]), type="l",lwd=3, axes = F,ann = F, col=rgb(0.3,0.6,0.3,1), ylim=c(log(0.948)*1000,log(1.05)*1000))
lines(log(data1[1,]),col=rgb(0.2,0.3,0.7,1),lwd=3)
lines(log(data1[33,]),col=rgb(0.2,0.3,0.7,1),lwd=1.5)
segments(x0=1,x1=1001,y0=0,y1=log(1.05)*1000, lty=2)
segments(x0=1,x1=1001,y0=0,y1=log(0.6^(1/2)*1.5^(1/2))*1000, lty=2)


axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1,labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("log Riqueza", side=2, line=2.5,cex = 2)

legend(10,50,pch=19,legend = c("0 desertores","1 desertor"), col=c(rgb(0.3,0.6,0.3,1), rgb(0.2,0.3,0.7,1)),bty = "n",cex = 1.5)



plot(log(data0[1,]), type="l",lwd=3, axes = F,ann = F, col=rgb(0.3,0.6,0.3,1), ylim=c(log(0.948)*1000,log(1.05)*1000))
lines(log(data1[1,]),col=rgb(0.2,0.3,0.7,1),lwd=3)
lines(log(data1[33,]),col=rgb(0.2,0.3,0.7,1),lwd=1.5)
lines(log(data2[1,]),col=rgb(0.7,0.3,0.2,1),lwd=3)
lines(log(data2[32,]),col=rgb(0.7,0.3,0.2,1),lwd=1.5)
lines(log(data2[33,]),col=rgb(0.7,0.3,0.2,1),lwd=1.5)
segments(x0=1,x1=1001,y0=0,y1=log(1.05)*1000, lty=2)
segments(x0=1,x1=1001,y0=0,y1=log(0.6^(1/2)*1.5^(1/2))*1000, lty=2)


axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1,labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("log Riqueza", side=2, line=2.5,cex = 2)

legend(10,50,pch=19,legend = c("0 desertores","1 desertor","2 desertores"), col=c(rgb(0.3,0.6,0.3,1), rgb(0.2,0.3,0.7,1), rgb(0.7,0.3,0.2,1)),bty = "n",cex = 1.5)


plot(log(data0[1,]), type="l",lwd=3, axes = F,ann = F, col=rgb(0.3,0.6,0.3,1), ylim=c(log(0.948)*1000,log(1.05)*1000))
lines(log(data1[1,]),col=rgb(0.2,0.3,0.7,1),lwd=3)
lines(log(data1[33,]),col=rgb(0.2,0.3,0.7,1),lwd=1.5)
lines(log(data2[1,]),col=rgb(0.7,0.3,0.2,1),lwd=3)
lines(log(data2[32,]),col=rgb(0.7,0.3,0.2,1),lwd=1.5)
lines(log(data2[33,]),col=rgb(0.7,0.3,0.2,1),lwd=1.5)
segments(x0=1,x1=1001,y0=0,y1=log(1.05)*1000, lty=2)
segments(x0=1,x1=1001,y0=0,y1=log(0.6^(1/2)*1.5^(1/2))*1000, lty=2)


axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1,labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("log Riqueza", side=2, line=2.5,cex = 2)

legend(10,50,pch=19,legend = c("0 desertores","1 desertor","2 desertores"), col=c(rgb(0.3,0.6,0.3,1), rgb(0.2,0.3,0.7,1), rgb(0.7,0.3,0.2,1)),bty = "n",cex = 1.5)


#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
#########################################
