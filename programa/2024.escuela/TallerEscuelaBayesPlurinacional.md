# Taller Introductorio a la Inferencia Bayesiana Causal, Series Temporales y Toma de Decisiones.

## Introducción y relevancia.

Las reglas de la probabilidad se conocen desde finales del siglo 18 y desde entonces se las ha adoptado como sistema de razonamiento en todas las ciencias empíricas. Ellas son conceptualmente intuitivas: preservar la creencia previa que sigue siendo compatible con los datos (regla del producto) y predecir con la contribución de todas las hipótesis (regla de la suma). Si bien, luego de todo este tiempo no se ha propuesto nada mejor en términos prácticos, el costo computacional asociados a la evaluación de todo el espacio de hipótesis ha limitado en los hechos su campo de aplicación. Solo en las vísperas del siglo 21 comenzó a ser posible aplicar las reglas de la probabilidad de forma general para computar las distribuciones de creencias óptimas dada la información disponible en las diversas ciencias con datos, desde la física a las ciencias sociales, incluyendo la inteligencia artificial.

## Público.

El taller está diseñado para todo tipo de público. Si bien no se requiere ningún tipo de formación previa para participar, será aprovechado al máximo por personas que tengan conocimientos básico de programación.

## Objetivos

El taller tiene por objetivo ofrecer una visión amplia de los métodos bayesianos actuales: 1. Especificación de los modelos a medida del problema de forma intuitiva usando métodos gráficos y evaluación de modelos causales alternativos; 2. Cómputo eficiente de la incertidumbre óptima dada la información disponible con ejemplos en series temporales; 3. Toma de decisiones (ergódicas) en juegos de apuestas.

## Programa ([descargar versión 2023](https://github.com/BayesDeLasProvinciasUnidasDelSur/curso/releases/download/2023.1/0-programa.pdf))

El taller está organizado en 3 días, 3 horas por día.

