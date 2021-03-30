oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"), width = 8, height = 5  )
setwd(this.dir)
###############################

par(mar=c(3.75,3.75,0.25,0.25))

historia <- function(r, T=2000, pasado = 0.5){
    pop = rep(0,T)
    pop[1] = pasado
    for (i in seq(1,T)){
        pop[i+1] = r*pop[i]*(1-pop[i])
    }
    return(pop)
}


destino_final <- function(r, T=2000, pasado = 0.5){
    for (i in seq(1,T)){
        futuro = r*pasado*(1-pasado)
        pasado = futuro
    }
    return(pasado)
}


plot(historia(1,100,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
lines(historia(1,100,0.5))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 1.00",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)

plot(historia(1,100,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
lines(historia(1,100,0.5))
points(historia(1,100,0.75), cex=0.5, pch=19)
lines(historia(1,100,0.75))
points(historia(1,100,0.25), cex=0.5, pch=19)
lines(historia(1,100,0.25))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 1.00",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)


plot(historia(1.3,100,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
lines(historia(1.3,100,0.5))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 1.30",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)


plot(historia(2,100,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
lines(historia(2,100,0.5))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 2.00",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)


plot(historia(2.5,100,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
lines(historia(2.5,100,0.5))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 2.50",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)

plot(historia(2.75,100,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
lines(historia(2.75,100,0.5))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 2.75",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)


plot(historia(3,100,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
lines(historia(3,100,0.5))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 3.00",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)


plot(historia(3.25,100,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
lines(historia(3.25,100,0.5))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 3.25",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)

plot(historia(3.5,100,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
lines(historia(3.5,100,0.5))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 3.50",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)

plot(historia(3.75,100,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
lines(historia(3.75,100,0.5))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 3.75",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)

plot(historia(3.99,100,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
lines(historia(3.99,100,0.5))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 3.99",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)

plot(historia(3.99,30,0.5), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1), type="l", lwd=2)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 3.99",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)

plot(historia(3.99,30,0.499), cex=0.5, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1), type="l", lwd=2,col="red")
lines(historia(3.99,30,0.5),  lwd=2)
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 3.99",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)

plot(historia(3.99,2000,0.499), cex=0.1, pch=19 ,ylab="",xlab="",axes = F,ann = F, ylim=c(0,1))
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1,cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext(text= "Parámetro r = 3.99",side =1,line=2.33,cex=2)
mtext(text = "Población" ,side =2,line=2,cex=2)



#######################################
# end 
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
#########################################
