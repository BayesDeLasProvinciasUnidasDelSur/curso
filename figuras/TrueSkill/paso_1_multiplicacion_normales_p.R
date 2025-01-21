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
xlim=c(0,50)
denominador_sigma2 <- 3; numerador_sigma2 <- mu
sigma <- numerador_sigma2/denominador_sigma2
denominador_beta2 <- 2; numerador_beta2 <- sigma
beta <- numerador_beta2/denominador_beta2
#p(s_i) = N(s_i;mu_i,sigma_i^2)
p.s <- function(s_i,mu=25,sigma=25/3){
  return(dnorm(s_i,mean=mu,sd=sigma ))
}
#int_{s_i} N(s_i;mu_i,sigma_i^2) ds_i
#int_{s_i} p(s_i) ds_i
ds=0.1;s_grilla <- seq(a,b,by=ds)
int_s = sum(p.s(s_grilla))*ds; int_s

#p(p_i) = int_{s_i} N(p_i;s_i,beta^2) N(si;mu_i,sigma_i^2) ds_i
p.p <- function(p,mu=25,sigma=25/3,beta=(25/6),ds=0.1,a=0,b=50){
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

#Estos puntos son la descomposici\'on de la probabilidad p(p_i)
#en sus probabilidades parciales (areas parciales de la integral p(p_i))
# Area := p(pi - dsi < pi < pi + dsi)
areas_p <- producto[,toString(p)]
# La suma de las areas parciales es la probabilidad de pi
sum(areas_p)==p.p(p)
#Al graficar el valor de las sumas parciales en el eje de las habilidades
#vemos que las areas parciales aparentemente siguen una proporcional a una distribucion normal
plot(s_grilla,areas_p,axes=F
     ,ylab="",xlab="",pch=19,cex=0.2,xlim=xlim,col=rgb(0,0,0,0))
abline(v=mu+(p-mu)*(4/5),lty=2,col=rgb(0,0,0,0.4))
polygon(c(s_grilla , rev(s_grilla)),c(areas_p,rep(0,length(s_grilla))),
        border = F, col = rgb(0,0,0,0.33))
text(mu+(p-mu)*(4/5),max(areas_p)/3,expression(P(p[i])),cex=1.75)
#mtext("Densidad", side=2, line=2,cex = 1.75)
mtext("Habilidad", side=1, line=2.5,cex = 2)
axis(lwd=1,lwd.ticks=1,side=2, labels=NA,cex.axis=0.6,tck=0.02)
#axis(lwd=0,side=2,cex.axis=1.33,line=-0.66)
axis(lwd=1,lwd.ticks=1,side=1, labels=NA,cex.axis=0.6,tck=0.02)
axis(lwd=1,side=1,at=25,labels=expression(mu[i]),cex.axis=1.5,line=-0.66)

# Si multiplicamos las dos funciones de densidad
# N(p;s,beta2)N(s;mu,sigma2) vamos a obtener 
# otra normal con mu = (2p + mu) / 3 y sigma2 = 25/9, 

# El escalar de normalizacion de normalizaci\'on 
# es otra normal N(mu;pi,beta2+sigma2)
S <- function(mu,p,beta,sigma){
  dnorm(mu,p,sqrt(beta^2+sigma^2))
}
#que es exactamente igual a la probabilidad de la performance dada 
round(p.p(p),10)==round(S(mu,p,beta,sigma),10)

#Podemos ver que el producto de normales escalada por el delta s ds_i 
#ajusta perfectamente la distribuci\'on de areas. 
sigma. <- sqrt((sigma^2*beta^2)/(sigma^2+beta^2))
mu. <- ((sigma^2*p)+(beta^2*mu))/(sigma^2+beta^2)

lines(s_grilla, dnorm(s_grilla,mu.,sigma.)*S(mu,p,beta,sigma),col=2)
points(s_grilla,areas_p,pch=19,cex=0.2)

#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
#########################################