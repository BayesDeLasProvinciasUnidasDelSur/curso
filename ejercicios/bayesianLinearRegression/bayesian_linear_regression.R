# Mensaje final del linear regression factor graph 
# Hermoso, la x se va
grilla <- seq(-10,20,by=0.1)
x <- 2
plot(grilla,dnorm(grilla,5,4),type="l")
lines(grilla/x,dnorm(grilla/x,5,4),type="l")
lines(grilla,dnorm(grilla/x,5,4),type="l")
lines(grilla,dnorm(grilla,x*5,4),type="l")

step <- 0.1
sum(dnorm(grilla/x,5,4)*step)
step <- 0.1
sum(dnorm(grilla,x*5,4)*step)

#############

"
Linear basis function 
=====================

Linear regression models share the property of being linear in their parameters but not necessarily in their input variables. 

Using non-linear basis functions of input variables, linear models are able model arbitrary non-linearities from input variables to targets.  
Polynomial regression is such an example of basis functions.

A linear regression model $\text{linear}(\bm{x},\bm{\beta})$

\begin{equation}
\text{linear}(\bm{x},\bm{\beta}) = \sum_{i=0}^{M-1} \beta_i \Phi_i(\bm{x}) = \bm{\beta}^T \bm{\Phi}(\bm{x})
\end{equation}
"
linear <- function(xs,betas){
  return(t(betas)%*%Phi(xs))
}
"
Where $\Phi$ is the basis function and $M$ the total number of parameters.
We define our polynomial basis functions for linear regression.
"
Phi <- function(xs,degree=3){
  res <- 1
  for (g in seq(degree)){
    res <- rbind(res,xs^g)  
  }
  rownames(res) <- seq(0,degree) # Each row corresponds to a degree
  colnames(res) <- xs            # Each row corresponds to sample
  return(res)
}
"
The target variable $y$ is given by the deterministic $\text{linear}(.)$ function with an aditive noice $u$
"
noice <- function(xs,alpha=4){
  N <- length(xs) 
  return(rnorm(N,0,alpha))
}
"
Then, the conditional distribution of $y$ $p(y | \bm{x}, \bm{\beta}, \alpha)$ can therefore be written as

\begin{equation}
p(\bm{y}_i | \bm{x}_i, \bm{\beta}, \alpha) = N(\bm{y}_i | linear(\bm{x}_i,\bm{\beta}), \alpha)
\end{equation}

Since we asume i.i.d., the joint conditional probability of $\bm{y}$

\begin{equation}
p(\bm{y} | \bm{x}, \bm{\beta}, \alpha) = \prod_i N(y | linear(\bm{x},\bm{\beta}), \alpha)
\end{equation}

"
likelihood <- function(ys,xs,betas,alpha){
  return(prod(dnorm(ys,linear(x,betas),alpha )))
}
"
Maximizing the log likelihood (= minimizing the sum-of-squares error function) gives the maximum likelihood estimate of parameters $\bm{\beta}$.
"
log_likelihood <- function(ys,xs,betas,alpha){
  return(-sum( (ys - t(betas)%*%Phi(xs) )^2  )) # \propro sum-of-squares error
}
"
Maximum likelihood estimation can lead to severe over-fitting if complex models (e.g. polynomial regression models of high order) are fit to datasets of limited size.
A common approach to prevent over-fitting is to add a regularization term to the error function.
As we will see shortly, this regularization term arises naturally when following a Bayesian approach (more precisely, when defining a prior distribution over parameters $\bm{\beta}$).
"
mle <- function(ys,xs){
  plot(xs,ys)
  mle <- lm(ys ~ 1 + I(x) + I(x^2) + I(x^3) )
  summary(mle)
  betas. <- coef(mle)
  
  grilla <- seq(-10,10,by=0.01) 
  lines(grilla,linear(grilla,betas.))
  
  
  likelihood(y,betas.,x,alpha)
}


"

"
x <- runif(n)*10 - 5


create_priors <- function(degree,mu=0,sigma=10){
  res <- cbind(rep(mu,degree+1),rep(sigma,degree+1))
  colnames(res) <- c("mu","sigma")
  return(res)
}

priors <- create_priors(3,sigma=1)

dlikelihood <- function(beta,y,x,mus,sigmas,i,alpha){#i=1
  mus[i] <- beta#beta=1
  #SD = sqrt(sum((xs[j,]*priors[,sigma])^2)+alpha^2 - )
  sigma = sqrt(sum(sigmas[-i]^2)+alpha^2 ) 
  return(likelihood(y,mus,x,sigma))
}

i=4
plot(grilla,sapply(grilla,function(z) dlikelihood(z,y,x,betas.,c(0,0,0,0),i,alpha) ),type="l")
abline(v=betas.[i])
summary(mle )


i=4
plot(grilla,sapply(grilla,function(z) dlikelihood(z,y,x,priors[,"mu"],priors[,"sigma"],i,alpha) ),type="l")
abline(v=betas.[i])
summary(mle )

betas <- betas.
beta <- 1



dprior <- function(beta, mu, sigma){
  return(dnorm(beta,mu,sigma))
}

dposterior <- function(beta,y,xs,priors,i){
  like <- sapply(beta,function(z) dlikelihood(z,y,x,priors[,"mu"],priors[,"sigma"],i,alpha))
  return(like*dprior(beta,priors[i,"mu"],priors[i,"sigma"]))
}
step=0.01
grilla <- seq(-3,3,by=step)

i=3
plot(grilla,joint_likelihood(grilla,y,xs,priors,i)/sum(joint_likelihood(grilla,y,xs,priors,i)*step),type="l")
lines(grilla,dprior(grilla,priors[i,"mu"],priors[i,"sigma"]),type="l")

betas.

summary(mle)

i=4
propto_dposterior <- dposterior(grilla,y,xs,priors,i)
plot(grilla,propto_dposterior/sum(propto_dposterior*step),type="l")
lines(grilla,dprior(grilla,priors[i,"mu"],priors[i,"sigma"]),type="l",lty=2)




############## 
# http://krasserm.github.io/2019/02/23/bayesian-linear-regression/


dlikelihood <- function(y,betas,xs,alpha){
  return(prod(dnorm(y,apply(xs*betas.,1,sum),alpha)))
}

dprior <- function(beta, mu, sigma,degree){
  return(dnorm(beta,mu,sigma*diag(degree)))
}

dprior()
