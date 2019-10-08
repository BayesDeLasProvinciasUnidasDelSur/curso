from posterior import *
from generative import generative_model, synthetic_data
from basisFunctions import identity_basis_function, phi
import matplotlib.pyplot as plt
import numpy as np
# Training dataset sizes
N_list = [1, 3, 20]

plt.close()
beta = (1/0.2)
alpha = 2.0

# Data observations in [0, 1)
X = np.random.rand(N_list[-1], 1)

# Training target values
t = synthetic_data(X, variance=1/beta)

# Test observations
X_grilla = np.linspace(0, 1, 100).reshape(-1, 1)

# Function values without noise
y_grilla = synthetic_data(X_grilla , variance=0)
    
# Design matrix of test observations
phi_identity = phi(X_grilla, identity_basis_function)

plt.plot(X_grilla,y_grilla)
plt.plot(X,t,'.')


plt.figure()
plt.subplots_adjust(hspace=0.4)

for i, N in enumerate(N_list):
    X_N = X[:N]
    t_N = t[:N]

    # Design matrix of training observations
    Phi_N = phi(X_N, identity_basis_function)
    
    # Mean and covariance matrix of posterior
    m_N, S_N = posterior(Phi_N, t_N, alpha, beta)
    
    # Mean and variances of posterior predictive
    y, y_var = posterior_predictive(Phi_test, m_N, S_N, beta)
    
    # Draw 5 random weight samples from posterior and compute y values
    w_samples = np.random.multivariate_normal(m_N.ravel(), S_N, 5).T
    y_samples = Phi_test.dot(w_samples)
    
    plt.subplot(len(N_list), 3, i * 3 + 1)
    plot_posterior(m_N, S_N, f_w0, f_w1)
    plt.title(f'Posterior density (N = {N})')
    plt.legend()

    plt.subplot(len(N_list), 3, i * 3 + 2)
    plot_data(X_N, t_N)
    plot_truth(X_test, y_true)
    plot_posterior_samples(X_test, y_samples)
    plt.ylim(-1.5, 1.0)
    plt.legend()

    plt.subplot(len(N_list), 3, i * 3 + 3)
    plot_data(X_N, t_N)
    plot_truth(X_test, y_true, label=None)
    plot_predictive(X_test, y, np.sqrt(y_var))
    plt.ylim(-1.5, 1.0)
    plt.legend()