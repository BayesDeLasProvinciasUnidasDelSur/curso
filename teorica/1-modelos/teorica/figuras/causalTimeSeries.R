oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"), width = 8, height = 5  )
setwd(this.dir)
###############################

library("CausalImpact")
library("ggplot2")

set.seed(1)
x <- 100 + arima.sim(model = list(ar = 0.999), n = 100)
y <- 1.2 * x + rnorm(100)
y[71:100] <- y[71:100] + 10

ymax <- max(x,y)
ymin <- min(x,y)

plot(y, ylim=c(ymin,ymax), lwd=2,axes = F,ann = F)
lines(x, lty=2)

axis(side=2, labels=NA,cex.axis=0.6,tck=0.015)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, cex.axis=1.5,line=-0.3)
axis(lwd=0,side=2,cex.axis=1.5,line=-0.3)
mtext("Tiempo", side=1, line=2.5,cex = 2)
mtext("Unidad de medida", side=2, line=2.5,cex = 2)


data <- cbind(y,  x)
pre.period <- c(1, 70)
post.period <- c(71, 100)

impact <- CausalImpact(data, pre.period, post.period)

ggsave(paste0(nombre,"2.pdf"), plot=plot(impact))

#######################################
# end 
dev.off()
setwd(oldwd)
par(oldpar, new=F)
#########################################
