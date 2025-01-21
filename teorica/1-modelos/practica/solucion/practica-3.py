from statsmodels.api import OLS # Para selección de hipótesis
import ModeloLineal as ml       # Para evaluación de hipótesis y modelos (archivo ModeloLineal.py)
from scipy.stats import norm    # La distribución gaussiana
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

matplotlib.rcParams.update({'font.size': 12})
np.random.seed(1) # Para reproducir los datos

N = 20 # Cantidad de datos
D = 10 # Cantidad de modelos (de 0 al 9)
cmap = plt.get_cmap("tab10") # Colores para los modelos

BETA = (1/0.04) # Precisión de los datos, el inverso de su varianza
ALPHA = (10e-6) # Precisión de la creencia a prior, el inverso de su varianza

# Realidad causal subyacente
def realidad_causal_subyacente(X, beta =  BETA):
    return np.sin(2 * np.pi * X) + np.random.normal(0,np.sqrt(1/beta),X.shape)

def modelo_causal_deterministico(X, H):
    y = H[0]*X**0
    for i in range(1,len(H)):
        y += H[i]*(X**i)
    return y

#
# 3.1 Data
#

X = np.random.rand(N,1)-0.5
Y = realidad_causal_subyacente(X)
# Grilla
X_grilla = np.linspace(0, 1, 100).reshape(-1, 1)-0.5
Y_grilla = realidad_causal_subyacente(X_grilla, np.inf)

# Figura de
# la función objetivo
plt.plot(X_grilla, realidad_causal_subyacente(X_grilla, beta=np.inf), '--', color="black")
# y los datos
plt.plot(X,Y,'.', color='black')
plt.ylim(-1.5,1.5)
plt.savefig("pdf/model_selection_true_and_sample.pdf",bbox_inches='tight')
plt.close()



#
# 3.2 Máxima verosimilitud
#

# Las transformaciones de X que hace el modelo Md de complejidad d
def phi(X, complejidad = D):
    return(pd.DataFrame({f'X{d}': X[:, 0]**d for d in range(complejidad+1)}))

# Itero por modelos Md
modelos_OLS = []
for d in range(0,D):
    # Ajusto el modelo de compeljidad d
    modelos_OLS.append(OLS(Y, phi(X,d)).fit())

# Figuras de máxima verosimiliitud
for d in range(D):
    log_maxima_verosimilitud_d = modelos_OLS[d].llf
    plt.bar(d, np.exp(log_maxima_verosimilitud_d), align='center', color=cmap(d), label=f'Modelo {d}')

plt.xlabel("Modelos")
plt.ylabel("Máxima verosimilitud")
plt.savefig("pdf/model_selection_maxLikelihood.pdf",bbox_inches='tight')
plt.close()

#
# 3.3 Graficar curvas obtenidas con cada modelo por máxima verosimiliitud
#

# Figura de los ajustes.
plt.plot(X_grilla, Y_grilla, '--', color="black")
plt.plot(X,Y,'.', color='black')
plt.ylim(-1.5,1.5)
for d in range(D):
    H = modelos_OLS[d].params # Las hipótesis seleccionadas en el modelo de grado d
    plt.plot(X_grilla,
             modelo_causal_deterministico(X_grilla, H),
             color=cmap(d), label= f'Modelo {d}' )

plt.legend(ncol=2)
plt.savefig("pdf/model_selection_OLS.pdf",bbox_inches='tight')
plt.close()


# Figura de los ajustes.
plt.plot(X_grilla, Y_grilla, '--', color="black")
plt.plot(X,Y,'.', color='black')
plt.ylim(-1.5,1.5)
H = modelos_OLS[9].params
plt.plot(X_grilla, modelo_causal_deterministico(X_grilla, H), color=cmap(9), label= f'Modelo {9}' )
plt.legend(ncol=2)
plt.savefig("pdf/model_selection_OLS_best-at-train.pdf",bbox_inches='tight')
plt.close()



#
# 3.4 Evaluación de la predicción "en línea" que hacen los modelos ajustados por máxima verosimilitud
#

# Predicción
def prediccion(y,x,H):
    # P(y|x,h,M)
    py_xhM = norm(loc=modelo_causal_deterministico(x, H), scale=np.sqrt(1/BETA))
    return py_xhM.pdf(y)[0]

# Inicializa la lista de las evidencias OLS
log_evidencia_OLS = [0 for _ in range(D)]
# Ajusta los modelos con al menos un dato (todos predicen igual el primer dato)
modelos_OLS = [OLS(Y[0:1], phi(X[0:1],d)).fit() for d in range(D)]
# Itera sobre los datos
for i in range(1,N):
    x = X[i]; y = Y[i] # Siguiente dato observado
    # Itera sobre los modelos
    for d in range(D):
        # Hipótesis de máxima verosimilitud
        H = modelos_OLS[d].params
        # Calcula la predicción en órdenes de magnitud
        log_evidencia_OLS[d] += np.log(prediccion(y,x,H))
        # Vuelve a ajustar el modelo con el nuevo dato
        modelos_OLS[d] = OLS(Y[0:i+1], phi(X[0:i+1],d)).fit()

# Figura de las evidencias_OLS
for d in range(D):
    plt.bar(d, np.exp(log_evidencia_OLS[d]), align='center', color=cmap(d), label=f'Modelo {d}')

plt.savefig("pdf/model_selection_maxApriori_online.pdf",bbox_inches='tight')
plt.close()


#
# 3.5 Regularizadores: Máximo a posteriori
#

import ModeloLineal as ml # Vamos a usar nuestra propia implemetación, que tiene la solución exacta

