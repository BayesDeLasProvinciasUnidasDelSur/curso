import random
import numpy as np
from numpy.random import normal as noise 
import matplotlib.pyplot as plt
from scipy.stats import multivariate_normal as normal
from scipy.stats import norm 
import statsmodels.api as sm
import copy
#phi = polynomial_basis_function

random.seed(1)
np.random.seed(1)
cmap = plt.get_cmap("tab10")


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
alpha = (10e-6) # Bishop usa alpha = 5e-3

# Data 
X =np.random.rand(N,1)-0.5
t = sinus_model(X, 1/beta)

# Grilla
X_grilla = np.linspace(0, 1, 100).reshape(-1, 1)-0.5
y_grilla = np.linspace(-1.4, 1.4, 100).reshape(-1, 1)
y_true = sinus_model(X_grilla , 0)
plt.plot(X_grilla, y_true, '--', color="black")
plt.plot(X,t,'.', color='black')
plt.ylim(-1.5,1.5)
plt.savefig("pdf/model_selection_true_and_sample.pdf",bbox_inches='tight')
plt.savefig('png/model_selection_true_and_sample.png', bbox_inches='tight', transparent=False)
plt.close()    

# OLS 
import pandas as pd
data = pd.DataFrame({"X0": X[:,0]**0, 'X1':X[:,0],"X2": X[:,0]**2,"X3": X[:,0]**3,"X4": X[:,0]**4,"X5": X[:,0]**5,"X6": X[:,0]**6,"X7": X[:,0]**7,"X8": X[:,0]**8,"X9": X[:,0]**9})

X_grilla = np.linspace(0, 1, 100).reshape(-1, 1)-0.5
y_grilla = np.linspace(-1.4, 1.4, 100).reshape(-1, 1)
y_true = sinus_model(X_grilla , 0)
plt.plot(X_grilla, y_true, '--', color="black")
plt.plot(X,t,'.', color='black')
plt.ylim(-1.5,1.5)
for i in range(0,10):
    model = sm.OLS(t,data.iloc[:,0:(i+1)]).fit()
    pred = model.params["X0"]*X_grilla[:,0]**0
    for j in range(1,i+1):
        pred += model.params["X"+str(j)]*X_grilla[:,0]**j
    plt.plot(X_grilla[:,0], pred)
    if i == 3:
        pred3 = copy.deepcopy(pred)

plt.savefig("pdf/model_selection_OLS.pdf",bbox_inches='tight')
plt.savefig('png/model_selection_OLS.png', bbox_inches='tight', transparent=False)
plt.close()


X_grilla = np.linspace(0, 1, 100).reshape(-1, 1)-0.5
y_grilla = np.linspace(-1.4, 1.4, 100).reshape(-1, 1)
y_true = sinus_model(X_grilla , 0)
plt.plot(X_grilla, y_true, '--', color="black")
plt.plot(X,t,'.', color='black')
plt.ylim(-1.5,1.5)
plt.plot(X_grilla[:,0], pred, color=cmap(9))
plt.savefig("pdf/model_selection_OLS_best-at-train.pdf",bbox_inches='tight')
plt.savefig('png/model_selection_OLS_best-at-train.png', bbox_inches='tight', transparent=False)
plt.close()

plt.plot(X_grilla, y_true, '--', color="black")
plt.plot(X,t,'.', color='black')
plt.ylim(-1.5,1.5)
plt.plot(X_grilla[:,0], pred3, color=cmap(3))
plt.savefig("pdf/model_selection_OLS_best-at-test.pdf",bbox_inches='tight')
plt.savefig('png/model_selection_OLS_best-at-test.png', bbox_inches='tight', transparent=False)
plt.close()

model = sm.OLS(t,data).fit_regularized(method='elastic_net', alpha=0.0001, L1_wt=0.0)
pred = model.params[0]*X_grilla[:,0]**0
for i in range(1,10):
    pred += model.params[i]*X_grilla[:,0]**i

plt.plot(X_grilla[:,0], pred, color=cmap(9))
X_grilla = np.linspace(0, 1, 100).reshape(-1, 1)-0.5
y_grilla = np.linspace(-1.4, 1.4, 100).reshape(-1, 1)
y_true = sinus_model(X_grilla , 0)
plt.plot(X_grilla, y_true, '--', color="black")
plt.plot(X,t,'.', color='black')
plt.ylim(-1.5,1.5)
plt.savefig("pdf/model_selection_OLS_L2.pdf",bbox_inches='tight')
plt.savefig('png/model_selection_OLS_L2.png', bbox_inches='tight', transparent=False)
plt.close()

prior_predictive_online = np.zeros((10,1))
prior_maxAposteriori_online = np.zeros((10,1))
mean_square_error_MAP = np.zeros((10,1))
prior_predictive_joint = np.zeros((10,1)) 
log_evidence_joint = np.zeros((10,1)) 
w_map = []
maxAposteriori = []
maxApriori = []

def fit(alpha):
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
            if N >= 10:
                # Usamos los primeros 10 como entrenamiento
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





