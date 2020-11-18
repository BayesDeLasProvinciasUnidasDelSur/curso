import numpy as np
def covariance(eigenvalue,eigenvectors,inv=False):
    D = eigenvalue.shape[0]
    lambdx, u = eigenvalue, eigenvectors
    if inv == True: lambdx = 1/lambdx
    res = np.zeros((D,D))
    for i in range(D):
        res = res + lambdx[i]*np.dot(u[:,i].reshape((D,1)),u[:,i].reshape((1,D)))
    return sum(res)
""" # Always hold
ss.symmetric(sigma) == covariance(*eigenvector(sigma))
np.linalg.inv(ss.symmetric(sigma)) == covariance(*eigenvector(sigma),inv=True) """

 