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

par(mar=c(3.75,3.75,1.25,1.25))

beta <- 1500/6.125 # == 2000/7
s_1 <- 1750
s_2 <- 1500

p_grilla <- seq(min(s_1,s_2)-750,max(s_1,s_2)+750,by=5)

rendimiento_conjunto <- function(p_1,p_2=p_1,s_1=1750,s_2=1500,beta=2000/7){
  dnorm(p_1,s_1,beta)*dnorm(p_2,s_2,beta)
}

m <- outer(p_grilla,p_grilla,rendimiento_conjunto)
levels <- seq(min(m),max(m),length.out = 11)
image(p_grilla,p_grilla,m,col=rev(gray.colors(10,start=0.2,end=0.95)),breaks = levels,useRaster=T,
      ylab="",xlab="",axes=F)
contour(p_grilla,p_grilla,m,drawlabels=F,levels = levels,add = T,col=rev(gray.colors(11,start=0,end=0.6)),lwd=1.1)
mtext(text=expression("Desempeño"~p[b]) ,side =2 ,line=1.5,cex=2)
mtext(text =expression("Desempeño"~p[a]) ,side =1 ,line=2,cex=2)
abline(v=1750,lty=3)
abline(h=1500,lty=3)
#lines(c(0,1)*(s_2+s_2-500),c(1,0)*(s_2+s_2-500))
lines(c(0,1)*(s_2+s_2-500),c(0,1)*(s_2+s_2-500),col=rgb(0,0,0,0.75))
text(s_2-250,s_1+250,expression("Gana b ("~d<0~")"),cex=2)
text(s_1+250,s_2-350,expression("Gana a ("~d>0~")"),cex=2)
mtext(expression(p[a]==p[b]~" "), side=3, line=0, at=2500,cex=1.25)
axis_at <- seq(min(s_1,s_2)-750,max(s_1,s_2)+750,by=250)
axis(side=2, at=axis_at, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, at=axis_at, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=s_1,labels=expression(s[a]),las=0,cex.axis=1.5,line=-0.75)
axis(lwd=0,side=2, at=s_2,labels=expression(s[b]),las=0,cex.axis=1.5,line=-0.75)


#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
#########################################