fit(alpha)
plt.close()
#plt.plot(prior_predictive_joint)
plt.plot(np.exp(log_evidence_joint))
plt.plot(np.exp(prior_predictive_online))
plt.close()
indices = np.arange(10)
total = sum(np.exp(log_evidence_joint))
cmap = plt.get_cmap("tab10")
for i in range(10):
    plt.bar(indices[i], np.exp(log_evidence_joint)[i]/total, align='center', color=cmap(i))


plt.xticks(ticks=indices)
ax = plt.gca()
ax.tick_params(axis='both', labelsize=20)
plt.savefig("pdf/model_selection_evidence.pdf",bbox_inches='tight')
plt.savefig('png/model_selection_evidence.png', bbox_inches='tight',transparent=False)
plt.close()    

plt.close()
plt.xticks(ticks=indices)
ax = plt.gca()
ax.tick_params(axis='both', labelsize=20)
total = sum(np.exp(prior_maxAposteriori_online))
for i in range(10):
    plt.bar(indices[i], np.exp(prior_maxAposteriori_online[i])/total, align='center', color=cmap(i))

#plt.plot(np.exp(prior_maxAposteriori_online))
plt.savefig("pdf/model_selection_maxApriori_online.pdf",bbox_inches='tight')
plt.savefig('png/model_selection_maxApriori_online.png', bbox_inches='tight',transparent=False)
plt.close()

plt.close()
total = sum(maxAposteriori)
plt.xticks(ticks=indices)
ax = plt.gca()
ax.tick_params(axis='both', labelsize=20)
for i in range(10):
    plt.bar(indices[i], maxAposteriori[i]/total, align='center', color=cmap(i))


plt.savefig("pdf/model_selection_maxLikelihood.pdf",bbox_inches='tight')
plt.savefig("png/model_selection_maxLikelihood.png",bbox_inches='tight',transparent=False)
plt.close()


prior_predictive_online = np.zeros((10,1))
prior_maxAposteriori_online = np.zeros((10,1))
mean_square_error_MAP = np.zeros((10,1))
prior_predictive_joint = np.zeros((10,1)) 
log_evidence_joint = np.zeros((10,1)) 
w_map = []
maxAposteriori = []
maxApriori = []

fit(10**(-6))

for d in range(0,10):#d=3
    Phi_grilla = polynomial_basis_function(X_grilla, np.array(range(d+1)) )
    y_map = Phi_grilla.dot(w_map[d])
    plt.plot(X_grilla,y_map  )


plt.ylim(-1.5,1.5)
Phi_grilla = polynomial_basis_function(X_grilla, np.array(range(3+1)) )
y_map = Phi_grilla.dot(w_map[3])
plt.plot(X_grilla,y_map, color="red"  )
plt.plot(X_grilla, y_true, '--', color="black")
plt.plot(X,t,'.', color='black')
plt.savefig("pdf/model_selection_MAP_non-informative.pdf",bbox_inches='tight')
plt.savefig("png/model_selection_MAP_non-informative.png",bbox_inches='tight',transparent=False)
plt.close()    


prior_predictive_online = np.zeros((10,1))
prior_maxAposteriori_online = np.zeros((10,1))
mean_square_error_MAP = np.zeros((10,1))
prior_predictive_joint = np.zeros((10,1)) 
log_evidence_joint = np.zeros((10,1)) 
w_map = []
maxAposteriori = []
maxApriori = []

fit(10**(-1))

for d in range(0,10):#d=3
    Phi_grilla = polynomial_basis_function(X_grilla, np.array(range(d+1)) )
    y_map = Phi_grilla.dot(w_map[d])
    plt.plot(X_grilla,y_map  )


plt.ylim(-1.5,1.5)
Phi_grilla = polynomial_basis_function(X_grilla, np.array(range(3+1)) )
y_map = Phi_grilla.dot(w_map[3])
plt.plot(X_grilla,y_map, color="red"  )
plt.plot(X_grilla, y_true, '--', color="black")
plt.plot(X,t,'.', color='black')
plt.savefig("pdf/model_selection_MAP_informative.pdf",bbox_inches='tight')
plt.savefig("png/model_selection_MAP_informative.png",bbox_inches='tight',transparent=False)
plt.close()    



###
# El prior es regularizador, pero en el sentido contrario: un prior poco informativo favorece a los modelos de menor grado.


prior_predictive_online = np.zeros((10,1))
prior_maxAposteriori_online = np.zeros((10,1))
mean_square_error_MAP = np.zeros((10,1))
prior_predictive_joint = np.zeros((10,1)) 
log_evidence_joint = np.zeros((10,1)) 
w_map = []
maxAposteriori = []
maxApriori = []

model_alpha = np.zeros((10,7))
for i in range(7):
    log_evidence_joint = np.zeros((10,1)) 
    print(i)
    fit(10**(-i))
    model_alpha[:,i] = (np.exp(log_evidence_joint)/sum(np.exp(log_evidence_joint))).reshape((10,))
    
for i in range(10):
    plt.plot(model_alpha[i,:], label=str(i) )


plt.legend(loc="upper left")
plt.xlabel("log10(Incertidumbre a priori)", size=18)
plt.ylabel("P(M | D)",size=18)
plt.savefig("pdf/regularizador.pdf",bbox_inches='tight')
plt.savefig("png/regularizador.png",bbox_inches='tight',transparent=False)
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
