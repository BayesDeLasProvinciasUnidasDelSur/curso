import numpy as np
from posterior import posterior
from scipy.stats import multivariate_normal as normal
#phi = polynomial_basis_function


def moments_predictive(Phi_test, beta, alpha, t_train=None, Phi_train=None):
    
    N, D = Phi_test.shape  
    
    if t_train is None: t_train, Phi_train = np.zeros((0,1)), np.zeros((0,D))
    
    m_prior, S_prior = posterior(alpha, beta, t_train, Phi_train)
    
    Phi_test.dot(S_prior.dot(Phi_test.T))
    
    sigma2 = Phi_test.dot(S_prior.dot(Phi_test.T)) + (1/beta)*np.eye(Phi_test.shape[0])
    mu = Phi_test.dot(m_prior) # m_N.T.dot(Phi)
    return mu, sigma2

def predictive(t_test, Phi_test, beta, alpha, t_train=None, Phi_train=None):
    
    m, S = moments_predictive(Phi_test, beta, alpha, t_train, Phi_train)
    return normal.pdf(t_test.ravel(),m.ravel(),S)

def log_evidence(t, Phi, beta, alpha):
    N, M = Phi.shape
    
    m_N, S_N = posterior(alpha, beta, t, Phi)
    
    #m_N == beta*S_N.dot(Phi.T).dot(t)
    
    A = np.linalg.inv(S_N)
    A_det = np.linalg.det(A)
    
    E_mN = (beta/2) * (t - Phi.dot(m_N)).T.dot(t - Phi.dot(m_N)) \
         + (alpha/2) * m_N.T.dot(m_N)
    
    res = (M/2) * np.log(alpha)   \
        + (N/2) * np.log(beta)    \
        - E_mN                    \
        - (1/2) * np.log(A_det)   \
        - (N/2) * np.log(2*np.pi)
        
    return res
          

