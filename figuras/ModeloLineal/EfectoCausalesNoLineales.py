import matplotlib
import matplotlib.pyplot as plt
import matplotlib.backends.backend_pdf
import os
name = os.path.basename(__file__).split(".py")[0]#name="prueba"
pdf = matplotlib.backends.backend_pdf.PdfPages(name+".pdf")
font = {'size'   : 12}
matplotlib.rc('font', **font)
cmap = plt.get_cmap("tab10")
#############

import sys
sys.path.append('../../software/ModeloLineal/')
import ModeloLineal as ml
#
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
import pandas as pd


def numpy_float(numpy_scalar_in_array):
    return np.squeeze(numpy_scalar_in_array)


def plot_parametros(mean, cov, real, nombre_params, pos=(0,0)):
    fig = plt.figure()
    plt.xticks(ticks=real)
    ax = plt.gca()
    ax.tick_params(axis='both', labelsize=12)
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
    plt.legend(handles, nombre_params)  # Create the legend with handles and labels
    pdf.savefig(fig,bbox_inches='tight')


N =10000
Z4s = np.random.normal(size=N, scale=1)
X4s =  Z4s**2 + np.random.normal(size=N,scale=1)
M4s = 2*Z4s**2 + 10*X4s + np.random.normal(size=N,scale=1)
Y4s = -1 + 2*M4s**2 + np.random.normal(size=N,scale=1)



# y = -1 + 2*M4s**2  =  -1 + 2*(2*Z4s**2 + 10*X4s)**2
# y = -1 + 2*(2*Z4s**2 + 10*X4s)*(2*Z4s**2 + 10*X4s)
# y = -1 + 8*Z4s**4 + 80*X4s*Z4s**2 + 200*X4s**2

x_values = np.arange(-5, 6, 1)
y_grilla = np.arange(-1000,10500,1)
beta_grilla = 1/10.0**np.arange(0, 10, 0.5)

PHI4 = np.concatenate([
np.ones(N).reshape(N, 1),
(X4s**2).reshape(N, 1),
(X4s*Z4s**2).reshape(N, 1),
(Z4s**4).reshape(N, 1)], axis=1)

beta4 = np.inf
ev = -np.inf
for beta in beta_grilla:
    new_ev = ml.log_evidence(pd.DataFrame(Y4s), pd.DataFrame(PHI4), beta=beta)[0][0]
    if new_ev > ev:
        m4, S4 = ml.posterior(pd.DataFrame(Y4s), pd.DataFrame(PHI4), beta=beta)
        beta4 = beta
        ev = new_ev

plot_parametros(m4,S4,[-1,200,80,8], nombre_params=["1","X^2","X*Z^2","Z^4"])


blm4= BayesianLinearModel(basis=lambda x: x)
blm4.update(PHI4, Y4s.reshape(N,1) )
blm4.evidence()

mean4 = blm4.location
cov4 = blm4.dispersion
#blm4.scale # 41792615.41322327

def simular4(N, do_x=None):
    """
    Si hay intervención, usar x = do_x, sino generarlo del modelo original
    """
    Z = np.random.normal(size=N, scale=1)
    if do_x is None:
        X = Z**2 + np.random.normal(size=N, scale=1)
    else:
        X = np.full(N, do_x)
    M = 2*Z**2 + 10*X + np.random.normal(size=N, scale=1)
    Y = -1 + 2*M**2 + np.random.normal(size=N, scale=1)
    return Z, X, M, Y


def Y_doX(x, N=10000):
    """
    Generar una muestra P(y|do(x))
    """
    Z, X, M, Y = simular4(N, do_x=x)
    return Y

def p4_Y_doX(y,x,m4,S4, beta=beta4):
    res = 0
    z_grilla = np.linspace(-4,4,201)
    dz = z_grilla[1]-z_grilla[0]
    for z in z_grilla:#z=0; x=0; y=0
        pz = normal(0,1).pdf(z)
        #mu, S2 = ml.moments_predictive( Phi_posteriori=pd.DataFrame(np.array([1,x**2,x*z**2,z**4])).T, t_priori=pd.DataFrame(Y4s), alpha=ALPHA, beta=BETA, Phi_priori=pd.DataFrame(PHI4))
        #mu, S2, py_xz = blm4.predict(X=np.array([1,x**2,x*z**2,z]).reshape((1,4)),y=np.array([y]), variance=True)
        Phi_posteriori = np.array([1,x**2,x*z**2,z**4]).reshape((1,4))
        sigma2 = Phi_posteriori.dot(S4.dot(Phi_posteriori.T)) + (1/beta)*np.eye(Phi_posteriori.shape[0])
        mu = Phi_posteriori.dot(m4) # m_N.T.dot(Phi)
        py_xz = norm(loc=mu, scale=np.sqrt(sigma2)).pdf(y)
        res += (pz*py_xz)*dz
    return res[0,]



