import numpy as np
import mahalanobisDistance2 as md2
def multivariateGaussian(x, mu, sigma):  
    D = mu.shape[0]
    det = np.linalg.det(sigma)
    distance2 = md2.mahalanobisDistance2(x,mu,sigma)
    return 1/((2*np.pi)**(D/2)) * 1/(det**(1/2)) * np.exp(-(1/2)*distance2)