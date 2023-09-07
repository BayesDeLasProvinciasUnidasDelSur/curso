# A Crash Course in Bad and God Controls

import bayesianlinearregression as blr # Archivo que está en la misma carpeta
import linear_model as lm # https://github.com/glandfried/bayesian-linear-model
from linear_model import BayesianLinearModel # https://github.com/glandfried/bayesian-linear-model
import random
import numpy as np
from numpy.random import normal as noise
import matplotlib.pyplot as plt
from scipy.stats import multivariate_normal as normal
from scipy.stats import norm
import statsmodels.api as sm
import time
#phi = polynomial_basis_function


random.seed(2023-7-7)
np.random.seed(2023-7-7)
cmap = plt.get_cmap("tab10")
N = 1000

def numpy_float(numpy_scalar_in_array):
    return np.squeeze(numpy_scalar_in_array)

def plot_parametros(mean, cov, real, nombre_params, nombre_archivo, pos=(0,0)):
    plt.xticks(ticks=real)
    ax = plt.gca()
    ax.tick_params(axis='both', labelsize=20)
    handles = []  # List to store legend handles
    labels = []  # List to store legend labels
    for i in range(len(mean)):# i = 0
        mean_i = numpy_float(mean[i])
        cov_ii = numpy_float(cov[i,i])
        a = mean_i-10*np.sqrt(cov_ii)
        b = mean_i+10*np.sqrt(cov_ii)
        grilla = np.arange(a,b,step=(b-a)/200)
        line = plt.plot(grilla ,normal(mean=mean_i, cov=cov_ii ).pdf(grilla), linewidth=2,color=cmap(i))
        plt.axvline(x=real[i], color=cmap(i), linewidth=0.3)
        handles.append(line[0])  # Add the line as a handle
        #labels.append(f'Label {i+1}')  # Add the label for the legend
    #
    plt.legend(handles, nombre_params,  bbox_to_anchor=pos)  # Create the legend with handles and labels
    plt.savefig("pdf/controles-{}.pdf".format(nombre_archivo),bbox_inches='tight')
    plt.close()

######################################################################
# Modelo complejo

z1 = np.random.uniform(-3,3, size=N)
w1 = 3*z1 + np.random.normal(size=N,scale=1)
z2 = np.random.uniform(-3,3, size=N)
w2 = 2*z2 + np.random.normal(size=N,scale=1)
z3 = -2*z1 + 2*z2 + np.random.normal(size=N,scale=1)
x = -1*w1 + 2*z3 + np.random.normal(size=N,scale=1)
w3 = 2*x + np.random.normal(size=N,scale=1)
y = 2 - 1*w3 - z3 + w2 + np.random.normal(size=N,scale=1)

PHI0 = np.concatenate([np.ones(N).reshape(N, 1), x.reshape(N, 1), z3.reshape(N, 1),w2.reshape(N, 1)], axis=1)

blm0= BayesianLinearModel(basis=lambda x: x)
blm0.update(PHI0, y.reshape(N,1) )

mean0 = blm0.location
cov0 = blm0.dispersion
real0 = [2,-2,-1,1]

plot_parametros(mean0,cov0,real0,nombre_params=["c0","c1","c2","c3"],nombre_archivo="modeloComplejos")


########################################################################
# Modelo 1
# \edge {z} {x,y}
# \edge {x} {y}

Z1s = np.random.uniform(-3,3, size=N)
X1s = 1 + 3*Z1s + 2*Z1s**3 + np.random.normal(size=N,scale=6)
Y1s = -1 - 2*X1s + 6*Z1s**2 + np.random.normal(size=N,scale=1)

PHI1 = np.concatenate([np.ones(N).reshape(N, 1), X1s.reshape(N, 1), (Z1s**2).reshape(N, 1)], axis=1)

blm1= BayesianLinearModel(basis=lambda x: x)
blm1.update(PHI1, Y1s.reshape(N,1) )

mean1 = blm1.location
cov1 = blm1.dispersion
real1 = [-1,-2,6]



plot_parametros(mean1,cov1,real1,nombre_params=["1","X1","Z2"],nombre_archivo="modelo1")


########################################################################
# Modelo 2
# \edge {U} {z,y}
# \edge {z} {x}
# \edge {x} {y}

U2s = np.random.uniform(-3,3, size=N)
Z2s = 3*U2s**3 + np.random.uniform(-1.5,1.5, size=N)
X2s =  3*Z2s + np.random.normal(size=N,scale=3)
Y2s = -1 - 2*X2s + 6*U2s**2 + np.random.normal(size=N,scale=1)

PHI2 = np.concatenate([np.ones(N).reshape(N, 1), X2s.reshape(N, 1), (Z2s).reshape(N, 1)], axis=1)

blm2= BayesianLinearModel(basis=lambda x: x)
blm2.update(PHI2, Y2s.reshape(N,1) )
ev2 = blm2.evidence()

mean2 = blm2.location
cov2 = blm2.dispersion
real2 = [-1,-2,6]

plot_parametros(mean2,cov2,real2,nombre_params=["1","X1","Z2"],nombre_archivo="modelo2")

# Modelos 2 alternativos

PHI2_A = np.concatenate([np.ones(N).reshape(N, 1), X2s.reshape(N, 1), (Z2s**2).reshape(N, 1)], axis=1)

blm2a= BayesianLinearModel(basis=lambda x: x)
blm2a.update(PHI2_A, Y2s.reshape(N,1) )
blm2a.evidence()

mean2a = blm2a.location
cov2a = blm2a.dispersion
blm2a.evidence()

# El modelo alternativo tiene mejor evidencia, y estima mejor el parámetro de interés.

