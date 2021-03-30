oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
png(paste0(nombre,".png"), width = 8*200, height = 5*200  )
setwd(this.dir)
###############################

#par(mar=c(3.75,3.75,0.25,0.25))

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



rs = seq(2.5,4,0.002)
n = length(rs)
T = 1000
eje_r = rep(0,n*T)
eje_f = rep(0,n*T)
for(i in seq(1,n)){#i=150
    eje_r[seq(T*(i-1)+1,T*i)] = rs[i] 
    eje_f[seq(T*(i-1)+1,T*i)] = historia(rs[i],T*2)[seq(T+1,T*2)]
    #plot(eje_f,pch=19,cex=0.3,axes = F,ann = F,ylim=c(0,1))
}

plot(eje_r, eje_f,pch=19,cex=0.01,xlim=c(2.5,4),ylab="",xlab="",axes = F,ann = F)
mtext(text= "Parámetro r",side =1,line=0,cex=5)
mtext(text = "Población" ,side =2,line=0,cex=5)


#######################################
# end 
dev.off()
#system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
#########################################
