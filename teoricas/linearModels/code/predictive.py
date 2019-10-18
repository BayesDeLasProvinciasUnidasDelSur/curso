import numpy as np
from posterior import posterior

#phi = polynomial_basis_function

def prior_predictive(t_test, X_test, beta, alpha, phi, t_train=None, X_train=None):
    
    N, D = X_test.shape  
    
    if t_train is None: t_train, X_train = np.zeros((0,1)), np.zeros((0,D))
    
    Phi_train = phi(X_train)
    m_belief, S_belief = posterior(Phi_train, t_train, alpha, beta)
    Phi_test = phi(X_test)  
    
    sigma2 = Phi_test.dot(S_belief.dot(Phi_test.T)) + (1/beta)*np.eye(Phi_test.shape[0])
    mu = Phi_test.dot(m_belief) # m_N.T.dot(Phi)
    return mu, sigma2

def prior_predictive(t_test, X_test, t_train, X_train, beta, alpha, phi):
    
    Phi_train = phi(X_train)
    m_belief, S_belief = posterior(Phi_train, t_train, alpha, beta)
    
    Phi_test = phi(X_test)  
    sigma2 = Phi_test.dot(S_belief.dot(Phi_test.T)) + (1/beta)*np.eye(Phi_test.shape[0])
    mu = Phi_test.dot(m_belief) # m_N.T.dot(Phi)
    return mu, sigma2

'''

HAY ALGO QUE NO ESTOY ENTENDIENDO

'''

def predictive(t, Phi, beta, alpha):
    ''' quizas deba deprecarse '''
    m_N, S_N = posterior(Phi, t, alpha, beta)
    sigma2 = Phi.dot(S_N.dot(Phi.T)) + (1/beta)*np.eye(Phi.shape[0])
    mu = Phi.dot(m_N) # m_N.T.dot(Phi)
    return mu, sigma2

def log_evidence(t, Phi, beta, alpha):
    N, M = Phi.shape
    
    m_N, S_N = posterior(Phi, t, alpha, beta)
        
    E_mN = (beta/2) * (t - Phi.dot(m_N)).T.dot(t - Phi.dot(m_N)) \
         + (alpha/2) * m_N.T.dot(m_N)
    
    A = np.linalg.inv(S_N)
    A_det = np.linalg.det(A)
    
    res = (M/2) * np.log(alpha)   \
        + (N/2) * np.log(beta)    \
        - E_mN                    \
        - (1/2) * np.log(A_det)   \
        - (N/2) * np.log(2*np.pi)
        
    return res
          
