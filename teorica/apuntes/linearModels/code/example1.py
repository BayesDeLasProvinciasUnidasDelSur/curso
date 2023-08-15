#http://krasserm.github.io/2019/02/23/bayesian-linear-regression/
from posterior import posterior
#from mathematics import pdf, cdf
from likelihood import likelihood
from generative import linear_model
from basisFunctions import identity_basis_function, phi#,polynomial_basis_function
import matplotlib.pyplot as plt
import numpy as np
import math
from scipy.stats import multivariate_normal as normal
# Training dataset sizes
N_list = [0, 1, 2, 4,20]

plt.close()
beta = (1/0.2)**2
alpha = 2.0

w0 = -0.3
w1 = 0.5

# Data observations in [-1, 1)
X =np.append([0.75,-0.75],np.random.rand(N_list[-1]-2,1)*2-1).reshape((N_list[-1],1))

# Training target values
t = linear_model(X, 1/beta, w0, w1)
# Test observations
X_grilla = np.linspace(-1, 1, 100).reshape(-1, 1)

# Function values without noise
y_true= linear_model(X_grilla , 0, w0, w1)

# Design matrix of test observations
Phi_grilla = phi(X_grilla, identity_basis_function)

w = np.array([-0.3,0.5]).reshape((2,1))

Phi = phi(X, identity_basis_function)

#plt.plot(X_grilla,y_true)
#plt.plot(X,t,'.')

w0_grilla =  np.linspace(-1, 1, 100).reshape(-1, 1)
w1_grilla =  np.linspace(1, -1, 100).reshape(-1, 1)
y_grilla = w1_grilla
X_, Y_ = np.meshgrid(X_grilla, y_grilla)
def _posterior(x, y):
    return normal.pdf(np.array([x,y]).ravel(),m_N.ravel(),S_N)
_posterior_v = np.vectorize(_posterior)
def _predictive(x, y):#mu=m_N.T; x=0.5
    Phi_new = phi(np.array([x]).reshape((1,1)), identity_basis_function)
    Phi_new = Phi_new.T
    return normal.pdf(y,float(m_N.T.dot(Phi_new)),np.sqrt((1/beta)+float(Phi_new.T.dot(S_N.dot(Phi_new)))) )
_predictive_v = np.vectorize(_predictive)
def use_likelihood(x,y):#x=-0.3;y=0.5
    w = np.array([x,y]).reshape((2,1))
    return likelihood(w,T,Phi,beta)
lv = np.vectorize(use_likelihood)

for i, N in list(enumerate(N_list[::-1])):#i=2;N=2
    j = len(N_list)-1-i
    
    X_N = X[:N]
    t_N = t[:N]

    # Design matrix of training observations
    Phi_N = phi(X_N, identity_basis_function)
    
    # Mean and covariance matrix of posterior
    m_N, S_N = posterior(alpha, beta,t_N, Phi_N)
       
    # Mean and variances of posterior predictive
    #y, y_var = posterior_predictive(Phi_test, m_N, S_N, beta)
    
    # Draw 5 random weight samples from posterior and compute y values
    w_samples = np.random.multivariate_normal(m_N.ravel(), S_N, 6).T
    y_samples = Phi_grilla.dot(w_samples)
    
    # Likelihood
    if N != 0:
        Phi = Phi_N[N_list[j-1]:,:]
        T = t_N[N_list[j-1]:,:]
        likeli = np.matrix(lv(w0_grilla[:, np.newaxis],w1_grilla))
        plt.imshow(likeli .T,extent=[-1,1,-1,1])
        plt.plot(w0,w1,'+',color="red")
        plt.tight_layout()
        plt.savefig("img/example1_likelihood_{}.pdf".format(j))
        plt.close()
        
    # Posterior
    belief = _posterior_v(X_,Y_)
    plt.imshow(belief,extent=[-1,1,-1,1])
    plt.plot(w0,w1,'+',color="red")
    plt.tight_layout()
    plt.savefig("img/example1_posterior_{}.pdf".format(j))
    plt.close()

    # Data space
    plt.plot(X_grilla, y_samples)
    plt.ylim(-1., 1.)
    plt.plot(X_N, t_N,'.',color="black")
    plt.savefig("img/example1_dataSpace_{}.pdf".format(j))
    plt.close()
    
    # Predictive
    belief = _predictive_v(X_, Y_)
    if i == 0: 
        max_pedictive = np.max(belief)
        levels = np.arange(0, math.floor(max_pedictive*100)/100 , 0.05)
    plt.imshow(belief,extent=[-1,1,-1,1],vmin=0, vmax=max_pedictive)
    CS = plt.contour(X_,Y_,belief,levels,colors="black",alpha = 0.1)
    #plt.clabel(CS, inline=1, fontsize=10)
    
    y_map = linear_model(X_grilla , 0, *m_N)
    plt.plot(X_grilla,y_map,color="black",alpha=0.7)
    if i > 0: 
        plt.plot(X[N_list[j]:N_list[j+1]], t[N_list[j]:N_list[j+1]],'o',color="black",mfc='none')
    plt.plot(X_N[:N_list[j],:], t_N[:N_list[j],:],'.',color="black",alpha=1)
    
    plt.tight_layout()
    plt.savefig("img/example1_predictive_{}.pdf".format(j))
    plt.close()
    
    #plt.plot(X_grilla,belief[:,50])
    #plt.plot(y_grilla,belief[50,:].T)
    #plt.plot(y_grilla,belief[0,:].T)
    