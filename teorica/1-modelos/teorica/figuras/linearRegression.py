import numpy as np
from scipy.stats import norm 
import matplotlib.pyplot as plt
from numpy.random import normal as noise 
from scipy.stats import multivariate_normal as normal
import math

def moments_posterior(alpha, beta, t, Phi):
    S_N_inv = alpha * np.eye(Phi.shape[1]) + beta * Phi.T.dot(Phi)
    S_N = np.linalg.inv(S_N_inv)
    m_N = beta * S_N.dot(Phi.T).dot(t)
    return m_N, S_N

def posterior(x, y):
    return normal.pdf(np.array([x,y]).ravel(),m_N.ravel(),S_N)

_posterior_v = np.vectorize(posterior)

def moments_prior(alpha, beta, M):
    S_0_inv = alpha * np.eye(M)
    S_0 = np.linalg.inv(S_0_inv)
    m_0 = np.zeros((1,M))
    return m_0, S_0

def likelihood(w, t, Phi, beta):
    res = 1
    for i in range(len(t)):
        mean = w.T.dot(Phi[i])
        sigma = np.sqrt(beta**(-1))
        res =  res * norm.pdf(t[i],mean,sigma)
    return res

def linear_model(X, variance, w0 = -0.3, w1 = 0.5):
    '''Linear function plus noise'''
    return w0 + w1 * X + noise(0,np.sqrt(variance),X.shape)

def identity_basis_function(x):
    return x

def phi(x, bf, args=None):
    if args is None:
        return np.concatenate([np.ones(x.shape), bf(x)], axis=1)
    else:
        return np.concatenate([np.ones(x.shape)] + [bf(x, *args)], axis=1)

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

# Noise precision 
beta = (1/0.2)**2

# Prior precision
alpha = 2.0

# True belief
w0 = -0.3; w1 = 0.5
w = np.array([w0,w1]).reshape((2,1))

# Samples sizes
N_list = [0, 1, 2, 4,20]

# Observed data in [-1, 1)
X =np.append([0.75,-0.75],np.random.rand(N_list[-1]-2,1)*2-1).reshape((N_list[-1],1))

# Observed traget
t = linear_model(X, 1/beta, w0, w1)

# Basis function
Phi = phi(X, identity_basis_function)

# Some grids for plot
X_grilla = np.linspace(-1, 1, 100).reshape(-1, 1)
Phi_grilla = phi(X_grilla, identity_basis_function)
w0_grilla =  np.linspace(-1, 1, 100).reshape(-1, 1)
w1_grilla =  np.linspace(1, -1, 100).reshape(-1, 1)
y_grilla = w1_grilla
X_, Y_ = np.meshgrid(X_grilla, y_grilla)

for i, N in list(enumerate(N_list[::-1])):#i=2;N=2
    j = len(N_list)-1-i
    
    X_N = X[:N]
    t_N = t[:N]

    # Design matrix of training observations
    Phi_N = phi(X_N, identity_basis_function)
    
    # Mean and covariance matrix of posterior
    m_N, S_N = moments_posterior(alpha, beta,t_N, Phi_N)
       
    # Sample beliefs from posterior
    w_samples = np.random.multivariate_normal(m_N.ravel(), S_N, 6).T
    
    # target from sampled beliefs
    y_samples = Phi_grilla.dot(w_samples)
    
    # Likelihood
    if N != 0:
        Phi = Phi_N[N_list[j-1]:,:]
        T = t_N[N_list[j-1]:,:]
        def use_likelihood(x,y):#x=-0.3;y=0.5
            w = np.array([x,y]).reshape((2,1))
            return likelihood(w,T,Phi,beta)
        lv = np.vectorize(use_likelihood)
        likeli = np.matrix(lv(w0_grilla[:, np.newaxis],w1_grilla))
        plt.imshow(likeli .T,extent=[-1,1,-1,1])
        plt.scatter(w0,w1, s=[100],color="red")
        plt.xticks(ticks=[-1,0,1])
        plt.yticks(ticks=[-1,0,1])
        ax = plt.gca()
        ax.tick_params(axis='both', labelsize=20)
        plt.tight_layout()
        plt.savefig("pdf/linearRegression_likelihood_{}.pdf".format(j))
        plt.savefig("png/linearRegression_likelihood_{}.png".format(j), transparent=True)
        plt.close()
        
    # Posterior
    belief = _posterior_v(X_,Y_)
    plt.imshow(belief,extent=[-1,1,-1,1])
    plt.scatter(w0,w1,s=[100],color="red")
    plt.xticks(ticks=[-1,0,1])
    plt.yticks(ticks=[-1,0,1])
    ax = plt.gca()
    ax.tick_params(axis='both', labelsize=20)
    plt.tight_layout()
    plt.savefig("pdf/linearRegression_posterior_{}.pdf".format(j))
    plt.savefig("png/linearRegression_posterior_{}.png".format(j), transparent=True)
    plt.close()

    # Data space
    plt.plot(X_grilla, y_samples)
    plt.ylim(-1., 1.)
    plt.xticks(ticks=[-1,0,1])
    plt.yticks(ticks=[-1,0,1])
    ax = plt.gca()
    ax.tick_params(axis='both', labelsize=20)
    plt.scatter(X_N, t_N,s=[100]*len(X_N),color="black")
    plt.savefig("pdf/linearRegression_dataSpace_{}.pdf".format(j))
    plt.savefig("png/linearRegression_dataSpace_{}.png".format(j), transparent=True)
    plt.close()


Phi = phi(X, identity_basis_function)
m, S = moments_posterior(alpha, beta, t, Phi)
def _predictive(x, y):#mu=m_N.T; x=0.5
    Phi_new = phi(np.array([x]).reshape((1,1)), identity_basis_function)
    Phi_new = Phi_new.T
    return normal.pdf(y,np.squeeze(m.T.dot(Phi_new)),np.sqrt((1/beta)+np.squeeze(Phi_new.T.dot(S.dot(Phi_new)))[0]) )
_predictive_v = np.vectorize(_predictive)
belief = _predictive_v(X_, Y_)
max_pedictive = np.max(belief)
levels = np.arange(0, math.floor(max_pedictive*100)/100 , 0.1)

plt.imshow(belief,extent=[-1,1,-1,1],vmin=0, vmax=1.1, cmap="gray_r" )
CS = plt.contour(X_,Y_,belief,levels,colors="black",alpha = 0.8)
y_map = linear_model(X_grilla , 0, *m)
plt.plot(X_grilla,y_map,color="black",alpha=1)
plt.plot([-0.75,-0.75],[-1,1],":",color="blue")
plt.plot([0,0],[-1,1],"--",color="red")
plt.plot([0.75,0.75],[-1,1],"-.",color="green")
#plt.plot(X, t,'.',color="black",alpha=1)
plt.tight_layout()
plt.savefig("pdf/linearRegression_predictive.pdf",bbox_inches='tight')
plt.savefig("png/linearRegression_predictive.png",bbox_inches='tight', transparent=True)
plt.close()



plt.plot(X_grilla,belief[:,0] ,":",color="blue")
plt.plot(X_grilla,belief[:,50],"--",color="red")
plt.plot(X_grilla,belief[:,-1],"-.",color="green")
plt.tight_layout()
plt.savefig("pdf/linearRegression_predictive_longitudinal.pdf",bbox_inches='tight')
plt.savefig("png/linearRegression_predictive_longitudinal.png",bbox_inches='tight', transparent=True)
plt.close()



