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


configuraciones = matrix(nrow=11, ncol=7)
configuraciones[1,] = c(0, 6, 0, 0, 0, 0, 0)
configuraciones[2,] = c(1, 4, 1, 0, 0, 0, 0)
configuraciones[3,] = c(2, 2, 2, 0, 0, 0, 0)
configuraciones[4,] = c(2, 3, 0, 1, 0, 0, 0)
configuraciones[5,] = c(3, 0, 3, 0, 0, 0, 0)
configuraciones[6,] = c(3, 1, 1, 1, 0, 0, 0)
configuraciones[7,] = c(3, 2, 0, 0, 1, 0, 0)
configuraciones[8,] = c(4, 0, 0, 2, 0, 0, 0)
configuraciones[9,] = c(4, 0, 1, 0, 1, 0, 0)
configuraciones[10,] = c(4, 1, 0, 0, 0, 1, 0)
configuraciones[11,] = c(5, 0, 0, 0, 0, 0, 1)

incomes = matrix(nrow=11, ncol=6)
incomes[1,] =  c(1, 1, 1, 1, 1, 1)
incomes[2,] =  c(0, 1, 1, 1, 1, 2)
incomes[3,] =  c(0, 0, 1, 1, 2, 2)
incomes[4,] =  c(0, 0, 1, 1, 1, 3)
incomes[5,] =  c(0, 0, 0, 2, 2, 2)
incomes[6,] =  c(0, 0, 0, 1, 2, 3)
incomes[7,] =  c(0, 0, 0, 1, 1, 4)
incomes[8,] =  c(0, 0, 0, 0, 3, 3)
incomes[9,] =  c(0, 0, 0, 0, 2, 4)
incomes[10,] =  c(0, 0, 0, 0, 1, 5)
incomes[11,] =  c(0, 0, 0, 0, 0, 6)

#plot(c(0,6),c(0,6), type="l")
#lines(seq(0,6),c(0,cumsum(incomes[4,])) )
#lines(seq(0,6),c(0,cumsum(incomes[5,])) )

gini = c(
 0.0
 ,0.3333333333333335
 ,0.5333333333333335
 ,0.6000000000000002
 ,0.6000000000000002
 ,0.7333333333333336
 ,0.8000000000000003
 ,0.8000000000000003
 ,0.8666666666666669
 ,0.9333333333333337
 ,1.0000000000000004
)

multiplicidad <- function(ks){
    n = sum(ks)
    N = n
    i = 1
    res = 1
    while (n > 0){
        res = res * choose(n,ks[i])
        n = n - ks[i]
        i = i + 1
    }
    return(res)
}


probabilidad = numeric(9)
probabilidad[1] = multiplicidad(configuraciones[1,])
probabilidad[2] = multiplicidad(configuraciones[2,])
probabilidad[3] = multiplicidad(configuraciones[3,])
probabilidad[4] = multiplicidad(configuraciones[4,]) + multiplicidad(configuraciones[5,])
probabilidad[5] = multiplicidad(configuraciones[6,])
probabilidad[6] = multiplicidad(configuraciones[7,]) + multiplicidad(configuraciones[8,])
probabilidad[7] = multiplicidad(configuraciones[9,])
probabilidad[8] = multiplicidad(configuraciones[10,])
probabilidad[9] = multiplicidad(configuraciones[11,])
probabilidad = probabilidad/sum(probabilidad)

barplot(probabilidad, names.arg = c( 0 ,33 ,53 ,60, 73 ,80 ,86 ,93 ,100),cex.names=1.2,  axes=F, xlab="", ylab="")
axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)

axis(lwd=0,side=2, cex.axis=1.2,line=-0.45)
mtext(text ="Probabilidad" ,side =2 ,line=2.2,cex=1.75)


######
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)

