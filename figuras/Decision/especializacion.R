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

p = 0.5
N = 6
n = seq(6)
b = seq(0.0,1.0,by=0.0001)

coop_fitness <- function(b,n_c,N, Qc=3.0,Qs=1.2){
    return ( (n_c/N)*b*Qc + ((N-n_c)/N)*(1-b)*Qs )
}
coop_temporal_average <- function(b, p, N){
    res = numeric(length(b))+1
    p_fitness = dbinom(prob=p, size=N, seq(0,N))
    for (n_c in seq(0,N)){#n_c=N
        res = res * coop_fitness(b,n_c,N)^p_fitness[n_c+1]
    }
    return(res)
}


g1 = coop_temporal_average(b, p, 1)
g2 = coop_temporal_average(b, p, 2)
g3 = coop_temporal_average(b, p, 3)
g4 = coop_temporal_average(b, p, 4)
g5 = coop_temporal_average(b, p, 5)

plot(b,g1, type="l",lwd=3, axes = F,ann = F, col=1,ylim=c(0,max(g5)) )
points(b[which.max(g1)],max(g1),pch=19, col=1, cex=2)

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1,labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Apuesta b", side=1, line=2.5,cex = 2)
mtext("Tasa de crecimiento", side=2, line=2.5,cex = 2)

legend(0,1.35,pch=19,legend = c("Tamaño: 1"), col=c(1),bty = "n",cex = 1.5)




plot(b,g1, type="l",lwd=3, axes = F,ann = F, col=1,ylim=c(0,max(g5)) )
points(b[which.max(g1)],max(g1),pch=19, col=1, cex=2)
lines(b,g2, lwd=3, col=2)
points(b[which.max(g2)],max(g2),pch=19, col=2, cex=2)

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1,labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Apuesta b", side=1, line=2.5,cex = 2)
mtext("Tasa de crecimiento", side=2, line=2.5,cex = 2)

legend(0,1.35,pch=19,legend = c("Tamaño: 1", "Tamaño 2"), col=c(1,2),bty = "n",cex = 1.5)


plot(b,g1, type="l",lwd=3, axes = F,ann = F, col=1,ylim=c(0,max(g5)) )
points(b[which.max(g1)],max(g1),pch=19, col=1, cex=2)
lines(b,g2, lwd=3, col=2)
points(b[which.max(g2)],max(g2),pch=19, col=2, cex=2)
lines(b,g3, lwd=3,col=3)
points(b[which.max(g3)],max(g3),pch=19, col=3, cex=2)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1,labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Apuesta b", side=1, line=2.5,cex = 2)
mtext("Tasa de crecimiento", side=2, line=2.5,cex = 2)
legend(0,1.35,pch=19,legend = c("Tamaño: 1", "Tamaño 2", "Tamaño 3"), col=c(1,2,3),bty = "n",cex = 1.5)


plot(b,g1, type="l",lwd=3, axes = F,ann = F, col=1,ylim=c(0,max(g5)) )
points(b[which.max(g1)],max(g1),pch=19, col=1, cex=2)
lines(b,g2, lwd=3, col=2)
points(b[which.max(g2)],max(g2),pch=19, col=2, cex=2)
lines(b,g3, lwd=3, col=3)
points(b[which.max(g3)],max(g3),pch=19, col=3, cex=2)
lines(b,g4, lwd=3,col=4)
points(b[which.max(g4)],max(g4),pch=19, col=4, cex=2)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1,labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Apuesta b", side=1, line=2.5,cex = 2)
mtext("Tasa de crecimiento", side=2, line=2.5,cex = 2)
legend(0,1.35,pch=19,legend = c("Tamaño: 1", "Tamaño 2", "Tamaño 3", "Tamaño 4"), col=c(1,2,3,4),bty = "n",cex = 1.5)



plot(b,g1, type="l",lwd=3, axes = F,ann = F, col=1,ylim=c(0,max(g5)) )
points(b[which.max(g1)],max(g1),pch=19, col=1, cex=2)
lines(b,g2, lwd=3, col=2)
points(b[which.max(g2)],max(g2),pch=19, col=2, cex=2)
lines(b,g3, lwd=3, col=3)
points(b[which.max(g3)],max(g3),pch=19, col=3, cex=2)
lines(b,g4, lwd=3,col=4)
points(b[which.max(g4)],max(g4),pch=19, col=4, cex=2)
lines(b,g5, lwd=3,col=rgb(0.5,0.2,0.8))
points(b[which.max(g5)],max(g5),pch=19, col=rgb(0.5,0.2,0.8), cex=2)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1,labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Apuesta b", side=1, line=2.5,cex = 2)
mtext("Tasa de crecimiento", side=2, line=2.5,cex = 2)
legend(0,1.35,pch=19,legend = c("Tamaño: 1", "Tamaño 2", "Tamaño 3", "Tamaño 4", "Tamaño 5"), col=c(1,2,3,4,rgb(0.5,0.2,0.8)),bty = "n",cex = 1.5)





#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
#########################################
