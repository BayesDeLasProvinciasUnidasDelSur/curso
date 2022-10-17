oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"), width = 8, height = 6  )
setwd(this.dir)
###############################

A = 0.71 # ambiente
N = 10 # 
ns = seq(1,N)
e = seq(0.0,1.0,by=0.0001)# estrategias (a veces ambiente)
a = e

coop_fitness = function(e,c,r,N){
    return( ((c-r)/N)*(1-e)+(r/N)*e )
}
coop_temporal_average = function(n, e, ambiente, N){
    res = 1.0
    p_fitness = dbinom(seq(0,n),size=n,prob=ambiente)
    for(r in seq(0,n)){#r=0
        res = res * coop_fitness(e,n,r,N)^p_fitness[r+1]
    }
    return(res)
}

plot(a, (0.5^a)*(0.5^(1.0-a)), ylim=c(0,1), type="l", lwd=4, ,axes = F,ann = F, col=rgb(0.2,0.2,0.7) )
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=1, at=0.71, labels=0.71,cex.axis=1.33,line=-0.8,tck=0.015)
axis(side=1, at=0.71, labels=NA,cex.axis=1.33,line=0,tck=0.01)
mtext(text= "Ambiente",side =1,line=2.33,cex=2)
mtext(text = "Tasa de crecimiento" ,side =2,line=2,cex=2)
lines(a, (0.71^a)*(0.29^(1.0-a)), lwd=4, col=rgb(0.7,0.2,0.2))
lines(a, (0.99^a)*(0.01^(1.0-a)), lwd=4, col=rgb(0.2,0.7,0.2))
 # <\Delta x>
lines(a, 0.71*a+0.29*(1.0-a),  lwd=4, col=rgb(0.7*0.7,0.7*0.2,0.7*0.2),lty=2) 
lines(a, 0.99*a+0.01*(1.0-a), lwd=4, col=rgb(0.2,0.7,0.2), lty=2)
# Analisis
points(c(0.71),c(0.71^0.71*0.29^0.29), col=rgb(0.7,0.2,0.2), pch=19, cex=2)
points(c(0.71),c(0.71*0.71+0.29*0.29), col=rgb(0.7,0.2,0.2), pch=15, cex=2)
points(c(0.71),c(0.99^0.71*0.01^0.29), col=rgb(0.2,0.7,0.2), pch=19, cex=2)
points(c(0.71),c(0.99*0.71+0.01*0.29), col=rgb(0.2,0.7,0.2), pch=15, cex=2)
abline(v=0.71, lty=3)

legend(0.05,1,lwd=c(4,4,4),title="Estrategias",
       legend = c(0.50, 0.71, 0.99), 
       col = c(rgb(0.2,0.2,0.7),rgb(0.7,0.2,0.2),rgb(0.2,0.7,0.2)), bty = "n",cex = 1.5)


plot(a, (0.5^a)*(0.5^(1.0-a)), ylim=c(0,1), type="l", lwd=2, ,axes = F,ann = F, col=rgb(0.5,0.5,0.5) )
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=1, at=0.71, labels=0.71,cex.axis=1.33,line=-0.8,tck=0.015)
axis(side=1, at=0.71, labels=NA,cex.axis=1.33,line=0,tck=0.01)
mtext(text= "Ambiente",side =1,line=2.33,cex=2)
mtext(text = "Tasa de crecimiento" ,side =2,line=2,cex=2)
abline(v=0.71, lty=3)
lines(a, (0.71^a)*(0.29^(1.0-a)), lwd=2, col=rgb(0.5,0.5,0.5))
lines(a, 0.71*a+0.29*(1.0-a),  lwd=2, col=rgb(0.5,0.5,0.5),lty=2) 
points(c(0.71),c(0.71^0.71*0.29^0.29), col=rgb(0.5,0.5,0.5), pch=19, cex=2)
points(c(0.71),c(0.71*0.71+0.29*0.29), col=rgb(0.5,0.5,0.5), pch=15, cex=2)
#lines(a, (0.99^a)*(0.01^(1.0-a)), lwd=2, col=rgb(0.2,0.7,0.2))
lines(a, 0.99*a+0.01*(1.0-a), lwd=4, col=rgb(0,0,0),lty=2)
colores = c()
for(i in seq(1,5)){
    r = rep(0,length(a)) 
    j = 1
    for(ai in a){
        r[j] = coop_temporal_average(i,0.99,ai,i)
        j = j + 1
    }
    color = rgb(((10-i)/10)*0.2,((10-i)/10)*0.7,((10-i)/10)*0.2)
    lines(a, r, lwd=4, col=color)
    colores = c(colores, color)
}


legend(0.05,1.05,lwd=c(4,4,4,4,4),title="Tamaño de grupo",
       legend = seq(1,5), 
       col = colores, bty = "n",cex = 1.5)

       
djokovic = rgb(0.5,0.2,0.2,1.0)
edberg= rgb(0,0.8,0.8,1.0)
lendl = rgb(0.7,0,0.7,1.0)
borg = rgb(0.8,0.8,0,1.0)


