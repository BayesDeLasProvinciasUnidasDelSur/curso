import numpy as np
import ModeloLineal as ml # https://github.com/glandfried/bayesian-linear-model
from statsmodels.api import OLS
from matplotlib import pyplot as plt
import pandas as pd
import os

cmap = plt.cm.coolwarm
cmap = plt.get_cmap("tab10") # Colores para los modelos


import matplotlib.backends.backend_pdf
pdf = matplotlib.backends.backend_pdf.PdfPages("flujo.pdf")

def abline(origen,pendiente, x_vals, color, cov=None):
  y_vals = origen + pendiente * x_vals
  plt.plot(x_vals, y_vals, color=color, linewidth=4)


# ####
# Fork
# \edge {z} {x,y}
np.random.seed(2024-10-7)
N=1000
Z1s = (np.random.uniform(-3,3, size=N) > 0)
X1s = 4*Z1s + np.random.normal(size=N,scale=1)
Y1s = 4*Z1s + np.random.normal(size=N,scale=1)

plt.scatter(X1s,Y1s, color="gray", alpha=1)
x_vals = np.array(plt.gca().get_xlim())
#
[mu_o, mu_p], cov = ml.posterior(
  Y1s.reshape((N,1)),
  pd.DataFrame({"origen": X1s**0, "pendiente": X1s})
)
abline(mu_o, mu_p, x_vals, "black")
plt.xlabel("X", fontsize=14)
plt.ylabel("Y", fontsize=14)
pdf.savefig(bbox_inches='tight')
plt.close()



plt.scatter(X1s[~Z1s],Y1s[~Z1s],color=cmap(0), label="Z=0", alpha=0.5)
plt.scatter(X1s[Z1s],Y1s[Z1s],  color=cmap(2), label="Z=1",alpha=0.5)
x_vals = np.array(plt.gca().get_xlim())
#
abline(mu_o, mu_p, x_vals,  "black")
[mu_o, mu_p], cov = ml.posterior(
  Y1s[Z1s].reshape((len(Y1s[Z1s]),1)),
  pd.DataFrame({"origen": X1s[Z1s]**0, "pendiente": X1s[Z1s]})
)
abline(mu_o, mu_p, x_vals, (0.1,0.4,0.1))
#
[mu_o, mu_p], cov = ml.posterior(
  Y1s[~Z1s].reshape((len(Y1s[~Z1s]),1)),
  pd.DataFrame({"origen": X1s[~Z1s]**0, "pendiente": X1s[~Z1s]})
)
abline(mu_o, mu_p, x_vals, (0.1,0.2,0.6))

plt.legend(ncol=1)
plt.xlabel("X", fontsize=14)
plt.ylabel("Y", fontsize=14)
pdf.savefig(bbox_inches='tight')
plt.close()


# ####
# Pipe
# \edge {x} {z} {y}
N=1000
X1s = np.random.normal(size=N,loc=0,scale=2)
Z1s = (X1s + np.random.normal(size=N,loc=0,scale=0.1)) > 0
Y1s = Z1s + np.random.normal(size=N,scale=0.3)

plt.scatter(X1s,Y1s, color="gray", alpha=1)
x_vals = np.array(plt.gca().get_xlim())
#
[mu_o, mu_p], cov = ml.posterior(
  Y1s.reshape((N,1)),
  pd.DataFrame({"origen": X1s**0, "pendiente": X1s})
)
abline(mu_o, mu_p, x_vals, "black")
plt.xlabel("X", fontsize=14)
plt.ylabel("Y", fontsize=14)
pdf.savefig(bbox_inches='tight')
plt.close()


plt.scatter(X1s[~Z1s],Y1s[~Z1s],color=cmap(0), label="Z=0", alpha=0.5)
plt.scatter(X1s[Z1s],Y1s[Z1s],  color=cmap(2), label="Z=1",alpha=0.5)
x_vals = np.array(plt.gca().get_xlim())
#
abline(mu_o, mu_p, x_vals,  "black")
[mu_o, mu_p], cov = ml.posterior(
  Y1s[Z1s].reshape((len(Y1s[Z1s]),1)),
  pd.DataFrame({"origen": X1s[Z1s]**0, "pendiente": X1s[Z1s]})
)
abline(mu_o, mu_p, x_vals, (0.1,0.4,0.1))
#
[mu_o, mu_p], cov = ml.posterior(
  Y1s[~Z1s].reshape((len(Y1s[~Z1s]),1)),
  pd.DataFrame({"origen": X1s[~Z1s]**0, "pendiente": X1s[~Z1s]})
)
abline(mu_o, mu_p, x_vals, (0.1,0.2,0.6))

plt.legend(ncol=1)
plt.xlabel("X", fontsize=14)
plt.ylabel("Y", fontsize=14)
pdf.savefig(bbox_inches='tight')
plt.close()




# ####
# collider
N=1000
X1s = np.random.normal(size=N,scale=1)
Y1s = np.random.normal(size=N,scale=1)
Z1s = (X1s + Y1s) > 0

plt.scatter(X1s,Y1s, color="gray", alpha=1)
x_vals = np.array(plt.gca().get_xlim())
#
[mu_o, mu_p], cov = ml.posterior(
  Y1s.reshape((N,1)),
  pd.DataFrame({"origen": X1s**0, "pendiente": X1s})
)
abline(mu_o, mu_p, x_vals, "black")
plt.xlabel("X", fontsize=14)
plt.ylabel("Y", fontsize=14)
pdf.savefig(bbox_inches='tight')
plt.close()


plt.scatter(X1s[~Z1s],Y1s[~Z1s],color=cmap(0), label="Z=0", alpha=0.5)
plt.scatter(X1s[Z1s],Y1s[Z1s],  color=cmap(2), label="Z=1",alpha=0.5)
x_vals = np.array(plt.gca().get_xlim())
#
abline(mu_o, mu_p, x_vals,  "black")
[mu_o, mu_p], cov = ml.posterior(
  Y1s[Z1s].reshape((len(Y1s[Z1s]),1)),
  pd.DataFrame({"origen": X1s[Z1s]**0, "pendiente": X1s[Z1s]})
)
abline(mu_o, mu_p, x_vals, (0.1,0.4,0.1))
#
[mu_o, mu_p], cov = ml.posterior(
  Y1s[~Z1s].reshape((len(Y1s[~Z1s]),1)),
  pd.DataFrame({"origen": X1s[~Z1s]**0, "pendiente": X1s[~Z1s]})
)
abline(mu_o, mu_p, x_vals, (0.1,0.2,0.6))

plt.legend(ncol=1)
plt.xlabel("X", fontsize=14)
plt.ylabel("Y", fontsize=14)
pdf.savefig(bbox_inches='tight')
plt.close()


pdf.close()


