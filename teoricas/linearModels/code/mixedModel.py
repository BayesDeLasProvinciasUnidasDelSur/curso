import matplotlib.pyplot as plt
import numpy as np
def fixed_effects_posterior(t, Phi, C, alpha, beta):
    N, M = Phi.shape
    _, L = C.shape
    
    Sw_0_inv = alpha * np.eye(M)
    Sv_0 = (1/alpha) * np.eye(L)
    
    Sw_N_inv = Sw_0_inv + beta * Phi.T.dot(Phi)
    _Sw = np.linalg.inv(Sw_N_inv)
    A = -(1/beta)*_Sw.dot(Phi.T).dot(C)
    Sw_N = _Sw + A.dot(Sv_0).dot(A.T)
        
    mw_N = beta * _Sw.dot(Phi.T).dot(t)
    return mw_N, Sw_N

def random_effects_posterior(t, Phi, C, alpha, beta):
    N, M = Phi.shape
    _, L = C.shape
    
    Sv_0_inv = alpha * np.eye(L)
    Sw_0 = (1/alpha) * np.eye(M)
    
    _Sv_inv = Sv_0_inv + beta * C.T.dot(C)
    _Sv = np.linalg.inv(_Sv_inv)
    A = -(1/beta)*_Sv.dot(C.T).dot(Phi)
    Sv_N = _Sv + A.dot(Sw_0).dot(A.T)
        
    mv_N = beta * _Sv.dot(C.T).dot(t)
    return mv_N, Sv_N

def evidence(t, Phi, C, alpha, beta):
    N, M = Phi.shape
    _, L = C.shape
    
    # Prior
    Sw_0 = (1/alpha) * np.eye(M)
    Sv_0 = (1/alpha) * np.eye(L)
    St_0 = (1/beta) * np.eye(N)
    #mw_0 = np.zeros((M,1))
    #mv_0 = np.zeros((L,1))
    
    St_N = St_0 + Phi.dot(Sw_0).dot(Phi.T) + C.dot(Sv_0).dot(C.T)
    mt_N = np.zeros((N,1))
    
    return mt_N, St_N

def polynomial_basis_function(x, degree=1):
    return x ** degree

M, L = 2, 6
n = [10]*L
N = sum(n)

w_true = np.array([1,-1]).reshape((M,1))
v_true = np.arange(L).reshape((L,1))

X = np.zeros((N,1))
for i in range(L):
    X[(n[i]*i):n[i]*(i+1),:] = (np.random.rand(n[i],1)+i)*2/L -1
Phi = polynomial_basis_function(X,range(M))

C = np.zeros((N,L))
for i in range(L):
    # Intercept
    C[(n[i]*i):n[i]*(i+1),i] = 1 
    # TODO: Si quisieramos agregar slope

beta = (10.0)**2
alpha = (1.0)**2

epsilon = np.random.normal(0,np.sqrt(1/beta), N).reshape((N,1))

t = Phi.dot(w_true) + C.dot(v_true) + epsilon 

plt.plot(X,t,'.')

plt.close()
x_L = np.array([ ((0+i)*2/L -1 + (1+i)*2/L -1)/2    for i in range(L)]).reshape((L,1))
Phi_L = polynomial_basis_function(x_L,range(M))
y_L =  Phi_L.dot(w_true) + np.eye(L).dot(v_true)
plt.plot(x_L, y_L,'--',color="gray")
for i in range(L):
    plt.plot([x_L[i]-1/L,x_L[i]+1/L], [y_L[i]-w_true[1]/L,y_L[i]+w_true[1]/L],color="black")
    plt.plot(X[(n[i]*i):n[i]*(i+1),0],t[(n[i]*i):n[i]*(i+1),0], '.')
    





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




