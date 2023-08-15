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

def moments_posterior(alpha, beta, t, Phi):
    S_N_inv = alpha * np.eye(Phi.shape[1]) + beta * Phi.T.dot(Phi)
    S_N = np.linalg.inv(S_N_inv)
    m_N = beta * S_N.dot(Phi.T).dot(t)
    return m_N, S_N


def posterior(alpha, beta, t, Phi):
    S_N_inv = alpha * np.eye(Phi.shape[1]) + beta * Phi.T.dot(Phi)
    S_N = np.linalg.inv(S_N_inv)
    m_N = beta * S_N.dot(Phi.T).dot(t)
    return m_N, S_N

def likelihood(w, t, Phi, beta):
    res = 1
    for i in range(len(t)):
        mean = w.T.dot(Phi[i])
        sigma = np.sqrt(beta**(-1))
        res =  res * norm.pdf(t[i],mean,sigma)
    return res

def moments_predictive(Phi_posteriori, beta, alpha, t_priori=None, Phi_priori=None):
    
    N, D = Phi_posteriori.shape  
    
    if t_priori is None: t_priori, Phi_priori = np.zeros((0,1)), np.zeros((0,D))
    
    m_prior, S_prior = posterior(alpha, beta, t_priori, Phi_priori)
    
    Phi_posteriori.dot(S_prior.dot(Phi_posteriori.T))
    
    sigma2 = Phi_posteriori.dot(S_prior.dot(Phi_posteriori.T)) + (1/beta)*np.eye(Phi_posteriori.shape[0])
    mu = Phi_posteriori.dot(m_prior) # m_N.T.dot(Phi)
    return mu, sigma2

def predictive(t_posteriori, Phi_posteriori, beta, alpha, t_priori=None, Phi_priori=None):
    
    m, S = moments_predictive(Phi_posteriori, beta, alpha, t_priori, Phi_priori)
    return normal.pdf(t_posteriori.ravel(),m.ravel(),S)

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

def sinus_model(X, variance):
    '''Sinus function plus noise'''
    return np.sin(2 * np.pi * X) + noise(0,np.sqrt(variance),X.shape)

def polynomial_basis_function(x, degree=1):
    return x ** degree