##################################################################
# Modelo 3
# \edge {U} {z,x}
# \edge {z} {y}
# \edge {x} {y}

U3s = np.random.uniform(-3,3, size=N)
Z3s = 3*U3s**2 + np.random.uniform(-1.5,1.5, size=N)
X3s =  3*U3s + np.random.normal(size=N,scale=3)
Y3s = -1 + 2*X3s + 5*Z3s**2 + np.random.normal(size=N,scale=1)

PHI3 = np.concatenate([np.ones(N).reshape(N, 1), X3s.reshape(N, 1), (Z3s**2).reshape(N, 1)], axis=1)

blm3= BayesianLinearModel(basis=lambda x: x)
blm3.update(PHI3, Y3s.reshape(N,1) )
blm3.evidence()

mean3 = blm3.location
cov3 = blm3.dispersion
real3 = [-1,2,5]

mean = mean3
cov = cov3
real = real3
pos=(0,0)

plot_parametros(mean3,cov3,real3,nombre_params=["1","X1","Z2"],nombre_archivo="modelo3")

########################################################################
# Modelo 4
# \edge {z} {x,m}
# \edge {x} {m}
# \edge {m} {y}

Z4s = np.random.uniform(-1.5,1.5, size=N)
X4s =  Z4s**2 + np.random.normal(size=N,scale=1)
M4s = 2*Z4s**2 + 10*X4s + np.random.uniform(-3,3, size=N)
Y4s = -1 + 2*M4s**2 + np.random.normal(size=N,scale=1)

# 8Z^4 + 80Z^2X + 200X^2

#plt.scatter(M4s,Y4s)
#plt.scatter(X4s,Y4s)
#plt.show()

PHI4 = np.concatenate([np.ones(N).reshape(N, 1), (X4s**2).reshape(N, 1), (X4s*Z4s**2).reshape(N, 1), (Z4s**4).reshape(N, 1)], axis=1)

blm4= BayesianLinearModel(basis=lambda x: x)
blm4.update(PHI4, Y4s.reshape(N,1) )
blm4.evidence()

blm4.location

mean4 = blm4.location
cov4 = blm4.dispersion
real4 = [-1,200,80,8]

plot_parametros(mean4,cov4,real4,nombre_params=["1","X2","XZ2","Z4"],nombre_archivo="modelo4")


########################################################################
# Modelo 5
# \edge {u} {m}
# \edge {z} {x}
# \edge {x} {m}
# \edge {m} {y}


U5s = np.random.uniform(-1.5,1.5, size=N)
Z5s =  U5s**2 + np.random.normal(size=N,scale=1)
X5s = 2*Z5s + np.random.normal(size=N,scale=1)
M5s = -2*U5s + 10*X5s  + np.random.normal(size=N,scale=1)
Y5s = -1 + 2*M5s + np.random.normal(size=N,scale=1)

# (20X - 4U )

PHI5 = np.concatenate([np.ones(N).reshape(N, 1), (X5s).reshape(N, 1), (Z5s).reshape(N, 1)], axis=1)

blm5= BayesianLinearModel(basis=lambda x: x)
blm5.update(PHI5, Y5s.reshape(N,1))
blm5.evidence()

blm5.location
#blm5.shape
#blm5.scale

mean5 = blm5.location
cov5 = blm5.dispersion
real5 = [-1,200,-80,8]

plot_parametros(mean5,cov5,real5,nombre_params=["1","X2","XZ","Z2"],nombre_archivo="modelo5")


########################################################################
# Modelo 6
# \edge {u} {m}
# \edge {z} {x}
# \edge {x} {m}
# \edge {m} {y}

U6s = np.random.uniform(-1.5,1.5, size=N)
Z6s =  U6s**2 + np.random.normal(size=N,scale=1)
X6s = 2*U6s + np.random.normal(size=N,scale=1)
M6s = -2*Z6s + 10*X6s  + np.random.normal(size=N,scale=1)
Y6s = -1 + 2*M6s**2 + np.random.normal(size=N,scale=1)

# (200X^2 - 80XZ + 8Z^2 )

PHI6 = np.concatenate([np.ones(N).reshape(N, 1), (X6s**2).reshape(N, 1), (X6s*Z6s).reshape(N, 1), (Z6s**2).reshape(N, 1)], axis=1)

blm6= BayesianLinearModel(basis=lambda x: x)
blm6.update(PHI6, Y6s.reshape(N,1))
blm6.evidence()

blm6.location

mean6 = blm6.location
cov6 = blm6.dispersion
real6 = [-1,200,-80,8]

plot_parametros(mean5,cov5,real5,nombre_params=["1","X2","XZ","Z2"],nombre_archivo="modelo6")

########################################################################
# Modelo 8 Neutral
# \edge {x} {y}
# \edge {z} {y}

Z8s = np.random.uniform(-1.5,1.5, size=N)
X8s = np.random.uniform(-1.5,1.5, size=N)
Y8s = 2*X8s**2 + 2*Z8s + np.random.normal(size=N,scale=1)

PHI8 = np.concatenate([np.ones(N).reshape(N, 1), (X8s**2).reshape(N, 1), (Z8s).reshape(N, 1)], axis=1)

blm8= BayesianLinearModel(basis=lambda x: x)
blm8.update(PHI8, Y8s.reshape(N,1))
blm8.evidence()
blm8.location

PHI8_B = np.concatenate([np.ones(N).reshape(N, 1), (X8s**2).reshape(N, 1)], axis=1)
blm8_B= BayesianLinearModel(basis=lambda x: x)
blm8_B.update(PHI8_B, Y8s.reshape(N,1))
blm8_B.evidence()
blm8_B.location
