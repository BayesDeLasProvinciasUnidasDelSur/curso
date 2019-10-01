import numpy as np
import symmetricSigma as ss
def eigen(sigma):
    sigma_s = ss.symmetric(sigma)
    lambdx, u = np.linalg.eig(sigma_s)
    return lambdx, u
"""  # Always hold
lambdx, u = eigenvector(sigma)
np.dot(ss.symmetric(sigma),u) == lambdx*u """
np.arange(1,10).reshape((3,3)).transpose()