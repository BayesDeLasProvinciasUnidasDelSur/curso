n = 9
dp = 0.001
ps <- seq(0, 1, by=dp)

# P(k|n) = integral p en [0,1] P(k|p,n) * P(p|n) dp
# P(k|p,n) = dbinom(k, n, p)
# P(p|n) = dbeta(p, 1, 1) = Uniforme en [0,1]
# Si se cambia el prior P(p|n) y deja de ser uniforme,
# entonces P(k|n) deja de ser equiprobable
h <- c()
for (k in 0:n) {
  sum <- 0
  for (p in ps) {
    sum = sum + dbinom(k, n, p) * dbeta(p, 1, 1) * dp
  }
  h = c(h, sum)
}
barplot(h)

