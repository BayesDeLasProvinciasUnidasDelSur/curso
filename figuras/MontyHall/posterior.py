import numpy as np
from numpy import nan
import math

# Hipótesis (posibles valores)
h = np.arange(3)

#
# 1.1 Definir la distribución de creencia conjunta como producto de las distribuciones condicionales del modelo .
#

# Probabilidad del modelo
def pM(m): # P(m)
    return 1/2

# Probabilidad del regalo
def pr(r): # P(r)
    return 1/3

# Probabilidad de cerrar
def pc(c): # P(c)
    return 1/3

# Probabilidad de la pista modelo Base M0
def ps_rM0(s,r):
    return (s != r) * 1/2

# Probabilidad de la pista modelo Monty Hall M1
def ps_rcM1(s,r,c):
    if r != c:
        return (s != r) * (s != c) * 1
    else:
        return (s != r) * 1/2

# Conjunta de cada modelo
#
prcs_M = np.array([ # P(r,c,s|M=m) = prcs_M[m,r,c,s]
    np.zeros((3,3,3)), # M0
    np.zeros((3,3,3))  # M1
])
for r in range(3):
    for c in range(3):
        for s in range(3):
            #
            # P(r,c,s|M0) = P(r)P(c)P(s|r,M0)
            prcs_M[0,r,c,s] = pr(r) * pc(c) * ps_rM0(s,r)
            #
            # P(r,c,s|M1) = P(r)P(c)P(s|r,c,M1)
            prcs_M[1,r,c,s] = pr(r) * pc(c) * ps_rcM1(s,r,c)


#
# 1.2 Mostrar que el producto de las predicciones a priori de la secuencia de datos de un episodio es igual a la probabilidad conjunta a priori
#

# Secuencia de predicciones
#
def pc_M(c,m): # P(c|Modelo)
    return np.sum(prcs_M[m,:,c,:])

def ps_cM(s,c,m): # P(s|c,Modelo)
    # P(c,s|M)/P(c)
    return np.sum(prcs_M[m,:,c,s])/np.sum(prcs_M[m,:,c,:])

def pr_scM(r,s,c,m): # P(r|s,c,Modelo)
    # P(r,c,s|M)/P(c,s|Modelo)
    return prcs_M[m,r,c,s]/np.sum(prcs_M[m,:,c,s])

# Predicción a priori del episodio
#
def pEpisodio_M(c,s,r,m): # P( Datos = (c, s, r) | M) = P(c|M) P(s|c,M) P(r|s,c,M)
    if m == 0:
        return pr(r) * pc(c) * ps_rM0(s,r)
    if m == 1:
        return pr(r) * pc(c) * ps_rcM1(s,r,c)
    #return pc_M(c,m) * ps_cM(s,c,m) * pr_scM(r,s,c,m)

#
# 1.3 Simular datos con el modelo Monty Hall
#

# COMPLETAR: Reemplazando signos de pregunta (?)

def simular(T = 16, seed = 0):
    np.random.seed(seed) # Para que los números aleatorios sean siempre iguales
    Datos = [] # La lista de los datos
    for t in range(T): # Itero por episodio
        # Genero los datos del episodio
        r = np.random.choice(3, p=[pr(hr) for hr in h ])
        c = np.random.choice(3, p=[pc(hc) for hc in h ])
        s = np.random.choice(3, p=[ps_rcM1(hs, r, c) for hs in h])
        Datos.append((c,s,r)) # Agrega el episodio como una tupla (c,s,r)
    return Datos

T = 16
Datos = simular(T)

#
# 1.4 Calcular la predicción a priori que hace cada uno de los modelos sobre la totalidad de la base de datos simulada
#

def secuencia_de_predicciones(Datos):
    # Inicializacion de la secuencia de predicciones de los modelos
    pDatos_M0 = [1] # Del modelo 0: No Monty Hall
    pDatos_M1 = [1] # Del modelo 1: Monty Hall
    for t in range(len(Datos)): # Itero sobre episodios
        c, s, r = Datos[t]
        # Predicciones
        # P(r,c,s|M) = P(r)P(c)P(s|r,c)
        pDatos_M0.append(  pEpisodio_M(c,s,r,0) )
        pDatos_M1.append(  pEpisodio_M(c,s,r,1) )
    return (pDatos_M0, pDatos_M1)


def pDatos_M(Datos):
    pDatos_M0, pDatos_M1 = secuencia_de_predicciones(Datos)
    return np.prod(pDatos_M0), np.prod(pDatos_M1)


#
# 1.5.1 La predicción del modelo expresada en órdenes de magnitud
#

pDatos_M0, pDatos_M1 = secuencia_de_predicciones(Datos)
log_evidencia_M0 = np.sum(np.log10(pDatos_M0))
log_evidencia_M1 = np.sum(np.log10(pDatos_M1))

print("Diferencia de desempeño predictivo expresado en órdenes de magnitud =", log_evidencia_M1-log_evidencia_M0)
print("La cantidad creencia que preservó el modelo Monty Hall respecto del modelo Base =", 10**(log_evidencia_M1-log_evidencia_M0))

#
# 1.5.2 La predicción típica (o media geométrica)
#

# La predicción típica de los modelos
log_evidencia_M0 = np.sum(np.log10(pDatos_M0))
log_evidencia_M1 = np.sum(np.log10(pDatos_M1))
print("Predicción típica del modelo Base (M0) =", 10**(log_evidencia_M0/(T*3)) )
print("Predicción típica del modelo Monty Hall (M1) =", 10**(log_evidencia_M1/(T*3)) )

#
# 1.6 Predicción de los datos con la contribución de todos los modelos
#

