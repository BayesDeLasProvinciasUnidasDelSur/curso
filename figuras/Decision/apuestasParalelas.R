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


plot(c(0,1), c(1,1.5), type="l",lwd=2,axes = F,ann = F, ylim=c(0.5,1.5), col=rgb(0,0,0,1))
lines(c(0,1), c(1,0.6),col=rgb(0,0,0,1),lwd=2)

points(c(0,1,1), c(1,1.5,0.6),col=rgb(0,0,0,1),pch=19)

axis(side=2, at=c(0.5,1,1.5), labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, at=c(0,1),labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=c(0,1), cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,at=c(0.5,1,1.5),cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,at=c(0.6),cex.axis=1.2,las=1,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("Riqueza", side=2, line=2.5,cex = 2)

text(0.95,0.8,"-40%",srt=0, cex=1.75)
text(0.95,1.2,"+50%",srt=0, cex=1.75)

abline(h=0.6, lty=3)
abline(h=1.5, lty=3)
abline(h=1, lty=3)



plot(c(0,1), c(1,1.5), type="l",lwd=2,axes = F,ann = F, ylim=c(0.5,1.5), col=rgb(0,0,0,1))
lines(c(0,1), c(1,0.6),col=rgb(0,0,0,1),lwd=2)

points(c(0,1,1), c(1,1.5,0.6),col=rgb(0,0,0,1),pch=19)

points(c(1),c(1.05),col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5)
lines(c(0,1),c(1, 1.05),col=rgb(0.8,0.2,0.2,1))


axis(side=2, at=c(0.5,1,1.5), labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, at=c(0,1),labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=c(0,1), cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,at=c(0.5,1,1.5),cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,at=c(0.6),cex.axis=1.2,las=1,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("Riqueza", side=2, line=2.5,cex = 2)

text(0.95,0.8,"-40%",srt=0, cex=1.75)
text(0.95,1.2,"+50%",srt=0, cex=1.75)

abline(h=0.6, lty=3)
abline(h=1.5, lty=3)
abline(h=1, lty=3)



plot(c(0,1,2), c(1,1.5,1.5^2), type="l",lwd=2,axes = F,ann = F, ylim=c(0.6^2,1.5^2), col=rgb(0,0,0,1))
lines(c(0,1,2), c(1,0.6,0.6*1.5),col=rgb(0,0,0,1),lwd=2)
lines(c(0,1,2), c(1,1.5,1.5*0.6),col=rgb(0,0,0,1),lwd=2)
lines(c(0,1,2), c(1,0.6,0.6*0.6),col=rgb(0,0,0,1),lwd=2)

points(c(0,1,1,2,2,2), c(1,1.5,0.6, 1.5^2, 1.5*0.6, 0.6^2),col=rgb(0,0,0,1),pch=19)

points(c(1,2),c(1.05,1.05^2),col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5)
lines(c(0,1,2),c(1, 1.05,1.05^2),col=rgb(0.8,0.2,0.2,1))


axis(side=2, at=c(0.6^2,0.6,1,1.5,1.5^2), labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, at=c(0,1,2),labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=c(0,1,2), cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,at=c(0.6^2,0.6,1,1.5,1.5^2),cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("Riqueza", side=2, line=2.5,cex = 2)


abline(h=0.6^2, lty=3)
abline(h=0.6, lty=3)
abline(h=1.5, lty=3)
abline(h=1, lty=3)
abline(h=1.5^2, lty=3)


t = seq(1,100)
r = 1.05^t
plot(t,r,lwd=2,axes = F,ann = F, col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5)
lines(c(0,1,2),c(1, 1.05,1.05^2),col=rgb(0.8,0.2,0.2,1))

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,  cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("Riqueza", side=2, line=2.5,cex = 2)
text(40,80,expression(1.05^t),srt=0, cex=2.25)



t = seq(1,100)
r = 1.05^t
plot(t,log(r),lwd=2,axes = F,ann = F, col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5)

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,  cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("log Riqueza", side=2, line=2.5,cex = 2)
text(40,3,expression("log"~1.05^t),srt=0, cex=2.25)



set.seed(999)
t = seq(0,10)
r = 1.05^t
plot(t,r,lwd=2,axes = F,ann = F, col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5, ylim=c(0,max(r)))
for (n in c(10000)){
    total = c(0,rbinom(0,n=10,size=1))
    for (j in seq(n)){
        m = rbinom(0.5,n=10,size=1)
        total = total + c(1,cumprod(1.5*m + 0.6*(1-m)))
    }
    lines(t,total/n ,lwd=3, col=rgb(0,0,0,(log(n,10)+1)/6 ) )
}
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,  cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("Riqueza", side=2, line=2.5,cex = 2)
legend(0,0.5,pch=19,legend = c(expression("Promedio de riqueza N="~10^4), "Esperanza"), col=c(rgb(0,0,0,5/6),rgb(0.8,0.2,0.2,1) ),bty = "n",cex = 1.5)



t = seq(0,100)
r = 1.05^t
s = c(1,rep(c(0.6,1.5),50))
plot(t[1:3],r[1:3],lwd=2,axes = F,ann = F, col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5, ylim=c(0.6,1.05^2) )
lines(t[1:3],cumprod(s[1:3]),col=rgb(0.2,0.2,0.6,1),lwd=2)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, at = c(0,1,2),labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,at = c(0,1,2),  cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("Riqueza", side=2, line=2.5,cex = 2)
abline(h=1,lty=3)


plot(t,log(r),lwd=2,axes = F,ann = F, col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5, ylim=c(-max(log(r))-0.5,max(log(r))))
lines(t,log(cumprod(s)),col=rgb(0.2,0.2,0.6,1),lwd=2)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,  cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("log Riqueza", side=2, line=2.5,cex = 2)




set.seed(999)
t = seq(0,1000)
r = 1.05^t
plot(t,log(r),lwd=2,axes = F,ann = F, col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5, ylim=c(-max(log(r))-0.5,max(log(r))))
for (i in seq(33)){
    m = c(1,rbinom(0.5,n=1000,size=1))
    lines(t,log(cumprod(1.5*m + 0.6*(1-m))) ,lwd=2, col=rgb(runif(1),runif(1),runif(1)) )
}

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,  cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("log Riqueza", side=2, line=2.5,cex = 2)
text(900,-16,expression("?"),srt=0, cex=5)

set.seed(999)
t = seq(0,1000)
r = 1.05^t
plot(t,log(r),lwd=2,axes = F,ann = F, col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5, ylim=c(-max(log(r))-0.5,max(log(r))))
for (i in seq(33)){
    m = c(1,rbinom(0.5,n=1000,size=1))
    lines(t,log(cumprod(1.5*m + 0.6*(1-m))) ,lwd=2, col=rgb(runif(1),runif(1),runif(1)) )
}

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,  cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("log Riqueza", side=2, line=2.5,cex = 2)


set.seed(9)
t = seq(0,10000)
r = 1.05^t
plot(t,log(r),lwd=2,axes = F,ann = F, col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5, ylim=c(-max(log(r))-0.5,max(log(r))))
for (i in seq(33)){
    m = c(1,rbinom(0.5,n=10000,size=1))
    lines(t,log(cumprod(1.5*m + 0.6*(1-m))) ,lwd=2, col=rgb(runif(1),runif(1),runif(1)) )
}

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,  cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("log Riqueza", side=2, line=2.5,cex = 2)
#segments(x0=0,x1=10000, y0=0, y1=log(0.6^(1/2)*1.5^(1/2))*10000,lwd=3)
#text(900,16,expression("5%"),srt=0, cex=2)
#text(900,-16,expression("-5%"),srt=0, cex=2)
abline(h=0,lty=3)


set.seed(9)
plot(c(0,100000),c(0,log(1.05)*100000) ,lwd=4,axes = F,ann = F, col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5,type="l", ylim=c(log(0.6^(1/2)*1.5^(1/2))*100000, log(1.05)*100000) )
segments(x0=0,x1=100000, y0=0, y1=log(0.6^(1/2)*1.5^(1/2))*100000,lwd=3)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,  cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("log Riqueza", side=2, line=2.5,cex = 2)
text(90000,2800,expression("5%"),srt=0, cex=2)
text(90000,-3000,expression("?%"),srt=0, cex=2)
abline(h=0,lty=3)


set.seed(9)
plot(c(0,100000),c(0,log(1.05)*100000) ,lwd=4,axes = F,ann = F, col=rgb(0.8,0.2,0.2,1),pch=19, cex=1.5,type="l", ylim=c(log(0.6^(1/2)*1.5^(1/2))*100000, log(1.05)*100000) )
segments(x0=0,x1=100000, y0=0, y1=log(0.6^(1/2)*1.5^(1/2))*100000,lwd=3)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,  cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("log Riqueza", side=2, line=2.5,cex = 2)
text(90000,2800,expression("5%"),srt=0, cex=2)
text(90000,-3000,expression("-5.1%"),srt=0, cex=2)
abline(h=0,lty=3)


#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
#########################################
