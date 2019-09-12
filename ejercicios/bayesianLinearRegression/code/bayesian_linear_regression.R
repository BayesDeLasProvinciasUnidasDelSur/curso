objective <- function(x){
  return(sin(x))
}

x_grilla <- seq(-pi,pi,by=0.01)
plot(x_grilla,objective(x_grilla),type="l")


Phi <- function(xs,degree=3){
  res <- 1
  for (g in seq(degree)){
    res <- rbind(res,xs^g)  
  }
  rownames(res) <- seq(0,degree) # Each row corresponds to a degree
  colnames(res) <- xs            # Each row corresponds to sample
  return(res)
}

n <- 1
x <- runif(n)*2*pi-pi
y <- objective(x)
sigma_u <-1/3
plot(x_grilla,objective(x_grilla),type="l",ylim=c(-1-1.5*sigma_u,1+1.5*sigma_u),lwd=2)

sigma <- c(1,1)
mu <- c(0,0)

betas_sample <- cbind(rnorm(6,mu[1],sigma[1]),rnorm(6,mu[2],sigma[2]))
for (i in 1:dim(betas_sample)[1]) {
  abline(betas_sample[i,],lty=2)
}



y <- rnorm(length(x),y,sigma_u)
points(x,y,pch=19,col=rgb(0,0,0,0.33))


beta_grilla <- seq(-4,4,by=0.01)



i<-1
prior_0 <- dnorm(beta_grilla,mu[i],sigma[i])
plot(beta_grilla,prior_0,type="l")
mu_ML <- c((t(sigma[-i])%*%xs[-i])) + xs[i]*beta_grilla
sigma_ML <- sqrt(c((t(sigma[-i])^2)%*%(xs[-i])^2) + sigma_u^2)
likelihood_0 <- dnorm(y,mu_ML, sigma_ML)
lines(beta_grilla,likelihood_0,lty=2)
lines(beta_grilla,prior_0*likelihood_0,lty=3)
evidence_0 <- sum(prior_0*likelihood_0*0.01)
lines(beta_grilla,prior_0*likelihood_0/sum(prior_0*likelihood_0*0.01),lty=3)

i<-2
prior_1 <- dnorm(beta_grilla,mu[i],sigma[i])
plot(beta_grilla,prior_1,type="l")
mu_ML <- c((t(sigma[-i])%*%xs[-i])) + xs[i]*beta_grilla
sigma_ML <- sqrt(c((t(sigma[-i])^2)%*%(xs[-i])^2) + sigma_u^2)
likelihood_1 <- dnorm(y,mu_ML, sigma_ML)
lines(beta_grilla,likelihood_1,lty=2)
lines(beta_grilla,prior_1*likelihood_1,lty=3)
evidence_1 <- sum(prior_1*likelihood_1*0.01)
lines(beta_grilla,prior_1*likelihood_1/evidence_1,lty=3)

joint_prior <- outer(prior_0,prior_1)
image(joint_prior)
joint_likelihood <- outer(likelihood_0,likelihood_1)
image(joint_likelihood) 
joint_posterior <- outer(likelihood_0*prior_0/evidence_0,likelihood_1*prior_1/evidence_1)
image(joint_posterior)
# Ac\'a me qued\'e pensando que posiblemente el modelo no deba 
# ser independiente respecto de los valores de los par\'ametros
# Porque si la ordenada al origen fuera muuuy alta, para que la recta pase por los puntos
# el parametro de la pendiente tiene que ser negativo. 
# Es decir, no deber\'ian ser independientes.
# Esto se refuerza por el hecho de que el libro de Bishop 
# grafica el likelihood conjunto como una ``recta'',
# como una gausiana que cambia su media a medida que el otro par\'atro cambia su valor de base.

# Antes de pasar a una soluci\'on con covarianzas vamos a explorar:
# 1. Ver que muestras de par\'ametros se obtienen de la posterior
# 2. Proponer un likelihood ``ad-hoc'', donde en vez de usar la media de la 
# creencia a priori (\mu_i) y sume su incertidumbre, use ``valores posibles'', 
# es decir, que fije el valor de \beta_i y no agregue la incertidumbre del modelo
# Capaz eso es lo que est\'a pasando en los modelos con covarianza. Es una sola normal,
# que se se actualiza sobre todos los par\'amtros, al tiempo, por eso todos argumentos
# del likelihood y por eso el likelihood no arrastra su incertidumbre.


