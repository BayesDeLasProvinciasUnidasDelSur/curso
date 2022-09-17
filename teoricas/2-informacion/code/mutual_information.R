# Mutual information of the Binary simetric channel (Lecture 7 MacKay https://www.youtube.com/watch?v=vVAsh5DAe10)

# 0---0   P(y=x|x)=1-f con f = 0.1
#  \ /
#x  X  y
#  / \
# 1---1

f = 0.1

py <- function(y,px0=0.9, f=0.1){#Marginal de y
    pyx_x <- 1-f
    if(y==0){
        return(px0*pyx_x+(1-px0)*(1-pyx_x))
    }
    if(y==1){
        return(px0*(1-pyx_x)+(1-px0)*pyx_x)
    }
}

H2 <- function(p){#Entropia binaria
    return(p*log(1/p,2) + (1-p)*log(1/(1-p),2))
}

IXY <- function(px0=0.9, f=0.1){#Mutual information
    return(H2(py(1,px0=px0,f=f))-H2(f))
}

capacity <- function(f=0.1){
    return(1- H2(f))
}

py(1)
H2(py(1))
px0 <- seq(0,1,by=0.01)
plot(px0,IXY(px0=px0))
abline(v=0.1)

capacity(0.1)


fs = seq(0.01,0.99,by=0.01)
plot(fs,capacity(fs))