# Para guardar la selección de hipótesis
modelos_MAP = []
for d in range(D):
    MU_d, COV_d = ml.posterior(Y, phi(X, complejidad = d) # Datos (Y, X) y Modelos (complejidad)
                               , alpha=ALPHA*100)         # Un prior 100 veces más informativo que el valor por defecto
    modelos_MAP.append({"mean":MU_d.reshape(1,d+1)[0], # Las hipótesis que maximizan el posterior
                        "cov":COV_d})                  # Guardamos la covarianza del posterior (gaussiana multivariada)

# Figura de los ajustes.
plt.plot(X_grilla, Y_grilla, '--', color="black")
plt.plot(X,Y,'.', color='black')
plt.ylim(-1.5,1.5)
for d in range(D):
    plt.plot(X_grilla,
             modelo_causal_deterministico(X_grilla, modelos_MAP[d]["mean"]),
             color=cmap(d), label= f'Modelo {d}' )

plt.legend(ncol=2)

plt.savefig("pdf/model_selection_maxPosteriori_ajustes.pdf",bbox_inches='tight')
plt.close()


# Selecciona las hipótesis con el primer dato Y[0:1] e X[0:1]
modelos_MAP = []
for d in range(D):
    MU_d, COV_d = ml.posterior(Y[0:1],phi(X[0:1], complejidad = d), alpha=ALPHA*100)
    modelos_MAP.append({"mean":MU_d.reshape(1,d+1)[0], "cov":COV_d})

# Inicializa el órden de magnitud de las evidencias en 0
log_evidencia_MAP = [0 for _ in range(D)]
# Itera sobre los datos
for i in range(1,N):
    x = X[i]; y = Y[i] # Siguiente dato observado
    # Itera sobre los modelos
    for d in range(D):
        # Hipótesis de máxima a posteriori
        H = modelos_MAP[d]["mean"]
        log_evidencia_MAP[d] += np.log(prediccion(y,x,H))
        MU_d, COV_d = ml.posterior(Y[0:d],phi(X[0:d], complejidad = d), alpha=ALPHA*100)
        modelos_MAP[d] = {"mean":MU_d.reshape(1,d+1)[0], "cov":COV_d}


for d in range(D):
    plt.bar(d, np.exp(log_evidencia_MAP[d]), align='center', color=cmap(d), label=f'Modelo {d}')


plt.savefig("pdf/model_selection_maxPosteriori_prediccionAPriori.pdf",bbox_inches='tight')
plt.close()

#
# 3.6 Posterior de los modelos
#

# La evidencia P(Datos|Modelo) en escala logarítmica
log_evidence_d = []
for d in range(D):
    log_evidence_d.append(ml.log_evidence(Y, phi(X,d))[0][0])

# El posterior P(Modelo | Datos )
pM_Datos = np.exp(log_evidence_d) /sum(np.exp(log_evidence_d))

# Figura del posterior
for d in range(D):
    plt.bar(d, pM_Datos[d], align='center', color=cmap(d), label=f'Modelo {d}')

plt.savefig("pdf/model_selection_posterior.pdf",bbox_inches='tight')
plt.close()

#
# 3.7 Por qué el balance natural
#

modelos_MAP = []
for d in range(D):
    MU_d, COV_d = ml.posterior(Y,phi(X, complejidad = d), alpha=ALPHA)
    modelos_MAP.append({"mean":MU_d.reshape(1,d+1)[0], "cov":COV_d})

plt.plot(X_grilla, Y_grilla, '--', color="black")
plt.plot(X,Y,'.', color='black')
plt.ylim(-1.5,1.5)
for d in range(D):
    plt.plot(X_grilla,
             modelo_causal_deterministico(X_grilla, modelos_MAP[d]["mean"]),
             color=cmap(d), label= f'Modelo {d}' )

plt.axvline(-0.23, linestyle="--", color = "gray", alpha=0.5)
plt.legend(ncol=2, fontsize=10)

plt.savefig("pdf/model_selection_MAP_non-informative.pdf",bbox_inches='tight')
plt.close()

# La posición donde veremos el siguiente dato y_new
x_new = np.array([[-0.23]])
# Todos los posibles valores del siguiente dato (en un rango)
y_range = np.arange(-2.5,0.5,0.01).reshape(1,300)

# P(y|x_new, Datos, Modelo)
py_xnewDatosMd = []
for d in range(D):
    pred = ml.predictive(y_range,                                  # y (todo el rango)
                         np.matrix(phi(x_new,d)),                  # x_new = -0.23 (su transformación)
                         alpha=ALPHA, beta=BETA,                   # Priors (modelo)
                         t_priori= Y[0:4],                         # Datos_y los primeros 4
                         Phi_priori = np.matrix(phi(X[0:4],d)))    # Datos_x los primeros 4 (su transformación)
    py_xnewDatosMd.append(pred)

# Figuras de P(y|x_new, Datos, Modelo = d ) con d in [0,3,9]
plt.plot(y_range[0,:], py_xnewDatosMd[0], color=cmap(0), label = "Rígido (grado 0)")
plt.plot(y_range[0,:], py_xnewDatosMd[3], color=cmap(3), label = "Simple (grado 3)")
plt.plot(y_range[0,:], py_xnewDatosMd[9], color=cmap(9), label = "Complejo (grado 9)")
plt.xlabel("y|x=-0.23")
plt.ylabel("P(Datos | Modelo)")
plt.legend()
#plt.axvline(np.sin(2 * np.pi * -0.23), linestyle="--", color = "black")

plt.savefig("pdf/model_selection_prediccionEnX.pdf",bbox_inches='tight')
plt.close()


