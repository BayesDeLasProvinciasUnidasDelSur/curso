
p = seq(0,1,by=0.01)
a = seq(0,1,by=0.01)
R = 100

escenarios = matrix(nrow=length(a),ncol=length(p))
for (i in seq(1,length(a)) ){
  for(j in seq(length(p))){
    escenarios[i,j] = R*(p[j]-a[i])
  }
}

plot(escenarios[1,],type="l",ylim = c(-R,R))
for(i in seq(2,length(a))){
  lines(escenarios[i,],type="l")
}
