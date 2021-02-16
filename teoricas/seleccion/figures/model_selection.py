import random
import numpy as np
from numpy.random import normal as noise 
import matplotlib.pyplot as plt
from scipy.stats import multivariate_normal as normal
from scipy.stats import norm 
#phi = polynomial_basis_function

random.seed(999)

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

N = 20

beta = (1/0.2)**2
alpha = (5e-7) # Bishop usa alpha = 5e-3

# Data 
X =np.random.rand(N,1)-0.5
t = sinus_model(X, 1/beta)

# Grilla
X_grilla = np.linspace(0, 1, 100).reshape(-1, 1)-0.5
y_grilla = np.linspace(-1.4, 1.4, 100).reshape(-1, 1)
y_true = sinus_model(X_grilla , 0)

plt.plot(X_grilla, y_true, '--', color="black")
plt.plot(X,t,'.', color='black')
plt.savefig("pdf/model_selection_true_and_sample.pdf",bbox_inches='tight')
plt.savefig('png/model_selection_true_and_sample.png', bbox_inches='tight', transparent=True)
plt.close()    


prior_predictive_online = np.zeros((10,1))
prior_maxAposteriori_online = np.zeros((10,1))
mean_square_error_MAP = np.zeros((10,1))
prior_predictive_joint = np.zeros((10,1)) 
log_evidence_joint = np.zeros((10,1)) 
w_map = []
maxAposteriori = []
maxApriori = []
for d in range(10):#d=0
    for i in range(N) :#i=2
        X_priori = X[:i]
        t_priori = t[:i]
        x_posterior = X[i]
        t_posteriori = t[i]
        # Design matrix of training observations
        Phi_priori =  polynomial_basis_function(X_priori, np.array(range(d+1)) )
        Phi_posteriori = polynomial_basis_function(x_posterior , np.array(range(d+1)))
        Phi_posteriori = Phi_posteriori.reshape((1,d+1))
        
        prior_predictive_online[d,0] += np.log(predictive(t_posteriori, Phi_posteriori, beta, alpha, t_priori, Phi_priori ))
        
        ## Otros indicadores.
        w_map_prior = posterior(alpha, beta, t_priori, Phi_priori)[0]
        prior_maxAposteriori_online[d,0] += np.log(likelihood(w_map_prior, t_posteriori, Phi_posteriori , beta))
        mean_square_error_MAP[d,0] += (1/N) * ((t_posteriori - Phi_posteriori.dot(w_map_prior))**2)
        
                
    Phi =  polynomial_basis_function(X, np.array(range(d+1)) )
    prior_predictive_joint[d,0] = np.log(predictive(t, Phi, beta, alpha ))
    log_evidence_joint[d,0] = log_evidence(t, Phi, beta, alpha)
    w_map.append(posterior(alpha, beta, t, Phi)[0]) 
    maxAposteriori.append(likelihood(w_map[d], t, Phi, beta))
    # Joint max_a_priori
    "Joint max a priori es igual para todas las complejidades (Es independiente de las cantidad de par\'ametros)"
    Phi_priori =  polynomial_basis_function(X[:0], np.array(range(d+1)) )
    t_priori =  t[:0]
    w_maxAprior = posterior(alpha, beta, t_priori, Phi_priori )[0]
    maxApriori.append(likelihood(w_maxAprior , t, Phi, beta)[0])

plt.close()
#plt.plot(prior_predictive_joint)
plt.plot(np.exp(log_evidence_joint))
plt.plot(np.exp(prior_predictive_online))
plt.savefig("pdf/model_selection_evidence.pdf",bbox_inches='tight')
plt.savefig('png/model_selection_evidence.png', bbox_inches='tight',transparent=True)
plt.close()    

plt.close()
plt.plot(np.exp(prior_maxAposteriori_online))
plt.savefig("pdf/model_selection_maxApriori_online.pdf",bbox_inches='tight')
plt.savefig('png/model_selection_maxApriori_online.png', bbox_inches='tight',transparent=True)
plt.close()

plt.close()
plt.plot(np.exp(prior_maxAposteriori_online/N))
plt.savefig("pdf/model_selection_maxApriori_online_avg_prediction.pdf",bbox_inches='tight')
plt.savefig('png/model_selection_maxApriori_online_avg_prediction.png', bbox_inches='tight',transparent=True)
plt.close()


plt.close()
#plt.plot(prior_predictive_joint)
plt.plot(np.exp(log_evidence_joint/N))
plt.plot(np.exp(prior_predictive_online/N))
plt.savefig("pdf/model_selection_evidence_avg_prediction.pdf",bbox_inches='tight')
plt.savefig("png/model_selection_evidence_avg_prediction.png",bbox_inches='tight',transparent=True)
plt.close()        

plt.close()
plt.plot(np.log(maxAposteriori))
plt.savefig("pdf/model_selection_maxLikelihood_log.pdf",bbox_inches='tight')
plt.savefig("png/model_selection_maxLikelihood_log.png",bbox_inches='tight',transparent=True)
plt.close()        

plt.close()
plt.plot(maxAposteriori)
plt.savefig("pdf/model_selection_maxLikelihood.pdf",bbox_inches='tight')
plt.savefig("png/model_selection_maxLikelihood.png",bbox_inches='tight',transparent=True)
plt.close()        

for d in range(1,10):
    Phi_grilla = polynomial_basis_function(X_grilla, np.array(range(d+1)) )
    y_map = Phi_grilla.dot(w_map[d])
    plt.plot(X_grilla,y_map  )
    #plt.ylim(-1.1,1.1)
Phi_grilla = polynomial_basis_function(X_grilla, np.array(range(3+1)) )
y_map = Phi_grilla.dot(w_map[3])
plt.plot(X_grilla,y_map, color="black"  )
plt.plot(X,t,'.', color='black')
plt.savefig("pdf/model_selection_MAP.pdf",bbox_inches='tight')
plt.savefig("png/model_selection_MAP.png",bbox_inches='tight',transparent=True)
plt.close()    

"""
i=16
belief = np.zeros((len(y_grilla),len(X_grilla),10))
for d in range(10):#d=1
    Phi =  polynomial_basis_function(X[:i], np.array(range(d+1)) )
    for ix in range(len(X_grilla)):
        xi = X_grilla[ix]
        Phi_x = polynomial_basis_function(xi, np.array(range(d+1)))
        Phi_x = Phi_x.reshape((1,d+1))
        belief[:,ix,d] =  predictive(y_grilla, Phi_x, beta, alpha, t[:i], Phi)[::-1] 

max_dens = max(np.max(belief[:,:,3]),np.max(belief[:,:,9]))

plt.imshow(belief[:,:,3],vmin=0, vmax=max_dens)
plt.imshow(belief[:,:,4],vmin=0, vmax=max_dens)

plt.plot(y_grilla,np.flip(belief[:,0,3]))
plt.plot(y_grilla,np.flip(belief[:,0,9]))
plt.savefig("model_selection_evidence_3_9_at_0.pdf",bbox_inches='tight')
plt.close()    
"""