r = rep(0,length(a))        
for(j in seq(1,length(e))){r[j] = coop_temporal_average(1,e[j],0.71,1)}
plot(e,r, ylim=c(0,0.65), type="l", lwd=4, ,axes = F,ann = F, col=borg)
points(e[which.max(r)],r[which.max(r)],pch=19,cex=2,col=borg)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=1, at=0.71, labels=0.71,cex.axis=1.33,line=-0.8,tck=0.015)
axis(side=1, at=0.71, labels=NA,cex.axis=1.33,line=0,tck=0.01)
mtext(text= "Apuesta b",side =1,line=2.33,cex=2)
mtext(text = "Tasa de crecimiento" ,side =2,line=2,cex=2)
abline(v=0.71, lty=3)

legend(0,0.6,lwd=c(4),title="p = 0.71 \n Tamaño de grupo",
       legend = seq(1), 
       col = c(borg), bty = "n",cex = 1.5)



r = rep(0,length(a))        
for(j in seq(1,length(e))){r[j] = coop_temporal_average(1,e[j],0.71,1)}
plot(e,r, ylim=c(0,0.65), type="l", lwd=4, ,axes = F,ann = F, col=borg)
points(e[which.max(r)],r[which.max(r)],pch=19,cex=2,col=borg)
for(j in seq(1,length(e))){r[j] = coop_temporal_average(2,e[j],0.71,2)}
lines(e,r, lwd=4, col=lendl)
points(e[which.max(r)],r[which.max(r)],pch=19,cex=2,col=lendl)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=1, at=0.71, labels=0.71,cex.axis=1.33,line=-0.8,tck=0.015)
axis(side=1, at=0.71, labels=NA,cex.axis=1.33,line=0,tck=0.01)
mtext(text= "Apuesta b",side =1,line=2.33,cex=2)
mtext(text = "Tasa de crecimiento" ,side =2,line=2,cex=2)
abline(v=0.71, lty=3)

legend(0,0.6,lwd=c(4,4),title="p = 0.71 \n Tamaño de grupo",
       legend = seq(1,2), 
       col = c(borg,lendl), bty = "n",cex = 1.5)



r = rep(0,length(a))        
for(j in seq(1,length(e))){r[j] = coop_temporal_average(1,e[j],0.71,1)}
plot(e,r, ylim=c(0,0.65), type="l", lwd=4, ,axes = F,ann = F, col=borg)
points(e[which.max(r)],r[which.max(r)],pch=19,cex=2,col=borg)
for(j in seq(1,length(e))){r[j] = coop_temporal_average(2,e[j],0.71,2)}
lines(e,r, lwd=4, col=lendl)
points(e[which.max(r)],r[which.max(r)],pch=19,cex=2,col=lendl)
for(j in seq(1,length(e))){r[j] = coop_temporal_average(3,e[j],0.71,3)}
lines(e,r, lwd=4, col=djokovic )
points(e[which.max(r)],r[which.max(r)],pch=19,cex=2,col=djokovic )
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=1, at=0.71, labels=0.71,cex.axis=1.33,line=-0.8,tck=0.015)
axis(side=1, at=0.71, labels=NA,cex.axis=1.33,line=0,tck=0.01)
mtext(text= "Apuesta b",side =1,line=2.33,cex=2)
mtext(text = "Tasa de crecimiento" ,side =2,line=2,cex=2)
abline(v=0.71, lty=3)

legend(0,0.6,lwd=c(4,4,4),title="p = 0.71 \n Tamaño de grupo",
       legend = seq(1,3), 
       col = c(borg,lendl,djokovic), bty = "n",cex = 1.5)


       
r = rep(0,length(a))        
for(j in seq(1,length(e))){r[j] = coop_temporal_average(1,e[j],0.71,1)}
plot(e,r, ylim=c(0,0.65), type="l", lwd=4, ,axes = F,ann = F, col=borg)
points(e[which.max(r)],r[which.max(r)],pch=19,cex=2,col=rgb(0.7,0.2,0.2))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=1, at=0.71, labels=0.71,cex.axis=1.33,line=-0.8,tck=0.015)
axis(side=1, at=0.71, labels=NA,cex.axis=1.33,line=0,tck=0.01)
mtext(text= "Apuesta b",side =1,line=2.33,cex=2)
mtext(text = "Tasa de crecimiento" ,side =2,line=2,cex=2)
abline(v=0.71, lty=3)

legend(0.02,0.6,title="p = 0.71",
       legend = c("argmax b = p"), pch=c(19) ,
       col = c(rgb(0.7,0.2,0.2)), bty = "n",cex = 1.5)

 
p = 0.9
Q_c = 1/(p) 
Q_s = 1/((1-p)*0.8)
b = seq(0,1,by=0.01)
plot(b, b*p*Q_c + (1-b)*(1-p)*Q_s, type="l",lwd=3,axes = F,ann = F)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2, at=1,las=1, labels= c(1),cex.axis=1.5,line=-0.3)
mtext(text= "Apuestas b",side =1,line=2.33,cex=2)
mtext(text = "Tasa de crecimiento" ,side =2,line=1,cex=2)
t

#######################################
# end 
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
