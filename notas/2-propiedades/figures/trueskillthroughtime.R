oldpar <- par(no.readonly = TRUE)
oldwd <- getwd()
this.dir <- dirname(parent.frame(2)$ofile)
nombre.R <-  sys.frame(1)$ofile
require(tools)
nombre <- "trueskillthroughtime"
nombre <- print(file_path_sans_ext(nombre.R))
pdf(paste0(nombre,".pdf"), width = 8, height = 5  )
setwd(this.dir)
###############################

par(mar=c(3.75,3.75,0.25,0.25))
# @test isapprox(lc["a"][1][2],ttt.Gaussian(3.339079,4.985033),1e-5)
# @test isapprox(lc["a"][2][2],ttt.Gaussian(-1.735808,3.9225),1e-5)
# @test isapprox(lc["b"][1][2],ttt.Gaussian(-3.339079,4.985033),1e-5)
# @test isapprox(lc["b"][2][2],ttt.Gaussian(1.735808,3.9225),1e-5)
# ttt.convergence(h) 
# lc = ttt.learning_curves(h) 
# @test isapprox(lc["a"][1][2],ttt.Gaussian(0.0,2.39481),1e-5)
# @test isapprox(lc["a"][2][2],ttt.Gaussian(0.0,2.39481),1e-5)
# @test isapprox(lc["b"][1][2],ttt.Gaussian(0.0,2.39481),1e-5)
# @test isapprox(lc["b"][2][2],ttt.Gaussian(0.0,2.39481),1e-5)
s = seq(-16,16,by=0.01)

plot(s,dnorm(s,3.339079,4.985033),type="l",lwd=8, col=rgb(0.6,0.1,0.1),lty=1,axes = F,ann = F, ylim=c(0,max(dnorm(s,0,2.39481))))
lines(s,dnorm(s,0,2.39481),lwd=8, col=rgb(0.1,0.6,0.1),lty=1)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=0, labels=0,cex.axis=3,line=0.3)
#mtext(text ="Habilidad" ,side =1,line=2,cex=1.75)  
segments(0,0,0,max(dnorm(s,0,2.39481))+0.005, lty=3)
#legend(-16,max(dnorm(s,0,2.39481)), lwd=c(4,4),col=c(rgb(0.1,0.6,0.1,1),rgb(0.6,0.1,0.1,1)), legend = c("TrueSkill Through Time", "TrueSkill"),bty = "n",cex = 1.25)

plot(s,dnorm(s,-1.735808,3.9225),type="l",lwd=8, col=rgb(0.6,0.1,0.1),lty=1,axes = F,ann = F, ylim=c(0,max(dnorm(s,0,2.39481))))
lines(s,dnorm(s,0,2.39481),lwd=8, col=rgb(0.1,0.6,0.1),lty=1)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=0, labels=0,cex.axis=3,line=0.3)
#mtext(text ="Habilidad" ,side =1,line=2,cex=1.75)  
segments(0,0,0,max(dnorm(s,0,2.39481))+0.005, lty=3)
#legend(-16,max(dnorm(s,0,2.39481)), lwd=c(4,4),col=c(rgb(0.1,0.6,0.1,1),rgb(0.6,0.1,0.1,1)), legend = c("TrueSkill Through Time", "TrueSkill"),bty = "n",cex = 1.25)

plot(s,dnorm(s,-3.339079,4.985033),type="l",lwd=8, col=rgb(0.6,0.1,0.1),lty=1,axes = F,ann = F, ylim=c(0,max(dnorm(s,0,2.39481))))
lines(s,dnorm(s,0,2.39481),lwd=8, col=rgb(0.1,0.6,0.1),lty=1)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=0, labels=0,cex.axis=3,line=0.3)
#mtext(text ="Habilidad" ,side =1,line=2,cex=1.75)  
segments(0,0,0,max(dnorm(s,0,2.39481))+0.005, lty=3)
#legend(-16,max(dnorm(s,0,2.39481)), lwd=c(4,4),col=c(rgb(0.1,0.6,0.1,1),rgb(0.6,0.1,0.1,1)), legend = c("TrueSkill Through Time", "TrueSkill"),bty = "n",cex = 1.25)

plot(s,dnorm(s,1.735808,3.9225),type="l",lwd=8, col=rgb(0.6,0.1,0.1),lty=1,axes = F,ann = F, ylim=c(0,max(dnorm(s,0,2.39481))))
lines(s,dnorm(s,0,2.39481),lwd=8, col=rgb(0.1,0.6,0.1),lty=1)
axis(side=1, labels=NA,cex.axis=0.6,tck=0.015)
axis(lwd=0,side=1, at=0, labels=0,cex.axis=3,line=0.3)
#mtext(text ="Habilidad" ,side =1,line=2,cex=1.75)  
segments(0,0,0,max(dnorm(s,0,2.39481))+0.005, lty=3)
#legend(-16,max(dnorm(s,0,2.39481)), lwd=c(4,4),col=c(rgb(0.1,0.6,0.1,1),rgb(0.6,0.1,0.1,1)), legend = c("TrueSkill Through Time", "TrueSkill"),bty = "n",cex = 1.25)


#######################################
# end 
dev.off()
system(paste("pdfcrop -m '0 0 0 0'",paste0(nombre,".pdf") ,paste0(nombre,".pdf")))
setwd(oldwd)
par(oldpar, new=F)
#########################################
