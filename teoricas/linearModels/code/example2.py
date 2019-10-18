#http://krasserm.github.io/2019/02/23/bayesian-linear-regression/
from posterior import posterior
from predictive import predictive, log_evidence
#from mathematics import pdf, cdf
from likelihood import likelihood
from generative import linear_model, sinus_model
from basisFunctions import identity_basis_function, phi, polynomial_basis_function
import matplotlib.pyplot as plt
import numpy as np
import math
from scipy.stats import multivariate_normal as normal
# Training dataset sizes
plt.close()
N_list = [0, 1, 2, 4,25]

beta = (1/0.2)**2
'''
Bishop usa alpha = 5e-3
'''
alpha = (5e-12)

# Data 
X =np.random.rand(N_list[-1],1)-0.5
t = sinus_model(X, 1/beta)

# Grilla
X_grilla = np.linspace(0, 1, 100).reshape(-1, 1)-0.5
y_grilla = np.linspace(-1.4, 1.4, 100).reshape(-1, 1)
# Function values without noise
y_true = sinus_model(X_grilla , 0)
X_, Y_ = np.meshgrid(X_grilla, y_grilla,sparse=True)

online_evidence = np.zeros((10,1))
joint_evidence = np.zeros((10,1))


joint_evidence = np.zeros((10,1))
for d in range(10):#i=2;N=25
    #d = 3
    
    Phi =  polynomial_basis_function(X, np.array(range(d+1)) )
    joint_evidence[d,0] = log_evidence(t,Phi,beta,alpha)
    
    #Phi = Phi_N    
plt.close()
plt.plot(joint_evidence/N_list[-1])
    
for d in range(10):#i=2;N=25
    #d = 3
    m_0 = np.zeros((d+1,1))
    S_0 = (1/alpha)*np.eye(d+1)
    Phi_new =  polynomial_basis_function(0.33, np.array(range(d+1)) )
    predictive(y_grilla, Phi_new , beta, alpha)
    
    for i in range(N_list[-1]) :#i=24   
        
        X_N = X[:i]
        t_N = t[:i]
        x_new = X[i]
        t_new = t[i]
        # Design matrix of training observations
        Phi_N =  polynomial_basis_function(X_N, np.array(range(d+1)) )
        Phi_new = polynomial_basis_function(x_new , np.array(range(d+1)))
        
        # Mean and covariance matrix of posterior
        m_N, S_N = posterior(Phi_N, t_N, alpha, beta)
        
        Phi_new = Phi_new.reshape((1,d+1))
        mus, sigmas2 = predictive(m_N, S_N, Phi_new, beta)    
        log_evidence = np.log10(normal.pdf(t_new.ravel(),mus.ravel(),np.sqrt(sigmas2)))
        online_evidence[d,0] += log_evidence
        
        if d == 9:
            Phi_grilla = polynomial_basis_function(X_grilla, np.array(range(d+1)) )
            w_samples = np.random.multivariate_normal(m_N.ravel(), S_N, 6).T
            y_samples = Phi_grilla.dot(w_samples)
            
            plt.plot(X_grilla,y_samples,alpha=0.6)
            plt.plot(X_N,t_N,'.',color="black")
            
            belief = np.zeros((len(y_grilla),len(X_grilla)))
            moments = np.zeros((len(X_grilla),2))
            for ix in range(len(X_grilla)):
                xi = X_grilla[ix]
                Phi_new = polynomial_basis_function(xi, np.array(range(d+1)))
                Phi_new = Phi_new.reshape((1,d+1))
                moments[ix,:] = predictive(t, Phi_new , beta, alpha)
                belief[:,ix] =   normal.pdf(y_grilla,moments[ix,0],np.sqrt(moments[ix,1]))[::-1]
            plt.imshow(belief,extent=[-0.5,0.5,-1.4,1.4])
            plt.plot(X_grilla, y_true,color="black")
            plt.plot(X_grilla,moments[:,0],color="red",linewidth=2.0)
            plt.plot(X_grilla,moments[:,0]+np.sqrt(moments[:,1]),color="white")
            plt.plot(X_grilla,moments[:,0]-np.sqrt(moments[:,1]),color="white")
            plt.plot(X_grilla,moments[:,0]+2*np.sqrt(moments[:,1]),color="white")
            plt.plot(X_grilla,moments[:,0]-2*np.sqrt(moments[:,1]),color="white")
            plt.plot(X_grilla,moments[:,0]+3*np.sqrt(moments[:,1]),color="white")
            plt.plot(X_grilla,moments[:,0]-3*np.sqrt(moments[:,1]),color="white")
            plt.ylim(-1.4, 1.4)
            plt.tight_layout()
            plt.savefig("img/example2_predictive_d9_{}.pdf".format(i))
            plt.close()  
    
    #max(online_evidence)
    #plt.close()
    #plt.plot(online_evidence)
     
    
    X_N = X
    t_N = t
    Phi_N =  polynomial_basis_function(X_N, np.array(range(d+1)) )
    m_N, S_N = posterior(Phi_N, t_N, alpha, beta)
    #Phi = Phi_N    
    
    
    #mus, sigmas2 = predictive(m_0, S_0, Phi_N, beta) 
    #joint_evidence[d,0] = np.log10(normal.pdf(t.ravel(),mus.ravel(),np.sqrt(sigmas2)))
    
    
    Phi_grilla = polynomial_basis_function(X_grilla, np.array(range(d+1)) )
            
    w_samples = np.random.multivariate_normal(m_N.ravel(), S_N, 6).T
    y_samples = Phi_grilla.dot(w_samples)
    
    plt.plot(X_grilla,y_samples,alpha=0.3)
    plt.plot(X_N,t_N,'.',color="black")
    
    # Predictive
    belief = np.zeros((len(y_grilla),len(X_grilla)))
    moments = np.zeros((len(X_grilla),2))
    for ix in range(len(X_grilla)):
        xi = X_grilla[ix]
        Phi_new = polynomial_basis_function(xi, np.array(range(d+1)))
        Phi_new = Phi_new.reshape((1,d+1))
        moments[ix,:] = predictive(m_N, S_N, Phi_new , beta)
        belief[:,ix] =   normal.pdf(y_grilla,moments[ix,0],np.sqrt(moments[ix,1]))[::-1]
    plt.imshow(belief,extent=[-0.5,0.5,-1.4,1.4])
    plt.plot(X_grilla, y_true,color="black")
    plt.plot(X_grilla,moments[:,0],color="red",linewidth=2.0)
    plt.plot(X_grilla,moments[:,0]+np.sqrt(moments[:,1]),color="white")
    plt.plot(X_grilla,moments[:,0]-np.sqrt(moments[:,1]),color="white")
    plt.plot(X_grilla,moments[:,0]+2*np.sqrt(moments[:,1]),color="white")
    plt.plot(X_grilla,moments[:,0]-2*np.sqrt(moments[:,1]),color="white")
    plt.plot(X_grilla,moments[:,0]+3*np.sqrt(moments[:,1]),color="white")
    plt.plot(X_grilla,moments[:,0]-3*np.sqrt(moments[:,1]),color="white")
    plt.ylim(-1.4, 1.4)
    plt.tight_layout()
    plt.savefig("img/example2_predictive_{}.pdf".format(d))
    plt.close()    
    #plt.plot(X_grilla,belief[:,50])
    #plt.plot(y_grilla,belief[50,:].T)
    #plt.plot(y_grilla,belief[0,:].T)
    

plt.plot(online_evidence)
plt.savefig("img/example2_online_log_eviudence.pdf")
plt.close()    
    

    
    