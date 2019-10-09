import numpy as np
from scipy.stats import norm 
def likelihood(w, t, Phi, beta):
    res = 1
    for i in range(len(t)):
        mean = w.T.dot(Phi[i])
        sigma = np.sqrt(beta**(-1))
        res =  res * norm.pdf(t[i],mean,sigma)
    return res