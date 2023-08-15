oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"), width = 8, height = 5 )
setwd(this.dir)
##################################################

set.seed(3)
n = 20
# Consideramos que el modelo causal verdadero es B -> A
# En los casos que hacemos do(A) ambas variables son independientes
# Luego, genero datos con este modelo.
alpha=0.5
A = rbinom(prob=alpha,size=1, n=20)
B = rbinom(prob=0.5,size=1, n=20)


p_datos_ModeloBA = 0.5^seq(n)
p_datos_ModeloAB = cumprod(0.05^(A != B) * 0.95^(A == B))
p_datos = p_datos_ModeloBA + p_datos_ModeloAB

plot(c(rep(0.5,10), p_datos_ModeloBA/p_datos), type="l", ylim=c(0,1), axes=F, xlab="", ylab="",lwd=3)
polygon(c(seq(30),rev(seq(30))),c(c(rep(0.5,10), p_datos_ModeloBA/p_datos), rep(0,30)), col=rgb(0,0,0,0.3) )

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,  cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.2,line=-0.45)
axis(lwd=0,side=2,cex.axis=1.2,line=-0.45)
mtext(text ="P(Modelo B->A | Datos)" ,side =2 ,line=2.2,cex=1.75)
abline(h=1,lty=3)
abline(h=0,lty=3)


######
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
