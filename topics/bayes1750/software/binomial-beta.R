library(manipulate)
dx = 0.01
x = seq(0, 1, dx)

f = function(k,n,p) {
  par(mfrow=c(1,2))
  binom <- dbinom(0:n, n, p)
  names(binom) <- 0:n
  cols <- rep('grey', n+1)
  cols[k+1] = 'red'
  barplot(binom, col=cols)
  plot(x, dbeta(x, k+1, n-k+1), type = "l")
  abline(v=p, col='red')
}

manipulate(f(k,n,p),
           k=slider(0, 50, initial=5),
           n=slider(0, 50, initial=10),
           p=slider(0,1,initial=.5,step=.05))
