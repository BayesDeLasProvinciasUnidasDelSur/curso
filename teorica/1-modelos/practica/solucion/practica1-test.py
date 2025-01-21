import numpy as np
from numpy import nan
import math

# Probabilidad del modelo
def pM(m): # P(m)
    return np.array([1/2, 1/2])[m]

# Probabilidad del regalo
def pr(r): # P(r)
    return np.array([1/3, 1/3, 1/3])[r] # P(r) = pr[r]

# Probabilidad de cerrar
def pc(c): # P(c)
    return np.array([1/3, 1/3, 1/3])[c] # P(c) = pc[c]

# Probabilidad de la pista modelo Base M0
def ps_rM0(s,r):
    res = np.array( # P(s|r,M0) = ps_rM0[r][s]
       [[  0,  1/2,  1/2],   # r=1
        [1/2,    0,  1/2],   # r=2
        [1/2,  1/2,    0]]   # r=3
    )
    return res[r][s]


# Probabilidad de la pista modelo Monty Hall M1
def ps_rcM1(s,r,c):
    res = np.array( # P(s|r,c,M1) = ps_rcM1[c][r][s]
        [[[   0,  1/2,  1/2],  # r=0, c=0
          [   0,    0,    1],  # r=1, c=0
          [   0,    1,    0]], # r=2, c=0
         [[   0,    0,    1],  # r=0, c=1
          [ 1/2,    0,  1/2],  # r=1, c=1
          [   1,    0,    0]], # r=2, c=1
         [[   0,    1,    0],  # r=0, c=2
          [   1,    0,    0],  # r=1, c=2
          [ 1/2,  1/2,    0]]] # r=2, c=2
    )
    return res[c][r][s]

# Inicializa la tabla
def prcs_M(r,c,s,m):
    res = np.array([ # P(r,c,s|M=m) = prcs_M[m,r,c,s]
        np.zeros((3,3,3)), # M0
        np.zeros((3,3,3))  # M1
    ])
    for r in range(3):
        for c in range(3):
            for s in range(3):
                # P(r,c,s|M0) = P(r)P(c)P(s|r,M0)
                res[0,r,c,s] = pr(r) * pc(c) * ps_rM0(s,r)
                #
                # P(r,c,s|M1) = P(r)P(c)P(s|r,c,M1)
                res[1,r,c,s] = pr(r) * pc(c) * ps_rcM1(s,r,c)
    return res[m,r,c,s]

def prc_M(r,c,m): # P(r,c|M)
    return sum(prcs_M[m,r,c,:])

def prs_M(r,s,m): # P(r,s|M)
    return sum(prcs_M[m,r,:,s])

def pcs_M(c,s,m): # P(c,s|M)
    return sum(prcs_M[m,:,c,s])


# Posterior
#
def pc_M(c,m): # P(c|Modelo) = \sum_r \sum_s P(r,c,s|Modelo)
    return np.sum(prcs_M[m,:,c,:])

def ps_cM(s,c,m): # P(s|c,Modelo)
    hs = np.arange(3)
    # P(c,s|M)/P(c)
    return ( pcs_M(c,s,m)/sum(pcs_M(c,hs,m)))

def pr_scM(r,s,c,m): # P(r|s,c,Modelo)
    hr = np.arange(3)
    # P(r,c,s|M)/P(c,s|Modelo)
    return ( prcs_M[m,r,c,s]/sum(prcs_M[m,hr,c,s]) )

def pDatost_M(c,s,r,m): # P(Datos_t = {c, s, r} | M) = P(c|M) P(s|c,M) P(r|s,c,M)
    return pc_M(c,m) * ps_cM(s,c,m) * pr_scM(r,s,c,m)


for r in range(3):
    for c in range(3):
        for s in range(3):
            assert math.isclose( prcs_M[0,r,c,s], pDatost_M(c,s,r,0) )
            if s!=c:
                assert math.isclose( prcs_M[1,r,c,s], pDatost_M(c,s,r,1) )


