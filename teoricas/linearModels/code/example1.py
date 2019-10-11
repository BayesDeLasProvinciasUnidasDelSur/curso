from posterior import posterior
from likelihood import likelihood
from generative import generative_model, synthetic_data
from basisFunctions import identity_basis_function, phi, polynomial_basis_function
import matplotlib.pyplot as plt
import numpy as np
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
t = generative_model(X, 1/beta, w0, w1)
# Test observations
X_grilla = np.linspace(-1, 1, 100).reshape(-1, 1)

# Function values without noise
y_true= generative_model(X_grilla , 0, w0, w1)

# Design matrix of test observations
Phi_grilla = phi(X_grilla, identity_basis_function)

w = np.array([-0.3,0.5]).reshape((2,1))

Phi = phi(X, identity_basis_function)

 w.T.dot(Phi.T)

I_w = np.eye(len(w))
I_t = np.eye(len(t))

w.T.dot((alpha*I_w)).dot(w)

(Phi.dot(w)).T.dot(beta*I_t).dot(Phi.dot(w))

beta*w.T.dot(Phi.T.dot(Phi)).dot(w)

w.T.dot(Phi.T)
 


#plt.plot(X_grilla,y_true)
#plt.plot(X,t,'.')

w0_grilla =  np.linspace(-1, 1, 100).reshape(-1, 1)
w1_grilla =  np.linspace(1, -1, 100).reshape(-1, 1)
def pdf(x, y):
    return normal.pdf(np.array([x,y]).ravel(),m_N.ravel(),S_N)
pdfv = np.vectorize(pdf)
def use_likelihood(x,y):#x=-0.3;y=0.5
    w = np.array([x,y]).reshape((2,1))
    return likelihood(w,T,Phi,beta)
lv = np.vectorize(use_likelihood)


plt.close()
plt.figure()
plt.subplots_adjust(hspace=0.4)   

for i, N in enumerate(N_list):#i=4;N=20
    X_N = X[:N]
    t_N = t[:N]

    # Design matrix of training observations
    Phi_N = phi(X_N, identity_basis_function)
    
    # Mean and covariance matrix of posterior
    m_N, S_N = posterior(Phi_N, t_N, alpha, beta)
    
    # Mean and variances of posterior predictive
    #y, y_var = posterior_predictive(Phi_test, m_N, S_N, beta)
    
    # Draw 5 random weight samples from posterior and compute y values
    w_samples = np.random.multivariate_normal(m_N.ravel(), S_N, 6).T
    y_samples = Phi_grilla.dot(w_samples)
    
    # Likelihood
    if i > 0:
        plt.subplot(len(N_list), 3, i * 3 + 1 )
        Phi = Phi_N[N_list[i-1]:,:]
        T = t_N[N_list[i-1]:,:]
        likeli = np.matrix(lv(w0_grilla[:, np.newaxis],w1_grilla))
        plt.imshow(likeli .T,extent=[-1,1,-1,1])
        plt.plot(w0,w1,'+',color="red")
    
        
    # Posterior
    plt.subplot(len(N_list), 3, i * 3 + 2)
    belief = np.matrix(pdfv(w0_grilla[:, np.newaxis],w1_grilla))
    plt.imshow(belief.T,extent=[-1,1,-1,1])
    plt.plot(w0,w1,'+',color="red")

    # Data space
    plt.subplot(len(N_list), 3, i * 3 + 3)
    plt.plot(X_grilla, y_samples)
    plt.ylim(-1., 1.)
    plt.plot(X_N, t_N,'.',color="black")

    
    
plt.savefig("img/example1.pdf", bbox_inches='tight')
    