import numpy as np
import mahalanobisDistance2 as md2
def symmetric(sigma):
    inv = np.linalg.inv(sigma)
    inv_s = (inv + np.transpose(inv)) /2
    return np.linalg.inv(inv_s)
    
"""            Always hold
(md2.mahalanobisDistance2(x, mu, sigma)
                    == 
md2.mahalanobisDistance2(x, mu, symmetric(sigma)))"""