# P(Datos, Modelo) = P(Datos|Modelo) P(Modelos)
pDatosM = [np.cumprod(pDatos_M0) * pM(0),
           np.cumprod(pDatos_M1) * pM(1)]
pDatos = pDatosM[0] + pDatosM[1]

#
# 1.7 Calcular el posterior de los modelos a medida que vamos agregando datos
#

# P(Modelo = m | Datos = {(c1,s1,r1),...,(ct,st,rt)} ) = pM_Datos[m][t]
pM_Datos = [pDatosM[0] / pDatos,
            pDatosM[1] / pDatos]


#
# 1.8 Graficar el posterior
#

from matplotlib import pyplot as plt

plt.plot(pM_Datos[0] , label="M0: Base")
plt.plot(pM_Datos[1] , label="M1: Monty Hall")
plt.xlabel("Episodio")
plt.ylabel("P( Modelo | Datos )")
plt.legend(title="Realidad causal: Monty Hall \n \nProbabilidad de los modelos:")
plt.savefig("posterior.pdf",bbox_inches='tight')
plt.close()


#
# 1.9 Base de datos NoMontyHall
#

def NoMontyHall(T = 16, seed = 0):
    np.random.seed(seed) # Para que los números aleatorios sean siempre iguales
    Datos = [] # La lista de los datos
    for t in range(T): # Itero por episodio
        # Genero los datos del episodio
        r = np.random.choice(3, p=[pr(hr) for hr in h ])
        c = np.random.choice(3, p=[pc(hc) for hc in h ])
        m = np.random.choice(2, p=[1/4, 3/4])
        s = np.random.choice(3, p=[ps_rM0(hs,r) if m==0 else ps_rcM1(hs, r, c) for hs in h])
        Datos.append((c,s,r)) # Agrega el episodio como una tupla (c,s,r)
    return Datos

DatosNoMontyHall = NoMontyHall(2000)
pDatosNoMontyHall_M0, pDatosNoMontyHall_M1 = secuencia_de_predicciones(DatosNoMontyHall )

# Hipótesis de memoria
h_memoria = np.arange(0,1.05,0.05)
pm_M2 = np.repeat(1/len(h_memoria ), len(h_memoria ))

# Predicción de los datos con modelo M2,
# actualizando el prior sobre la memoria
def pDatos_M2(r,c,s,pm):
    res = 0
    for i_a in [0,1]:
        for i_m in range(len(h_memoria)):
            pa_m = h_memoria[i_m]
            if i_a==0:
                res += pr(r)*pc(c)*ps_rM0(s,r)*(1-pa_m)*pm[i_m]
            if i_a ==1:
                res += pr(r)*pc(c)*ps_rcM1(s,r,c)*pa_m*pm[i_m]
    return res

def pDatos_mM2(r,c,s,m):
    res = 0
    for i_a in [0,1]:
        pa_m = m
        if i_a==0:
            res += pr(r)*pc(c)*ps_rM0(s,r)*(1-pa_m)
        if i_a ==1:
            res += pr(r)*pc(c)*ps_rcM1(s,r,c)*pa_m
    return res


# sum([ pDatos_M2(r,c,s, pm_M2) for r in h for c in h for s in h ])

pDatosNoMontyHall_M2 = [1]
pm_DatosM2 = pm_M2
for t in range(len(DatosNoMontyHall)):# t=0
    c,s,r= DatosNoMontyHall[t]
    prediccion = pDatos_M2(r,c,s,pm_DatosM2)
    pDatosNoMontyHall_M2.append(prediccion)
    likelihhod = [pDatos_mM2(r,c,s,m) for m in h_memoria]
    pm_DatosM2 = pm_DatosM2 * likelihhod
    pm_DatosM2 = pm_DatosM2 / sum(pm_DatosM2 )

# Posterior de la memoria
#plt.plot(h_memoria, pm_DatosM2)


log_pDatos_M=[np.cumsum(np.log10(np.array(pDatosNoMontyHall_M0))),
              np.cumsum(np.log10(np.array(pDatosNoMontyHall_M1))),
              np.cumsum(np.log10(np.array(pDatosNoMontyHall_M2)))]

# Plot diferencia en ordenes de magnitud
#plt.plot(log_pDatos_M[0]-log_pDatos_M[2])
#plt.show()

# Media geométrica
10**(log_pDatos_M[0][-1]/(2000*3))
10**(log_pDatos_M[1][-1]/(2000*3))
10**(log_pDatos_M[2][-1]/(2000*3))

pDatosM012=[np.cumprod(pDatosNoMontyHall_M0)[0:60]*1/3,
            np.cumprod(pDatosNoMontyHall_M1)[0:60]*1/3,
            np.cumprod(pDatosNoMontyHall_M2)[0:60]*1/3]

pDatos012 =  pDatosM012[0] + pDatosM012[1] + pDatosM012[2]

# P(Modelo = m | Datos = {(c1,s1,r1),...,(ct,st,rt)} ) = pM_Datos[m][t]
pM012_Datos = [pDatosM012[0] / pDatos012,
               pDatosM012[1] / pDatos012,
               pDatosM012[2] / pDatos012]

plt.plot(pM012_Datos[0], label="M0: Base")
plt.plot(pM012_Datos[1], label="M1: Monty Hall")
plt.plot(pM012_Datos[2], label="M2: Alternativo")
plt.xlabel("Episodio")
plt.ylabel("P( Modelo | Datos )")
plt.legend(title="Realidad causal: No Monty Hall \n \nProbabilidad de los modelos:")
plt.savefig("posterior2.pdf",bbox_inches='tight')