#step = 0.01
#z = np.arange(-10,10+step,step)
#msj_fm_m = [] # con x = 0
#for m in np.arange(-10,10+step,step):
    #msj_fm_m.append(sum(norm(loc=0, scale=1).pdf(z) * norm(loc=-m, scale=1).pdf(2*z**2))*(step))


#plt.plot(np.arange(-10,10+step,step), msj_fm_m)
#plt.xlabel("m|x'=0")
#plt.ylabel("P(m|x'=0)")
#plt.tight_layout()
#plt.savefig(name )



def whichmedia(ps):
    return(np.argmin(np.abs(0.5-np.cumsum(ps))))



#fig = plt.figure()
#for x in [-1,1]:
    #y_dox = Y_doX(x=x)
    #plt.hist(y_dox, density=True, alpha=0.5, bins=500, color=cmap(1))
    #plt.axvline(np.mean(y_dox), color=cmap(1), linestyle='--')
    #py_dox = p4_Y_doX(y=y_grilla,x=x,m4=m4, S4=S4, beta=beta4)
    #plt.plot(y_grilla, py_dox, color=cmap(2), label="x={}".format(x))
    #plt.axvline(y_grilla[whichmedia(py_dox)], color=cmap(2))
    #plt.xlim((-500,1000))


#plt.xlabel("Y|X=x", size=16)
#plt.ylabel("P(Y|X=x)", size=16)
#plt.legend()
#pdf.savefig(fig,bbox_inches='tight')


fig = plt.figure()
for i_x in range(len(x_values)):
    if x_values[i_x] % 2 ==1:
        # Histograma Y_doX
        y_dox = Y_doX(x=x_values[i_x])
        plt.hist(y_dox, density=True, alpha=0.5, bins=500, color=cmap(i_x))
        plt.axvline(np.mean(y_dox), color=cmap(i_x), linestyle='--', linewidth=0.1)
        # Estimación pY_doX
        py_dox = p4_Y_doX(y=y_grilla,x=x_values[i_x],m4=m4, S4=S4, beta=beta4)
        plt.plot(y_grilla, py_dox, color=cmap(i_x), label="x={}".format(x_values[i_x]))
        plt.axvline(y_grilla[whichmedia(py_dox)], color=cmap(i_x),linewidth=0.1)

plt.xlim((-500,8000))
plt.ylim((0,0.005))
plt.xlabel("Y|X=x", size=16)
plt.ylabel("P(Y|X=x)", size=16)
plt.legend()
pdf.savefig(fig,bbox_inches='tight')

y_distributions = []
# For each X value, estimate P(y|do(x))
for x_val in x_values:
    y_distributions.append(Y_doX(x_val))

# Calculate mean and standard deviation for each intervention
means = [np.mean(y_dist) for y_dist in y_distributions]
stds = [np.std(y_dist) for y_dist in y_distributions]

muY_XZ1 = m4[0] + m4[1]*x_values**2 + m4[2]*x_values + m4[3]
muY_XZ0 = m4[0] + m4[1]*x_values**2
muY_XZneg1 = muY_XZ1
muY_XZ2 = m4[0] + m4[1]*x_values**2 + m4[2]*x_values*2**2 + m4[3]*2**4

# Plot the results
fig = plt.figure(figsize=(10, 6))
plt.plot(x_values, means, 'b-', label='E[Y|do(X=x)] (muestra de la realidad intervenida)')
plt.plot(x_values, muY_XZ1,  label='E[Y|X=x, Z=\u00B1 1]' )
plt.plot(x_values, muY_XZ0,  label='E[Y|X=x, Z=0]' )
plt.plot(x_values, muY_XZ2,  label='E[Y|X=x, Z=\u00B1 2]' )
plt.plot(x_values, [ y_grilla[whichmedia( p4_Y_doX(y=y_grilla,x=x,m4=m4, S4=S4, beta=beta4))] for x in x_values], label='E[Y|do(X=x)] (estimada de la realidad observada)')
plt.fill_between(x_values,
                 np.array(means) - np.array(stds),
                 np.array(means) + np.array(stds),
                 alpha=0.2)
plt.xlabel('X (intervention value)')
plt.ylabel('Y')
plt.title('Interventional Distribution P(y|do(x))')
plt.grid(True)
plt.legend()
pdf.savefig(fig,bbox_inches='tight')


################
pdf.close()
#bash_cmd = "convert $(ls -rt pdf/example1*) pdf/example1.pdf"
##bash_cmd = "pdfcrop --margins '0 0 0 0' {0}.pdf {0}.pdf".format(name)
#os.system(bash_cmd)
