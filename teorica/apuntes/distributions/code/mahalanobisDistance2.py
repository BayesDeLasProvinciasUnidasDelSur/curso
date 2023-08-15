import numpy as np
def mahalanobisDistance2(x, mu, sigma):
    sigma_inv = np.linalg.inv(sigma)
    return float(np.dot(np.transpose(x-mu),np.dot(sigma_inv,(x-mu))))