### Día 1. Causalidad.
- **1. Modelos gráficos e inferencia** (descargar versión 2023 [1-intro.pdf](https://github.com/BayesDeLasProvinciasUnidasDelSur/curso/releases/download/2023.1/1-intro.pdf)).
    - *Teórica 1* (35 minutos). Las reglas de la probabilidad y los acuerdos intersubjetivos en contextos de incertidumbre (10'). Especificación gráfica de modelos causales alternativos y su evaluación (10'). La emergencia del sobreajuste y el balance natural de las reglas de la probabilidad (12').
    - *Práctica 1* (50 minutos). Un jupyter notbook con código para completar, implementado tres ejercicios discutidos en la presentación teórica.
        - Ejercicio 1.0 (15'). Ejemplos de uso de los paquetes y métodos que se emplean en este jupyter notebook: distribuciones de probabilidad, lectura y escritura de datos, creación de gráficos, creación de modelos usando la librería PGMpy (Probabilistic Graphical Models), marginalización y cómputo de evidencia, optimización numérica de la regresión lineal.
        - Ejercicio 1.1 (15'). Especificación y evaluación del modelo causal (discreto) Monty Hall y el modelo alternativo clásico dada una base de datos sintética que será provista usando la librería PGMpy.
        - Ejercicio 1.2 (20'). Graficar el prior, la verosimilitud y el posterior del modelo lineal usando una librería de regresión lineal bayesiana provista por el taller (10'). Graficar la evidencia (10'), o verosimilitud marginal, de modelos lineales de complejidad creciente (polinomios de grado 0 a 20).

- **2. Inferencia causal** (descargar versión 2023 [2-causa.pdf](https://github.com/BayesDeLasProvinciasUnidasDelSur/curso/releases/download/2023.1/2-causa.pdf)).
    - *Teórica 2* (35 minutos) Problemas de la inferencia causal y los niveles del razonamiento causal: asociación, intervención y contrafactual (10'). Efecto de las intervenciones en modelos causales y flujo de inferencia (10'). Identificación de efecto causal a partir de observaciones (6'). Identificación de modelo causal mediante intervenciones (6').
    - *Práctica 2* (50 minutos) Un jupyter notbook con código para completar, implementado tres ejercicios discutidos en la presentación teórica.
        - Ejercicio 2.1 (15'). Evaluación del flujo de inferencia en el modelo (discreto) terremoto-robo-alrama usando la librería PGMpy.
        - Ejercicio 2.2 (15'). Evaluación de efecto causal lineal dada una base de datos sintética que se le conoce la estructura causal usando la librería de regresión lineal provista por el taller.
        - Ejercicio 2.3. (20'). Simulación de datos, con y sin intervenciones, a partir de un modelo causal dado (10'). Evaluación de modelos causales alternativos sobre los datos con y sin intervenciones (10').

### Día 2. Series temporales.

- **3. Teoría de la información y datos** (descargar versión 2023 [3-dato.pdf](https://github.com/BayesDeLasProvinciasUnidasDelSur/curso/releases/download/2023.1/3-dato.pdf)).
    - *Teórica 3* (35 minutos) Tasa de información de modelos causales alternativos, entropía y entropía cruzada (6'). El modelo de habilidad de la Federación Internacional de Ajedrez vigente desde la década del 70 y los problemas del método de estimaciones puntuales Elo (6'). La solución bayesiana al modelo de habilidad a través del algoritmo de pasaje de mensajes entre los nodos de la red causal (10'). Comparación de las estimaciones y la tasa de información de los métodos alternativos (2').
    - *Práctica 3* (50 minutos) Un jupyter notbook con código para completar, implementado tres ejercicios discutidos en la presentación teórica.
        - Ejercicio 3.1 (10'). Computo de la tasa de información en identificación de números y en la batalla naval.
        - Ejercicio 3.2 (20'). Estimación de habilidad de tenistas profesionales usando el método Elo de la Federación Internacional de Ajedrez, cómputo de la tasa de información y gráficos de curvas de aprendizaje estimadas.
        - Ejercicio 3.3 (20'). Estimación de habilidad de tenistas profesionales usando la solución bayesiana del modelo de la Federación Internacional de Ajedrez, cómputo de la tasa de información y gráficos de curvas de aprendizaje estimadas.

- **4. Modelos de historia completa** (descargar versión 2023 [4-tiempo.pdf](https://github.com/BayesDeLasProvinciasUnidasDelSur/curso/releases/download/2023.1/4-tiempo.pdf)).
    - *Teórica 4* (35 minutos) El problema de usar el posterior como prior del siguiente evento. El algoritmo suma-producto para redes causales de historia completa (10'). Aplicación del algoritmo de propagación de información en un caso simple de dos personas que compiten en dos eventos (10'). La aproximación analítica por expectation propagation (10').
    - *Práctica 4* (50 minutos) Un jupyter notbook con código para completar, implementado tres ejercicios discutidos en la presentación teórica.
        - Ejercicio 4.1 (10') Implementación de la clase Gaussiana y la aproximación analítica.
        - Ejercicio 4.2 (25') Estimación de habilidad por loopy belief propagation en un ejemplo de dos personas y dos partidas. Graficar las estimaciones
        - Ejercicio 4.3 (15') Estimación de habilidad en una base de datos completa utilizando la librería TrueSkillThroughTime, optimización de parámetros por maximización de evidencia y gráficos de curvas de aprendizaje.

### Día 3. Toma de decisiones.

- **5. Apuestas óptimas** (descargar versión 2023 [6-hackaton.pdf](https://github.com/BayesDeLasProvinciasUnidasDelSur/curso/releases/download/2023.1/6-hackaton.pdf)).
    - *Teórica 5* (35 minutos). La naturaleza multiplicativa de los procesos de selección de las hipótesis en probabilidad. Las distribuciones de probabilidad como apuestas. El concepto de ergodicidad aplicada a la tasa de crecimiento de los recursos en un juego de apuestas simple (15'). El criterio Kelly para el cómputo de apuesta óptima. El ejemplo de las apuestas en tennis (15').
    - *Práctica 5*. Un jupyter notbook con código para completar, implementado dos ejercicios discutidos en la presentación teórica.
        - Ejercicio 5.1 (10'). Cálculo de la apuesta óptima y la tasa de crecimiento de los recursos cuando se juga individualmente apostando todo los recursos y ahorrando en el ejemplo simple visto en la teórica.
        - Ejercicio 5.2 (10'). Cálculo de la apuesta óptima y la tasa de crecimiento de los recursos cuando se juga cooperativamente apostando todo los recursos en el ejemplo simple visto en la teórica.
        - Ejercicio 5.3 (30'). Cálculo de la apuesta óptima dada una base de datos de pagos ofrecidos por casa de apuestas de tenis y las estimaciones obtenidas con TrueSkillThroughTime.

- **6. El ismorfismo epistémico-evolutivo y presentación del Hackatón** (descargar versión 2023 [5-decision.pdf](https://github.com/BayesDeLasProvinciasUnidasDelSur/curso/releases/download/2023.1/5-decision.pdf)).
    - *Teórica 6* (40 minutos) El isomorfismo entre las ecuaciones fundamentales de la teoría de la probabilidad, el teorema de Bayes, y de la teoría de la evolución, el replicator dynamic (5'). Ventajas a favor de la: diversificación (propiedad epistémica) (6'), cooperación (propiedad evolutiva) (6'), especialización (propiedad de especiación) (6'), heterogeneidad (propiedad ecológica) (6'). Presentación de una competencia de inferencia con apuestas e intercambio de recursos (10').
    - *Práctica 6*. Libre. Para terminar ejercicios prácticos no resueltos o comenzar a pensar en el Hackatón. Se ofrece un código de referencia para el Hackatón.
