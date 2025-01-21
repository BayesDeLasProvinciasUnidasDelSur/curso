import numpy as np
import math
import matplotlib
import matplotlib.pyplot as plt
import pandas as pd


def pr(r):
    return 1/3

def pc(c):
    return 1/3

def ps_rM0(s,r):
    return (s!=r) * 1/2

def ps_rcM1(s,r,c):
    if r!=c:
        return (s!=r) * (s!=c) * 1
    else:
        return (s!=r) * 1/2

def prcs_M(r,c,s,m):
    if m==0:
        return pr(r)*pc(c)*ps_rM0(s,r)
    if m==1:
        return pr(r)*pc(c)*ps_rcM1(s,r,c)

H = np.arange(3) # Posibles valores de las hipótesis

def ps_cM(s,c,m): # P(s|c,M) = P(s,c|M)/P(c|M)
    num = 0 # P(s,c|M) = sum_r P(r,c,s|M)
    den = 0 # P(c|M) = sum_{rs} P(r,c,s|M)
    for hr in H:
        num += prcs_M(hr,c,s,m)
        for hs in H:
            den += prcs_M(hr,c,hs,m)
    return num/den

def pr_csM(r,c,s,m): # P(r|c,s,M) = P(r,c,s|M)/p(c,s|M)
    num = prcs_M(r,c,s,m)
    den = 0 # p(c,s|M) = sum_r P(r,c,s|M)
    for hr in H:
        den += prcs_M(hr,c,s,m)
    return num/den

def pEpisodio_M(c,s,r,m):
    return prcs_M(r,c,s,m)
    # P(c) * (P(s,c)/P(c)) * (P(r,c,s)/P(c,s))
    # = # Por cancelación de P(c) y P(s,c)
    # P(r,c,s)
    #return pc(c)*ps_cM(s,c,m)*pr_csM(r,c,s,m)

def simular(T=16,seed=0):
    np.random.seed(seed)
    Datos = []
    for t in range(T):
        r = np.random.choice(3, p=[pr(hr) for hr in H])
        c = np.random.choice(3, p=[pc(hc) for hc in H])
        s = np.random.choice(3, p=[ps_rcM1(hs,r,c) for hs in H])
        Datos.append((c,s,r))
    return Datos

T =16
Datos = simular()

def secuencia_de_predicciones(Datos,m):
    pDatos_M = [1]
    for t in range(len(Datos)):
        c, s, r = Datos[t]
        pDatos_M.append(pEpisodio_M(c,s,r,m))
    return pDatos_M

def pDatos_M(Datos, m):
    return np.prod(secuencia_de_predicciones(Datos,m))

pDatos_M(Datos, m=0) # 8.234550899283273e-21
pDatos_M(Datos, m=1) # 3.372872048346429e-17

# 1.5

log_evidencia_M0 = np.log10(pDatos_M(Datos, m=0))
log_evidencia_M1 = np.log10(pDatos_M(Datos, m=1))

# Diferencia en ordenes de magnitud
log_evidencia_M1 - log_evidencia_M0 # 3.612359

# Cantidad de creencia que preserva un modelo respecto del otro
10**(log_evidencia_M1 - log_evidencia_M0) # 4095.99

# Predicción típica (media geométrica)
10**(log_evidencia_M1/(len(Datos)*3)) # 0.4537
10**(log_evidencia_M0/(len(Datos)*3)) # 0.3815

# 1.6

def pM(m):
    return (1/2)

pDatos_M0 = secuencia_de_predicciones(Datos,m=0)
pDatos_M1 = secuencia_de_predicciones(Datos,m=1)

pDatosM = [np.cumprod(pDatos_M0) * pM(0), # P(Datos,M0)
           np.cumprod(pDatos_M1) * pM(1)] # P(Datos,M1)
pDatos = pDatosM[0] + pDatosM[1]

# 1.7 Posterior

pM_Datos = [pDatosM[0]/pDatos, # P(M0|Datos)
            pDatosM[1]/pDatos] # P(M1|Datos)

from matplotlib import pyplot as plt

plt.plot(pM_Datos[0], label="M0: Base")
plt.plot(pM_Datos[1], label="M1: Monty Hall")
plt.legend()
plt.show()

#
# 1.9
#

# HACER ejercicio 1.9

#
# 2
#

# HACER ejercicio 2

#
# 3
#

from statsmodels.api import OLS # Para selección de hipótesis
import ModeloLineal as ml       # Para evaluación de hipótesis y modelos (archivo ModeloLineal.py)
from scipy.stats import norm    # La distribución gaussiana






















