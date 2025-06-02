###########################################
# Header
oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"), width = 8, height = 5 )
setwd(this.dir)
#setwd("~/gaming/materias/inferencia_bayesiana/trabajoFinal/imagenes")
#####################################

par(mar=c(4.5,3.5,0,0))


beta <- 2000/7
s_1 <- 2000
s_2 <- 1750
tb <-  s_1+s_2
D <- ( -1200+tb):(1200+tb)
ta <- s_1 + s_2 - 250

dnormal <- dnorm(D,s_1+s_2,beta)
plot(D,dnormal, type="l",lwd=1,axes = F,ann = F)

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=0,las=0,cex.axis=1.33,line=-0.6)
axis(lwd=1,side=1, at=ta,labels=expression( p[b] ),las=0,cex.axis=1.5,line=-0.3)

mtext(text ="Density" ,side =2 ,line=2,cex=2)
mtext(text =expression( p[a] %~% N(mu[a],sigma[a]^2 + beta^2) ) ,side =1 ,line=3.5,cex=2)
abline(v=tb,lty=3)

#segments(0,0,0,dnorm(0,s_1+s_2,beta))
base <- rep(0,length(D))
xx <- c(D[D>=ta],rev(D[D>=ta]))
yy <- c(base[D>=ta],rev(dnormal[D>=ta]) )
polygon(xx,yy,col=rgb(0,0,0,0.4))

mid <- length(D)%/%2
h <- dnormal[mid]/4
text(D[mid],h, expression(p[a]>p[b]), col = 1, cex=2.5)

#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
#########################################
