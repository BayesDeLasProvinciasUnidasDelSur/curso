###########################################
# Header
oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"),width = 8, height = 4.5)
setwd(this.dir)
#setwd("/home/amaya-botello/gaming/docencia/concursos/2018-ay1-historiaDeLaCiencia/po/populstat")
#####################################

par(mar=c(4,4,1.5,1.5))
require(stringi)

m <- read.csv("../../../auxiliar/static/china.txt",header = F)
dim(m)
pop <- c()
year <- c()
for(i in seq(dim(m)[2]/2)){
  pop <- c(pop,m[,1+((i-1)*2)])
  year <- c(year,m[,2+((i-1)*2)])
}
filtro <- year>1800 & year!=1866 & year<1950
plot(year[filtro],pop[filtro]/1000,type="l",ylab="",xlab="",ylim=c(200,max(pop[filtro]/1000)),axes = F,ann = F)
points(year[filtro][50],pop[filtro][50]/1000,pch=19,cex=1.25)
points(year[filtro][69],pop[filtro][69]/1000,pch=19,cex=1.25)
maximo <- 430
minimo <- 358
axis(side=2, at=c(0,200,minimo,400,maximo,600,800), labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, cex.axis=2,line=-0.3)
axis(lwd=0,side=2,at=c(0,600,800),labels = c(0,600,800), cex.axis=1.25,line=-0.3)
axis(lwd=0,side=2,las=1,at=c(minimo,maximo),labels = c(minimo,maximo), cex.axis=2.25,line=-0.66)
abline(h=c(minimo,maximo),lty=3)

mtext(text="Year" ,side =1,line=2,cex=1.75)
text(1875, 275,"Chinese population",cex=1.75)
polygon(c(year[filtro],rev(year[filtro])),c(pop[filtro]/1000, rep(0,length(pop[filtro])))
       , col=rgb(0,0,0,0.3),border=F)
#segments(1856,200,1856,600)

#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
#########################################
