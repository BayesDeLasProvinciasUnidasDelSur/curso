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

par(mar=c(3.75,3.75,.33,.33))

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
ds=1;s_grilla <- seq(a,b,by=ds)
int_s = sum(p.s(s_grilla))*ds; int_s

#p(p_i) = int_{s_i} N(p_i;s_i,beta^2) N(si;mu_i,sigma_i^2) ds_i
p.p <- function(p,mu=25,sigma=25/3,beta=25/6,ds=0.1,a=0,b=50){
  s <- seq(a,b,by=ds)
  res <- sum(dnorm(p,s,beta)*dnorm(s,mu,sigma)*ds)
  return(res)
}
#Si integramos p_i nos tiene que dar 1.
#int_{p_i} p(p_i) dp_i = int_{p_i} int_{s_i} N(p_i;s_i,beta^2) N(si;mu_i,sigma_i^2) dp_i ds_i
dp <- 0.1; p_grilla <- seq(a,b,by=dp) 
int_p = sum(unlist(Map(p.p,p_grilla)))*dp; int_p

#Para calcular la probabilidad de p(p_i) hay que sumar todos los puntos que pasan por p_i
#la recta, multiplicados por la base ds_i
p_grilla <- seq(a,b,by=dp); p=30
plot(p_grilla,dnorm(p_grilla,mean=mu,sd=beta)*dnorm(mu,mean=mu,sd=sigma),type="l"
     ,col=rgb(0,0,0,1), ylab="",xlab="",lwd=0.33,axes=F)
mtext("Densidad", side=2, line=1.5,cex = 2)
mtext("Rendimiento", side=1, line=2,cex = 2)
axis(lwd=1,lwd.ticks=1,side=2, labels=NA,cex.axis=0.6,tck=0.02)
#axis(lwd=1,side=2,cex.axis=1.33,line=-0.66)
axis(lwd=1,lwd.ticks=1,side=1, labels=NA,cex.axis=0.6,tck=0.02)
axis(lwd=1,side=1,at=25, label=expression(mu[i]) ,cex.axis=1.5,line=-0.66)

acum <- c()
for(s in s_grilla){#si=27
  if(s!=25 ) lines(p_grilla, dnorm(p_grilla,mean=s,sd=beta)*dnorm(s,mean=mu,sd=sigma),type="l",lwd=0.33)
  points(p,dnorm(p,mean=s,sd=beta)*dnorm(s,mean=mu,sd=sigma),pch=19,cex=0.75)
  acum <- c(acum,dnorm(p,mean=s,sd=beta)*dnorm(s,mean=mu,sd=sigma))
}
lines(p_grilla,dnorm(p_grilla,mean=mu,sd=beta)*dnorm(mu,mean=mu,sd=sigma),lwd=3)
abline(v=p)
sum(acum*ds)==p.p(p)



#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
#########################################