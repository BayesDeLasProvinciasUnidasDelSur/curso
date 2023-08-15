import bayesianlinearregression as blr # Archivo que está en la misma carpeta
import linear_model as lm # https://github.com/glandfried/bayesian-linear-model
from linear_model import BayesianLinearModel # https://github.com/glandfried/bayesian-linear-model
import random
import numpy as np
from numpy.random import normal as noise
import matplotlib.pyplot as plt
from scipy.stats import multivariate_normal as normal
from scipy.stats import norm 
import statsmodels.api as sm
#phi = polynomial_basis_function

random.seed(1)
np.random.seed(1)

# Noise precision
beta = (1)**2
# Prior precision
alpha = 1.0


# Ejemplo del libro MixTape

N = 1000
female = np.where(np.random.uniform(size=N) >= 0.5, 1, 0)
ability = np.random.normal(size=N)
discrimination = female
occupation = 1 + 2 * ability - 2 * discrimination + np.random.normal(size=N)
wage = 1 - 1*discrimination + 1*occupation + 2*ability + np.random.normal(size=N)

plt.scatter(ability,wage)
plt.show()

Xs = np.concatenate([np.ones(female.shape).reshape(N, 1), female.reshape(N, 1), occupation.reshape(N, 1), ability.reshape(N, 1)], axis=1)

blm = BayesianLinearModel(basis=lambda x: x)
blm.update(Xs, wage.reshape(N,1) )


mean = blm.location
cov = blm.dispersion

x_grilla = np.arange(0,2,step=0.01)
plt.plot(x_grilla ,normal(mean=mean[0], cov=np.sqrt(cov[0,0]) ).pdf(x_grilla ))
plt.show()

#marginal_dist = normal(mean=mean.reshape(4,), cov=cov)


#m_N, S_N = moments_posterior(alpha, beta, wage.reshape(N,1) , Xs)

#S_N[0,0]


