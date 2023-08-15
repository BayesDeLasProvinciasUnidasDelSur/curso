# git@github.com:ku-awdc/HarmonyWS2.git
# git@github.com:glandfried/HarmonyWS2.git
# ############################

set.seed(2023-06-05)
library("tidyverse")
library("runjags")
library("PriorGen")
runjags.options(silent.jags=TRUE)

#
# MODELO
#

modelo <- "model{
  s[1] ~ dbeta(1, 1)
  s[2] ~ dbeta(1, 1)
  x[1] ~ dbeta(1, 1)
  x[2] ~ dbeta(1, 1)

  for(c in 1:Comunidades){
    p[c] ~ dbeta(1, 1)

    q[1,c] <- p[c]*(1-s[1])*(1-s[2]) + (1-p[c])*x[1]*x[2]
    q[2,c] <- p[c]*(1-s[1])*s[2] + (1-p[c])*x[1]*(1-x[2])
    q[3,c] <- p[c]*s[1]*(1-s[2]) + (1-p[c])*(1-x[1])*x[2]
    q[4,c] <- p[c]*s[1]*s[2] + (1-p[c])*(1-x[1])*(1-x[2])

    r[1:4, c] ~ dmulti(q[1:4, c], N[c])
  }

  #data# r, N, Comunidades
  #monitor# p, s, x
  #inits# p, s, x
}"

#
# DATOS
#

sensitivity <- c(0.9, 0.6)
specificity <- c(0.95, 0.9)
M <- 5000
Populations <- 5
p <- c(0, 0.15, 0.3, 0.45, 0.7)
data <- tibble(Population = sample(seq_len(Populations), M, replace=TRUE)) %>%
  mutate(Status = rbinom(M, 1, p[Population])) %>%
  mutate(Test1 = rbinom(M, 1, sensitivity[1]*Status + (1-specificity[1])*(1-Status))) %>%
  mutate(Test2 = rbinom(M, 1, sensitivity[2]*Status + (1-specificity[2])*(1-Status)))
twoXtwoXpop <- with(data, table(Test2, Test1, Population))
r1 <- matrix(twoXtwoXpop, ncol=Populations)
r <- matrix(nrow=4,ncol=5)
r[,1] <- c(839, 104, 44, 7)
r[,2] <- c(754, 92,  85, 92)
r[,3] <- c(598, 99, 134, 151)
r[,4] <- c(503, 75, 187, 240)
r[,5] <- c(275, 61, 287, 373)
N <- apply(r, MARGIN=2, FUN=sum); Comunidades = 5

#
# Inferencia
#

# Set up initial values for 5 populations:
s <- list(chain1=c(0.5,0.99), chain2=c(0.99,0.5))
x <- list(chain1=c(0.5,0.99), chain2=c(0.99,0.5))
p <- list(chain1=c(0.1, 0.1, 0.1, 0.9, 0.9), chain2=c(0.9, 0.9, 0.9, 0.1, 0.1))

# And run the model:
results <- run.jags(modelo, n.chains=2)
plot(results)

