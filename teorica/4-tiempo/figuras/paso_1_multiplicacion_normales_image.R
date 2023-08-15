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
#setwd("~/gaming/materias/inferencia_bayesiana/trabajoFinal/imagenes")
#####################################

par(mar=c(3.75,3.75,.75,.75))

a<--10;b<-60 # limites inferior y superior de la integral en el eje de las habilidades
mu<-25
denominador_sigma2 <- 3; numerador_sigma2 <- mu
sigma <- numerador_sigma2/denominador_sigma2
denominador_beta2 <- 2; numerador_beta2 <- sigma
beta <- numerador_beta2/denominador_beta2
#p(s_i) = N(s_i;mu_i,sigma_i^2)
p.s <- function(s_i,mu=25,sigma=sqrt(25/3)){
  return(dnorm(s_i,mean=mu,sd=sigma ))
}
#int_{s_i} N(s_i;mu_i,sigma_i^2) ds_i
#int_{s_i} p(s_i) ds_i
ds=0.25;s_grilla <- seq(a,b,by=ds)
int_s = sum(p.s(s_grilla))*ds; int_s

#p(p_i) = int_{s_i} N(p_i;s_i,beta^2) N(si;mu_i,sigma_i^2) ds_i
p.p <- function(p,mu=25,sigma=sqrt(25/3),beta=sqrt((25/3)/2),ds=0.1,a=0,b=50){
  s <- seq(a,b,by=ds)
  res <- sum(dnorm(p,s,beta)*dnorm(s,mu,sigma)*ds)
  return(res)
}
#Si integramos p_i nos tiene que dar 1.
#int_{p_i} p(p_i) dp_i = int_{p_i} int_{s_i} N(p_i;s_i,beta^2) N(si;mu_i,sigma_i^2) dp_i ds_i
dp <- 0.1; p_grilla <- seq(a,b,by=dp) 
int_p = sum(unlist(Map(p.p,p_grilla)))*dp; int_p

#Si expandimos esto a 2 dimensiones encontramos 
normal_product_dep <- function(x1,x2,mu1=25,sigma1=25/3,sigma2=25/6){
  return(dnorm(x2,x1,sigma2)*dnorm(x1,mu1,sigma1))
}
p <- 30; ds <- 0.1;s_grilla <- seq(a,b,by=ds);p_grilla <- s_grilla
producto <- outer(s_grilla,p_grilla, normal_product_dep) 
colnames(producto) <- s_grilla
rownames(producto) <- p_grilla
levels <- seq(min(producto),max(producto),length.out = 11)
image(s_grilla,p_grilla,producto,ylim=c(0,50),xlim=c(0,50),col=rev(gray.colors(10,start=0.2,end=0.95)),breaks = levels,useRaster=T,
      ylab="",xlab="",axes=F)
contour(s_grilla,p_grilla,producto,ylim=c(0,50),xlim=c(0,50),drawlabels=F,levels = levels,add = T,col=rev(gray.colors(11,start=0,end=0.6)),lwd=1.1)
mtext("Rendimiento", side=2, line=2,cex = 2)
mtext("Habilidad", side=1, line=2,cex = 2)
axis(lwd=1,lwd.ticks=1,side=2, labels=NA,cex.axis=0.6,tck=0.02)
axis(lwd=1,side=2,at=25, labels= expression(mu[i]),cex.axis=1.5,line=-0.66)
axis(lwd=0,side=2,at=30, labels= expression(p[i]),cex.axis=1.5,line=-0.66)
axis(lwd=1,lwd.ticks=1,side=1, labels=NA,cex.axis=0.6,tck=0.02)
axis(lwd=1,side=1,at=25, labels= expression(mu[i]),cex.axis=1.5,line=-0.66)

points(mu,mu,pch=19)
lines(mu+(p_grilla-mu)*(4/5) ,s_grilla,cex=0.1)
abline(h=p,lty=3,col=rgb(0,0,0,1))



#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
#########################################