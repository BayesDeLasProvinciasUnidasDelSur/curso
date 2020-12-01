oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"))
setwd(this.dir)
##################################################


puntos <- function(base,nivel,pch,col,cex=1){
  points(cos(base)*nivel,sin(base)*nivel,pch=pch,col=col,cex=cex)
}

nombres <- function(base,nivel,nombres,col,cex=1){
  text(cos(base)*nivel,sin(base)*nivel, labels=nombres, cex= cex)
}

segmento <- function(punto0, punto1, nivel,col,lwd=1){
  segments(x0=cos(punto0)*nivel,y0=sin(punto0)*nivel,
           x1=cos(punto1)*(nivel+1),y1=sin(punto1)*(nivel+1),
           col=col,lwd=lwd)
}

paths <- function(patron=c(19,1,19),creencia=c(1,1,1,19), base1,base2,base3){
  
  for (a1 in seq(4)){#a1=1
    for (b in seq(4)){#b=1
      a2 <- 4*(a1-1)+b
      for (c in seq(4)){#b=1
        a3 <- 4*(a2-1)+c
        if (creencia[((a1-1)%%4)+1]==patron[1] & creencia[(((a3-1)%%4)+1)]==patron[3] & creencia[(((a2-1)%%4)+1)]==patron[2] ){
          segmento(c(0),base1[a1],0,rgb(0,0,0,1))  
          segmento(base1[a1],base2[a2],1,rgb(0,0,0,1))
          segmento(base2[a2],base3[a3],2,rgb(0,0,0,1))
        }
        
      }
    }
  }
  
}


nodes <- function(patron=c(19,1,19),creencia=c(1,1,1,19), base1,base2,base3){
  for (a1 in seq(4)){#a1=4
    for (b in seq(4)){#b=1
      a2 <- 4*(a1-1)+b
      for (c in seq(4)){#b=1
        a3 <- 4*(a2-1)+c
        if (creencia[((a1-1)%%4)+1]==patron[1] & creencia[((a2-1)%%4)+1]==patron[2] & creencia[(((a3-1)%%4)+1)]==patron[3]){
          points(cos(base1[a1])*1,sin(base1[a1])*1,pch=19,col=rgb(1,1,1,1),cex=1.5)    
          points(cos(base1[a1])*1,sin(base1[a1])*1,pch=patron[1])    
          points(cos(base2[a2])*2,sin(base2[a2])*2,pch=19,col=rgb(1,1,1,1),cex=1.5)  
          points(cos(base2[a2])*2,sin(base2[a2])*2,pch=patron[2])  
          points(cos(base3[a3])*3,sin(base3[a3])*3,pch=19,col=rgb(1,1,1,1),cex=1.5)
          points(cos(base3[a3])*3,sin(base3[a3])*3,pch=patron[3])
        }
        
      }
    }
  }
  
}


R <- expression(r[1],               r[2],               r[3])
C <- expression(c[1],     c[2],c[3],c[1],c[2],     c[3],c[1],c[2],c[3])
D <- expression(d[2],d[3],d[3],d[2],d[3],d[1],d[3],d[1],d[2],d[1],d[1],d[2])
base1 <- seq(0,pi,length.out = 3+2)[c(-1,-5)]
base2 <- seq(0,pi,length.out = 3*3+2)[c(-1,-11)]
base3 <- seq(0,pi,length.out = 12)
path = T

plot(0,0,col=rgb(0,0,0,0),axes=F,ylab="",xlab="",ylim=c(-3,3),xlim=c(-3,3))

c=1
for (a in seq(3)){#a=2
  segmento(c(0),rev(base1)[a],0,rgb(0,0,0,0.35^path))
}

puntos(c(0),0,pch=19,col=rgb(1,1,1,1),6)
puntos(base1,1,pch=19,col=rgb(1,1,1,1),6)
puntos(base2,2,pch=19,col=rgb(1,1,1,1),6)
puntos(base3,3,pch=19,col=rgb(0.99,0.99,0.99,1),6)

nombres(rev(base1),1,R,cex=2)

plot(0,0,col=rgb(0,0,0,0),axes=F,ylab="",xlab="",ylim=c(-3,3),xlim=c(-3,3))

c=1
for (a in seq(3)){#a=2
  segmento(c(0),rev(base1)[a],0,rgb(0,0,0,0.35^path))
  for (b in seq(3)){#b=1
    segmento(rev(base1)[a],rev(base2)[3*(a-1)+b],1,rgb(0,0,0,0.35^path))
  }
}

puntos(c(0),0,pch=19,col=rgb(1,1,1,1),6)
puntos(base1,1,pch=19,col=rgb(1,1,1,1),6)
puntos(base2,2,pch=19,col=rgb(1,1,1,1),6)
puntos(base3,3,pch=19,col=rgb(0.99,0.99,0.99,1),6)

nombres(rev(base1),1,R,cex=2)
nombres(rev(base2),2,C,cex=2)



plot(0,0,col=rgb(0,0,0,0),axes=F,ylab="",xlab="",ylim=c(-3,3),xlim=c(-3,3))

c=1
for (a in seq(3)){#a=2
  segmento(c(0),rev(base1)[a],0,rgb(0,0,0,0.35^path))
  for (b in seq(3)){#b=1
    segmento(rev(base1)[a],rev(base2)[3*(a-1)+b],1,rgb(0,0,0,0.35^path))
    if (a == b){
      segmento(rev(base2)[3*(a-1)+b],rev(base3)[c],2,rgb(0,0,0,0.35^path))
      c = c + 1 
    }
    segmento(rev(base2)[3*(a-1)+b],rev(base3)[c],2,rgb(0,0,0,0.35^path))
    c = c + 1 
  
  }
}

puntos(c(0),0,pch=19,col=rgb(1,1,1,1),6)
puntos(base1,1,pch=19,col=rgb(1,1,1,1),6)
puntos(base2,2,pch=19,col=rgb(1,1,1,1),6)
puntos(base3,3,pch=19,col=rgb(0.99,0.99,0.99,1),6)

nombres(rev(base1),1,R,cex=2)
nombres(rev(base2),2,C,cex=2)
nombres(rev(base3),3,D,cex=2)

######
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
