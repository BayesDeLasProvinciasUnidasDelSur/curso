import numpy as np
def predictive(m_N, S_N, Phi, beta):
    sigma2 = Phi.dot(S_N.dot(Phi.T)) + (1/beta)*np.eye(Phi.shape[0])
    mu = Phi.dot(m_N) # m_N.T.dot(Phi)
    return mu, sigma2
