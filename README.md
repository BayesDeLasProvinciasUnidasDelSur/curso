

Contactos a **bayesdelsur(en)gmail**


## Temas

| Nombre  | Responsable  | Materiales | Fecha estimada | Método |
|:-:|:-:|:-:|:-:|:-:|
| A logic of plausible inference: Cox's theorem| - | [paper](https://www.sciencedirect.com/science/article/pii/S0888613X03000513)| - | Teorema |
| Causal Inference in Statistics: A premier | - | [Libro](http://gen.lib.rus.ec/) | - | Intervenciones y do-calculus |
| TrueSkill: A Bayesian Skill Rating System | -| [Paper](https://papers.nips.cc/paper/3079-trueskilltm-a-bayesian-skill-rating-system) | - | Analítico y Variacional (EP) |
| TrueSkill Through Time: Revisiting the History of Chess | - | [Paper](https://papers.nips.cc/paper/3331-trueskill-through-time-revisiting-the-history-of-chess) | - |  Variacional (EP)|
| Match Box: Large Scale Online Bayesian Recommendations | -  | [Paper](https://www.microsoft.com/en-us/research/wp-content/uploads/2009/01/www09.pdf) | - |  Variacional (EP y VB)|
| Probabilistic Backpropagation for Scalable Bayesian Neural Networks | - |[Paper](http://proceedings.mlr.press/v37/hernandez-lobatoc15.html)| - | Variacional (EP) |
| Tencent Advertising System | - | [Paper](https://arxiv.org/abs/1707.00802) | - | Probabilistic Backpropagation (EP) |
| Reinforcement Learning and Control as Probabilistic Inference | - | [paper](https://arxiv.org/abs/1805.00909) | - | RL y modelos gráficos|


# Bibliografía

Books:

0. Bishop. [Pattern Recognition and Machine Learning](https://www.microsoft.com/en-us/research/publication/pattern-recognition-machine-learning/)
0. Pearl. [Causality](ss) y [Causal Inference in Statistics: A premier](http://gen.lib.rus.ec/)
0. Russell y Norvig [Artificial Intelligence: A Modern Approach](http://libgen.rs/search.php?req=Artificial+Intelligence%3A+A+Modern+Approach&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def)
0. Koller y Friedman [Probabilistic Graphical Models, Principles and Techniques](http://libgen.rs/search.php?req=Probabilistic+Graphical+Models%2C+Principles+and+Techniques&open=0&res=25&view=simple&phrase=1&column=def)

Cursos:

0. Probabilistic Machine Learning. [youtube](https://youtube.com/playlist?list=PL05umP7R6ij1tHaOFY96m5uX3J21a6yNd)

Papers:

0. [Constructing a logic of plausible inference: a guide to Cox's theorem](https://www.sciencedirect.com/science/article/pii/S0888613X03000513)
0. [Factor Graphs and the Sum-product algorithm](https://ieeexplore.ieee.org/document/910572)
0. [TrueSkill: A Bayesian Skill Rating System](https://papers.nips.cc/paper/3079-trueskilltm-a-bayesian-skill-rating-system)
0. [TrueSkill Through Time: Revisiting the History of Chess](https://papers.nips.cc/paper/3331-trueskill-through-time-revisiting-the-history-of-chess)
0. [Match Box: Large Scale Online Bayesian Recommendations](https://www.microsoft.com/en-us/research/wp-content/uploads/2009/01/www09.pdf)
0. [Probabilistic Backpropagation for Scalable Bayesian Neural Networks](http://proceedings.mlr.press/v37/hernandez-lobatoc15.html)
0. [Parallel Bayesian Online Deep Learning for Click-Through Rate Prediction in Tencent Advertising System](https://arxiv.org/abs/1707.00802)
0. [Reinforcement Learning and Control as Probabilistic Inference: Tutorial and Review](https://arxiv.org/abs/1805.00909)

Blogs:

0. [Bayesian optimization](https://distill.pub/2020/bayesian-optimization/)

Tools:

0. [Gaussain process with pytroch](https://gpytorch.ai/)


# Eventos realizados

### [clase1-2021-01-28.mp4](https://github.com/glandfried/videos/releases/download/bayes.2021.1/clase1-2021-01-28.mp4)

Introducción.
Cómputo de creencias honestas (o teoría de la probabilidad).
Monty Hall Bayesiano, resuelto enteramente bajo el principio de indiferencie (dividiendo la certidumbre por los caminos del modelo causal).

### [clase_funciones-2021-04-08.mp4](https://github.com/glandfried/videos/releases/download/bayes.2021.1/clase_funciones-2021-04-08.mp4)

Datos como fuciones.
Estructura invariante del dato.
Examenes de la operacionalización del dato.
Modelos causales como funciones.
Modelo ELO.
Modelos no-lineales.
Atractores fijos, períodicos y caótico (sensibilidad a condiciones iniciales).
La maquina de Turing como sistema deteminista. ¿Podemos computar números aleatorios?.
Podemos "imitarlos", no generarlos. Pero existe el conceptos teórico de "libre albedrio", que las personas no son funciones, que no tienen destinos inevitable.
En estos casos usamos fuciones de probabilidad para expresar nuestra incertidumbre.
Fundamentos de validez del conocimiento ("afirmar sólo lo que se sabe"), criterio de honestidad como función.
Hipótesis indicadora de ELO.
El teorema de bayes como generalización de la hipótesis indicadora.
Los datos como síntesis de las evidencias formales y empíricas
Concepto de "base empírica" y t-teoricidad.

### [clase_bayes2-2021-06-30.mp4](https://github.com/glandfried/videos/releases/download/bayes.2021.1/clase_bayes2-2021-06-30.mp4)

Intro histórica (con Árabes)
Distribución Binomial y el coeficiente binomial.
Prop7 de Bayes: el ejemplo de la mesa de billar.
Distribución Beta para k y n naturales.
Visualizaciones.
Derivación de Beta como posterior con un prior uniforme.
Derivación de la constate de normalización con un prior uniforme. 
Implementación en vivo para calacular la constante de normalización con diferentes priors.
Resumen, Máximo, mediana, esperanza.
La esperanza de la Beta como una frecuencia que incluye dos eventos más, uno positivo y otro negativo.
El mismo resultado al que llega Laplace cuando calcula la esperanza de que mañana salga el sol dado que salió los últimos N grande de días. 
ABtest y visualización.


### [clase_sumproduct_1_2021-06-02.mp4](https://github.com/glandfried/videos/releases/download/bayes.2021.1/clase_sumproduct_1_2021-06-02.mp4)

Presentamos el modelo causal de la Alarma, Entradera, Terremoto. Hablamos en detalle de los priors (condicionales) . Caculamos la conjunta en un punto. La marginal de la Alarma. Hasta ahí quedó bien. Al final nos quedamos sin tiempo y quedó confuso

### [clase_sumproduct_2_2021-06-16.mp4](https://github.com/glandfried/videos/releases/download/bayes.2021.1/clase_sumproduct_2_2021-06-16.mp4)

Hablamos de la imagen del final que tiene al Inti, el sol de la bandera. Revisamos por arriba lo que vimos en la reunión pasada (Sum-product 1). Implementamos en Julia los priors como matrices, y las marginales como funciones. Presentamos el sum-product algorithm con detalle (la proxima va a haber que explicar mejor la notación). Y vimos ejemplos: calculamos todo los mensajes cuando no hay observables (y sus marginales). Y nos hicimos la pregunta que nos va a llevar a D-SEPARATION, respecto del cierre y la apertura de los flujos de inferencia y resolvimos parcialmente la pregunta pasando mensajes cuando hay observables.  



| Evento  | Tema  | Responsable  | Fecha | Lugar | Materiales | Release |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| 2020.1.2 | Regresión lineal bayesiana y selección de modelo |  Landfried |  28/04/2020 | videos:[1](https://github.com/BayesDeLasProvinciasUnidasDelSur/seminario/releases/download/v2020.1.2/clase1_0.mp4),[2](https://github.com/BayesDeLasProvinciasUnidasDelSur/seminario/releases/download/v2020.1.2/clase1_1.mp4) | | [v2020.1.2](https://github.com/BayesDeLasProvinciasUnidasDelSur/seminario/releases/tag/v2020.1.2) |
| 2020.1.1 | Máxima entropía condicional y modelo gráficos | Landfired | 10/03/2020 | videos:[1](https://github.com/BayesDeLasProvinciasUnidasDelSur/seminario/releases/download/v2020.1.1/clase1_0.mp4),[2](https://github.com/BayesDeLasProvinciasUnidasDelSur/seminario/releases/download/v2020.1.1/clase1_1.mp4),[3](https://github.com/BayesDeLasProvinciasUnidasDelSur/seminario/releases/download/v2020.1.1/clase1_2.mp4)  | [Charla]() [Practica]()| [v2020.1.1](https://github.com/BayesDeLasProvinciasUnidasDelSur/seminario/releases/tag/v2020.1.2) | 

# (Pre-)Programa para eventual materia

- Objetivo: Aprender inferencia probabilistica y sus algoritmos eficientes
- Metodología: Damos todas las pistas que necesites, pero lo tenés que descubrir vos.
- Requiere: Programar (if, for y listas) y me re-interesa la ciencia de datos 

### Encuentro 1

- **Requiere**: True
- **Teorica**: Datos, modelos (gráficos) y creencias 
- **Práctica**:
    1. Usar sorpresa del Modelo elo para actualizar hipótesis
    2. Distribuciones de creencias honestas, ejemplos.
    3. Reglas de la honestidad.
    4. Monty Hall.
    5. Monty Hall extendido (sólo se presenta el modelo)
- **Asegura**: Entiendo la definición de creencia honesta. ¿Cómo se resuelve el Monty Hall extendido?
- *Tarea*: Buscar los papers que vamos a leer en el futuro 
- *Leer*: 

### Encuentro 2

- **Requiere**: previo
- **Teorica**: Reglas de la probabilidad, sum-product algorithm, definición de d-separation, mostrar modelo gráfico trueskill otra vez.
- **Práctica**:
    0. Resolver algunas inferencias en el monty hall extendido
    0. Jugar con el paquete TrueSkill 
    0. Dejar ejemplos sintéticos para resolver con trueskill
- **Asegura**: Entendí como usar las reglas de la suma y el producto en modelos gráficos.
- *Tarea*:
    1. Terminar de redescubrir flujo de inferencia (d-separation)
    2. Estimar con trueskill sobre los ejemplos sintéticos
- *Leer*: Leer paper original de TrueSkill

### Encuentro 3

| 3 | Modelos gráfico de TrueSkill y pasaje de mansajes 1| Evidencia 1 vs 1 | El pasaje de mensajes se entendió pero necesito que me lo expliquen mejor | Resolver evidencia 2vs2 y Estimar habilidad en tenis (descargar datos)  | Leer: sum-product algorithm |
| 4 | Consultas | Terminar de estimar habilidad y calcular evidencia |  | Deadline | -
| 5 | Pasaje de mansajes 2  | | El modelo gráfico de TrueSkill se entendió pero necesito que me lo expliquen mejor | | Fuentes Alternativas "The math behind trueskill" y "Model based machine learning".



### Clase 2.

- Requiere: asegura previo.
- Tarea
    - Teórica: Pasaje de mansajes 3 (Posterior)
    - Práctica: Calcular prediccón a priori (documentar y crear código própio)
- Asegura: El modelo gráfico de TrueSkill se entendió completo.

### Clase 3. 