# Expoloraci\'on 1: Ver muestras de par\'ametros que se obtienen de la posterior
# Queremos sacar la posterior anal\'itica. Ya la tengo, pero trabajando com media y varianza 
# en vez de con media y precision, se hace solo un poco dif\'icil pasarlo r\'apido, y me tengo que ir
denominador_0 <- sigma[1]^2 + (sigma[2]^2 + sigma_u^2)
denominador_1 <- sigma[2]^2 + (sigma[1]^2 + sigma_u^2)/(x^2)  



betas_sample <- cbind(rnorm(6,mu[1],sigma[1]),rnorm(6,mu[2],sigma[2]))
for (i in 1:dim(betas_sample)[1]) {
  abline(betas_sample[i,],lty=2)
}

# Expoloraci\'on 2: Modificar el likelihood ``ad-hoc''
likelihood_conjunto <- function(b0,b1,y,x,mu,sigma,sigma_u){
  xs <- Phi(x,degree=2)
  mu_ML <- b0 + xs[2]*b1
  sigma_ML <- sigma_u
  return()
}






posterior <- function(beta,i,y,x,mu,sigma,sigma_u){#i=0; beta=beta_grilla
  xs <- Phi(x,degree=2)
  i = i + 1 # pensando en que 0 es el primer elemento
  # Si pasan el elemento 0 lo busco en la posici\'on 1
  prior <- dnorm(beta,mu[i],sigma[i])
  
  mu_ML <- c((t(sigma[-i])%*%xs[-i])) + xs[i]*beta
  sigma_ML <- sqrt(c((t(sigma[-i])^2)%*%(xs[-i])^2) + sigma_u^2)
  likelihood <- dnorm(y,mu_ML, sigma_ML)
  return(prior*likelihood)
}













# Mensaje final del linear regression factor graph 
# Hermoso: la x pasa al mu y sigma y constante afuera
# de la normal

x <- 6
step <- 0.1; epsilon <- step/10
beta_ventana <- 20
# la grilla x.beta la hago depender de beta y x
x.beta <- seq(-beta_ventana*x,beta_ventana*x,step) 
######################################################
# Es f\'acil demostrar anal\'iticamente lo siguiente #
dnorm(x.beta/x,5,4)==dnorm(x.beta,x*5,x*4)*x         #
######################################################
# Notar que no integra uno 
x-epsilon<sum(dnorm(x.beta/x,5,4)*0.1) & sum(dnorm(x.beta/x,5,4)*0.1)<x+epsilon

# La transformaci\'on no tiene que ser la misma
plot(x.beta/x,dnorm(x.beta/x,5,4),type="l")
lines(x.beta,dnorm(x.beta,x*5,x*4),col="red")

#####################
# Probar la siguiente igualdad
# if x ~ N(m,s) => (x - m)/s ~ N(0,1)

x <- seq(-20,20,0.1)
# La transformnaci\'on no tiene que ser la misma
plot(x,dnorm(x,5,4),type="l")
lines((x-5)/4,dnorm((x-5)/4,(5-5)/4,4/4),type="l")
# Ac\'a encontramos cu\'al es, 
plot(x,dnorm(x,0,1),type="l")
lines((x-5)/4,dnorm((x-5)/4,0,1),type="l")

# Si solo dividimos 
plot(x,dnorm(x,5,4),type="l")
lines(x/4,dnorm(x/4,5/4,4/4),type="l")



# if x ~ N(m,s) => x * a ~ N(a*m,a*s)
a <- 2
plot(x,dnorm(x,5,4),type="l")
y = a*x
lines(y,(1/a)*dnorm(y/a,5,4),lty=2)
lines(x,dnorm(x,a*5,a*4),lty=3)
lines(y/a,dnorm(y/a,a*5,a*4),lty=3)

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

