from statsmodels.api import OLS # Para selección de hipótesis
import ModeloLineal as ml       # Para evaluación de hipótesis y modelos (archivo ModeloLineal.py)
from scipy.stats import norm    # La distribución gaussiana
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

matplotlib.rcParams.update({'font.size': 14})
np.random.seed(1) # Para reproducir los datos

cmap = plt.get_cmap("tab10") # Colores para los modelos

BETA = (1/0.04) # Precisión de los datos, el inverso de su varianza
ALPHA = (10e-6) # Precisión de la creencia a prior, el inverso de su varianza

#
# 4.1
#

import pandas as pd
Alturas = pd.read_csv("datos/alturas.csv")
Alturas.head()


plt.scatter(Alturas.altura_madre[Alturas.sexo=="M"],Alturas.altura[Alturas.sexo=="M"], label="Masculinas")
plt.scatter(Alturas.altura_madre[Alturas.sexo=="F"],Alturas.altura[Alturas.sexo=="F"], label="Fememinas")
plt.xlabel("Altura madre")
plt.ylabel("Altura")
plt.legend()

plt.savefig("pdf/alturas_visualizacion_por_sexo.pdf",bbox_inches='tight')
plt.close()

#
# 4.2. Definir 3 modelos causales alternativos
#
from statsmodels.api import OLS
import ModeloLineal as lm

N, _ = Alturas.shape
Y_alturas = Alturas.altura
X_base = pd.DataFrame({"Base": [1 for _ in range(N)],    # Origen
                       "Altura": Alturas.altura_madre,  # Pendiente
             })

X_biologico = pd.DataFrame({"Base": [1 for _ in range(N)],    # Origen
                            "Altura": Alturas.altura_madre,  # Pendiente
                            "Sexo": (Alturas.sexo=="M")+0     # Sexo
             })
X_identidad = {"Base": [1 for _ in range(N)],    # Origen
               "Altura": Alturas.altura_madre  # Pendiente
            }
for i in range(25):
    X_identidad[f'id{i}'] = [ ((j % 25) == i)+0 for j in range(N)]

X_identidad = pd.DataFrame(X_identidad)

#
# 4.3. Computar el posterior
#

log_pDatos_Modelo = np.zeros(3)
log_pDatos_Modelo[0] = (ml.log_evidence(Y_alturas, X_base))
log_pDatos_Modelo[1] = (ml.log_evidence(Y_alturas, X_biologico))
[2] = (ml.log_evidence(Y_alturas, X_identidad))


# Figura de las evidencias_OLS
for d in range(3):
    plt.bar(d, log_pDatos_Modelo[d], align='center', color=cmap(d), label=f'Modelo {d}')

plt.savefig("pdf/alturas_log_evidencia",bbox_inches='tight')
plt.close()



(ml.posterior(Y_alturas, X_base))
(ml.posterior(Y_alturas, X_biologico))
(ml.posterior(Y_alturas, X_identidad))


np.exp(log_pDatos_Modelo[0]/50)
np.exp(log_pDatos_Modelo[1]/50)














