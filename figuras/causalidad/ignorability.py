# Paradoja de Simpson replicada de Neal "Introduction to causal inference" 2020 (draft)
#
# NOTA: El modelo (distribuciones condicionales) se construye suponiendo que hay un backdoor.
# \edge {Estado0} {Tratamiento, Estado1}
# \edge {Tratamiento} {Estado1}

import numpy as np
from matplotlib import pyplot as plt
import matplotlib.backends.backend_pdf
pdf = matplotlib.backends.backend_pdf.PdfPages("ignorability.pdf")
cmap = plt.get_cmap("tab10") # Colores para los modelos

# ############
# Modelo

def pE0(e0):
  # Factor de E0
  res = np.array([1450/2050, 600/2050])
  return(res[e0])

def pT_E0(t,e0):
  # Factor de T
  res = np.array([ [1400/1450,  50/1450],   # e0 = 0
                   [ 100/ 600, 500/ 600] ]) # e0 = 1
  return(res[e0,t])

def pE1_TE0(e1,t,e0):
  # Factor de E1
  res_E0 = [ [ 0.85, 0.15], # T=0
             [ 0.90, 0.10]]# T=1
  res_E1 = [ [ 0.70, 0.30], # T=0
             [ 0.80, 0.20]]# T=1
  res = np.array([res_E0, res_E1])
  return(res[e0,t,e1])

def pE0TE1(e0,t,e1):
  # Conjunta
  return(pE0(e0)*pT_E0(t,e0)*pE1_TE0(e1,t,e0))

# END Modelo
# ############
# BEGIN Paradoja de Simpson

def pT(t):
    return( sum([pE0TE1(he0,t,he1) for he0 in [0,1] for he1 in [0,1]]))


def pE1_T(e1,t):
  # Predicción de E1 dado T (o posterior)
  pE1T = sum([pE0TE1(he0,t,e1) for he0 in [0,1]])
  pT = sum([pE0TE1(he0,t,he1) for he0 in [0,1] for he1 in [0,1]])
  return(pE1T/pT)


def simular(N=2050*100):
  E0s = np.random.binomial(size=N, n=1, p=pE0(1) )
  Ts  = np.random.binomial(size=N, n=1, p=pT_E0(1,E0s) )
  E1s = np.random.binomial(size=N, n=1, p=pE1_TE0(1,Ts,E0s))
  return(np.array(list(zip(E0s, Ts, E1s))))



# Sin condicionar en el backdoor.


#P(E1|T)
plt.scatter([0,1],pE1_T(1,np.array([0,1])),color="gray", label="P(E1|T)", s=100)
plt.plot([0,1],pE1_T(1,np.array([0,1])),color="gray")
plt.text(0.45, 0.26, "-0.10", fontsize=14)
# P(E1|T,E0=0)
plt.scatter([0,1],pE1_TE0(e1=1,t=np.array([0,1]),e0=0)
,color=cmap(0), label="P(E1|T,E0=0)", s=100)
plt.plot([0,1],pE1_TE0(e1=1,t=np.array([0,1]),e0=0)
,color=cmap(0))
plt.text(0.45, 0.18, "+0.04", fontsize=14)
# P(E1|T,E0=1)
plt.scatter([0,1],pE1_TE0(e1=1,t=np.array([0,1]),e0=1)
,color=cmap(2), label="P(E1|T,E0=1)", s=100)
plt.plot([0,1],pE1_TE0(e1=1,t=np.array([0,1]),e0=1)
,color=cmap(2))
plt.text(0.45, 0.13, "-0.05", fontsize=14)
#
plt.legend(ncol=1, fontsize=14)
plt.xlabel("T", fontsize=18)
plt.ylabel("P(E1| ... )", fontsize=18)
plt.xticks([0,1],fontsize=12)
plt.yticks(np.arange(0.1,0.31,step=0.05),fontsize=12)
#plt.show()
pdf.savefig(bbox_inches='tight')
plt.close()
pdf.close()
#Datos = simular()
#(sum(Datos[:,1] == 0 )/100)/2050
#(sum(Datos[:,1] == 1 )/100)/2050
#pT(0)*2050
#pT(1)*2050
#pE1_T(e1=1,t=0)
#pE1_T(e1=1,t=1)

# END Paradoja
# ##############
# BEGIN Ignorability

# Vamos a verificar
# ¿ Yi(X=0) \indep X | Mx ?      donde Mx es el modelo intervenido luego de do(x)
# ¿ Yi(X=0) \indep X | M ?       donde M es el modelo no intervenido

## COV(x,y) = P(x=1, y=1) - P(x=1)P(y=1)

## Cómo se define P(x=1, y=1)?
## Capítulo 7.1 Pearl Causality.
## Twin networks

def pJointTwin(e0,t,e1,e1prima, tprima):
  ptprima = 0.5 # Do operator
  return (pE0(e0)*pT_E0(t,e0)*pE1_TE0(e1,t,e0)*pE1_TE0(e1prima,tprima,e0))

# P(e1prima, t, tprima)
def pTprima(tprima):
  # do()
  return(0.5)

def pE1primaT_TprimaTWIN(e1prima, t, tprima):
  return(sum([ pJointTwin(he0, t, he1, e1prima, tprima) for he0 in [0,1] for he1 in [0,1] ] )/pTprima(1))

def pE1prima_TprimaTWIN(e1prima, tprima):
  return(sum([ pJointTwin(he0, ht, he1, e1prima, tprima) for he0 in [0,1] for he1 in [0,1] for ht in [0,1]] )/pTprima(tprima) )

def pT_TprimaTWIN(t, tprima):
  return(sum([ pJointTwin(he0, t, he1, he1prima, tprima) for he0 in [0,1] for he1 in [0,1] for he1prima in [0,1]] )/pTprima(tprima) )



pE1primaT_TprimaTWIN(1,1,1)
pE1prima_TprimaTWIN(1,1) - pT_TprimaTWIN(1,1)


#pE1_T(e1=np.array([0,1]),t=1)
#pT(np.array([0,1]))

#def pE0TE1_M(e0,t,e1, m):
  #if m == 0: # Modelo sin intervenir
    #return(pE0(e0)*pT_E0(t,e0)*pE1_TE0(e1,t,e0))
  #if m == 1:
    #return(pE0(e0)*   0.5     *pE1_TE0(e1,t,e0))


## Casos: Yi(T=0) \indep X | M  (modelo sin intervenir)
## P_M(x=1, y=1|)
#pxy = sum([pE0TE1_M(he0,t=1,e1=1,m=0) for he0 in [0,1] ])

#pxpy = pE1_T(e1=1,t=0)*pT(1)
#pxy - pxpy == 0

## Casos: Yi(T=1) \indep X | Mx (modelo intervenido)
## COV(x,y) = P(x=1, y=1) - P(x=1)P(y=1)
#pxy = sum([pE0TE1_M(he0,t=1,e1=1,m=1) for he0 in [0,1] ])
#pxpy = pE1_T(e1=1,t=1)*0.5
#pxy - pxpy == 0

## Casos: Yi(T=1) \indep X | Mx (modelo intervenido)
## COV(x,y) = P(x=1, y=1) - P(x=1)P(y=1)
#pxy = sum([pE0TE1_M(he0,t=1,e1=1,m=1) for he0 in [0,1] ])
#pxpy = pE1_T(e1=1,t=0)*0.5
#pxy - pxpy == 0

