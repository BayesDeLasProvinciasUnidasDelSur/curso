# Seminario: Verdades Empíricas
### Acuerdos intersubjetivos en contextos de incertidumbre

Contactos a **bayesdelsur@gmail.com**

-------------------------------------------------------

## Objetivos

A diferencia de las ciencias formales, que validan sus proposiciones dentro de sistemas axiomáticos cerrados, las ciencias empíricas (desde la física hasta las ciencias sociales) deben validar sus proposiciones en sistemas abiertos que por definición contienen siempre algún grado de incertidumbre. ¿Es posible alcanzar "verdades" si es inevitable decir "no sé"?. Sí. La aplicación estricta de las reglas de la probabilidad (enfoque Bayesiano) garantiza los acuerdos intersubjetivos en contextos de incertidumbre, fundamento de las verdades empíricas. Bajo incertidumbre, la lógica es paraconsistente en tanto se hace necesario creer al mismo tiempo en A y no A hasta que la sorpresa, única fuente de información, decida. Debido a que este proceso de selección es, como el evolutivo, de naturaleza multiplicativa (un solo cero en la secuencia de reproducción y supervivencia genera una extinción), existe una ventaja a favor de las variantes que reducen las fluctuaciones. Si bien la aplicación estricta de la teoría de la probabilidad ha mostrado ser la lógica ideal en contextos de incertidumbre, su adopción se vio históricamente limitada debido al alto costo computacional asociado: a diferencia del enfoque frecuentista de la probabilidad que selecciona una única hipótesis, el enfoque Bayesiano actualiza las creencias de todas y cada una de las hipótesis de acuerdo a la evidencia empírica y formal (datos y modelos). Si bien en las últimas décadas las limitaciones computacionales han sido superadas en gran medida gracias al desarrollo de métodos eficientes de aproximación, la inercia histórica es ahora su limitación principal. **Este curso tiene por objetivo promover la adopción del enfoque Bayesiano como método general para la resolución de cualquier problema empírico: en la ciencia, la política y la ecología.**

## Agenda de cursada: [2023 primer cuatrimestre](https://github.com/BayesDeLasProvinciasUnidasDelSur/congreso/releases/download/curso.2022/verdades_empiricas.pdf)

### Primera Parte: Fundamentos

No se requiere ningún tipo de formación previa. Toda persona puede hacerlo.

- **1. Principios interculturales de acuerdos intersubjetivos**. Principio de razón suficiente, de integridad, de indiferencia y de coherencia. Las reglas de razonamiento bajo incertidumbre. Evaluación de creencias.
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:
- **2. Sorpresa: el problema de la comunicación con la realidad**. La estructura invariante del dato empírico: fuente, realidad causal, señal, canal, percepción, modelo causal, estimación. Base empírica y datos teóricos. Máxima incertidumbre e información.
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:
- **3. La función de costo epistémico-evolutiva**. Ventajas a favor de la: Diversificación (propiedad epistémica), Cooperación (propiedad evolutiva mayor), Especialización (propiedad meta-epistémica), Coexistencia (propiedad ecológica).
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:
- **4. Modelos gráficos y algoritmos de pasaje de mensajes**. Métodos gráficos de especificación de modelos causales. Cómputo descentralizado de la inferencia y la predicción. Algoritmo suma-producta.
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:
- **5. Flujos de inferencia**. Apertura y cierre de flujos de inferencia en las estructuras causales fork, pipe y colider. Criterio general de separación (independencia) de variables.
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:
- **6. Inferencia Causal**. Conclusiones causales a partir de datos observacionales. El efecto de las intervenciones sobre los modelos gráficos. Los criterios de puerta trasera y delantera. Contrafácticos.
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:

### Segunda Parte: Metodologı́as

Sin implicar exclusión, se requieren algunos conocimiento mı́nimos de álgebra, análisis y programación

- **7. Distribuciones de creencias**. Máxima incertidumbre. Gases. Riqueza. Procesos irreversibles. Polya Urn. La familia exponencial: Bernoulli, Binomial, Beta, Multinomial, Dirichlet, Guassiana, Gamma
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:
- **8. Evaluación de modelos**. La emergencia del sobreajuste (overfitting) en los enfoques que seleccionan una única hipótesis. El balance natural de la evaluación correcta del espacio de hipótesis (evidencia). Ejemplo: regresión lı́neal bayesiana.
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:
- **9. Aproximaciones analı́ticas**. Métodos eficientes de aproximación: minimización por expectation propagation y variational inference. Ejemplo: estimación de habilidad en la industria del video juego.
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:
- **10. Series de tiempo**. El problema de usar el posterior como prior del siguiente evento. La mutua dependencia de las hipótesis en modelos de historia completa. Ejemplo: estimación de habilidad estado-del-arte.
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:
- **11. Aproximaciones por exploración**. Métodos para modelos causales intratables: Markov chain Monte Carlo. Metrópolis-Hasting y Hamiltonian Monte Carlo.
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:
- **12. Programación Probabilísticas**. Implementación de modelos usando lenguajes de programación probabilı́stica. Verificación visual de buen funcionamiento de las aproximaciones.
    - Teórica:
    - Práctica:
    - Bibliografía:
    - Videos:
## Manuales:

0. **Bishop**. [Pattern Recognition and Machine Learning](https://www.microsoft.com/en-us/research/publication/pattern-recognition-machine-learning/)
0. **MacKay**. [Information theory, inference and learning algorithms](https://www.inference.org.uk/itprnn/book.pdf)
0. **Pearl**. [Causality](111.90.145.72/get.php?md5=aea29d62416c43c4b3c94444ecad5beb&key=3HX5RWW4J5RHCGGS&mirr=1) y [Causal Inference in Statistics: A premier](http://gen.lib.rus.ec/)
0. Jaynes (2003) [Probability theory: The logic of science](http://www.med.mcgill.ca/epidemiology/hanley/bios601/GaussianModel/JaynesProbabilityTheory.pdf)
0. Rasmussen [Gaussian Processes for Machine Learning](http://gaussianprocess.org/gpml/chapters/RW.pdf)I
0. Stan. [Documentation](https://mc-stan.org/docs/2_29/stan-users-guide-2_29.pdf)
0. Koller y Friedman [Probabilistic Graphical Models, Principles and Techniques](http://libgen.rs/search.php?req=Probabilistic+Graphical+Models%2C+Principles+and+Techniques&open=0&res=25&view=simple&phrase=1&column=def)
0. Halpern (2017) [Reasoning about uncertainty](http://libgen.rs/search.php?req=Reasoning+about+uncertainty&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def)
0. Russell y Norvig [Artificial Intelligence: A Modern Approach](http://libgen.rs/search.php?req=Artificial+Intelligence%3A+A+Modern+Approach&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def)
0. Knuth [*Chapter 3 — Random Numbers* in The art of computer programming II](http://libgen.rs/search.php?req=Donald+Knuth&lg_topic=libgen&open=0&view=simple&res=25&phrase=1&column=def) 

## Cursos:

0. **Probabilistic Machine Learning** [youtube](https://youtube.com/playlist?list=PL05umP7R6ij1tHaOFY96m5uX3J21a6yNd)
0. Information Theory (by MacKay) [youtube](https://www.youtube.com/watch?v=BCiZc0n6COY)
0. Física estadísitica. [youtube](https://www.youtube.com/watch?v=GL73N3z0j70&t)
0. Deep Bayes. [youtube](https://www.youtube.com/playlist?list=PLe5rNUydzV9QHe8VDStpU0o8Yp63OecdW)
0. Probabilistic Graphical Models. Carnegie-Mellon University. [web](http://www.cs.cmu.edu/~epxing/Class/10708-09/lecture.html)

# Fundamentos de la probabilidad:

0. Jaynes (1956-1957). Information theory and statistical mechanics [I](https://bayes.wustl.edu/etj/articles/theory.1.pdf) [II](http://users.df.uba.ar/ariel/materias/FT3_2011_2C/Extra/Jaynes.II.pdf)
0. Kelly (1956). [A New Interpretation of Information Rate](https://www.princeton.edu/~wbialek/rome/refs/kelly_56.pdf)
0. Shannon (1950). [A mathematical theory of communication](https://pure.mpg.de/rest/items/item_2383162/component/file_2456978/content)
0. De Finetti. (1937) [La prévision: ses lois logiques, ses sources [inter]subjectives](www.numdam.org/article/AIHP_1937__7_1_1_0.pdf)
0. Kolmogorov. (1933) [Foundations of the theory of probability](https://libgen.rocks/get.php?md5=c0fc408ef51b17d7afdb7cf35d2e81ef&key=VOIY6EBUGE4AM7GQ)
0. Jeffreys (1931). [Scientific Inference](https://libgen.rocks/get.php?md5=f40e5b6e52f2a05295c8984a7d6d2886&key=P5AOQ0CDN2AEDCBD)
0. Ramsey (1926). [Truth and probability](http://eprints.ukh.ac.id/id/eprint/240/1/2016_Book_ReadingsInFormalEpistemology.pdf#page=42) [(1927) A Contribution to the Theory of Taxation](https://www.jstor.org/stable/pdf/2222721.pdf)
0. Keynes, John Maynard (1921) [A Treatise on Probability](http://gutenberg.readingroo.ms/3/2/6/2/32625/old/2010-05-31-32625-pdf.pdf)
0. Poincaré. (1912) [Calcul des probabilités](https://www.ime.usp.br/~walterfm/cursos/mac5796/Poincare12.pdf)
0. Gibbs
0. Boltzmann
0. Boole. (1854) [An Investigation of the Laws of Thought](https://downloads.tuxfamily.org/openmathdep/logic_ante_1900/Laws_of_Thought-Boole.pdf)
0. Poisson (1837) [Recherches sur la probabilité des jugements](https://www-liphy.univ-grenoble-alpes.fr/pagesperso/bahram/Phys_Stat/Biblio/Poisson_Proba_1838.pdf)
0. Laplace. ([1795] 1812) [Théorie analytique des probabilités](93.174.95.29/main/11000/accf70cf7847f79b1940cc91ee65c1fb/Laplace%20J.-B.%20-%20Theorie%20des%20probabilites%20%28Oeuvres%29.%20Tome%207-Gauthier~Villars%20%281886%29.djvu)
0. Condorcet (1785). [Essai sur l'application de l'analyse à la probabilité des décisions rendues à la pluralité des voix](https://www.hist-math.fr/users/Histoires/textes/Condorcet1785_ProbabiliteDecisions.pdf)
0. Bayes ([1750?] 1763). [An essay towards solving a problem in the doctrine of chances.](https://royalsocietypublishing.org/doi/pdf/10.1098/rstl.1763.0053?keytype2=tf_ipsecsha&ijkey=d86e9f6c361806fb58be6aad56cb2bcfade22c74)
0. Bernoulli, Daniel "el sobrino". (1738) [Exposition of a new theory on the measurement of risk](http://www.theparticle.com/cs/bc/dsci/Bernoulli_1738.pdf) [Traducido de "Specimen Theorize Naval de Mensura Sortis" en 1954]
0. Leibniz (1714) [La monadologie](https://philo-labo.fr/fichiers/Leibniz%20-%20La%20monadologie.pdf) ([Leibniz and China: A Commerce of Light](http://libgen.rs/book/index.php?md5=714C21EB77B595EF583F926FC64E083A))
0. Bernoulli, Jacob. ([1654-1705] 1717) [Ars Conjectandi (English version)](https://libgen.rocks/get.php?md5=2a824bcdb31b45a94882ace89eaaa35e&key=19K8AAU67RBVK67G)
0. Pascal-Fermat por Keith Devlin. ([1654] 2008) [The Unfinished game: Pascal, Fermat and the letters](31.42.184.140/main/73000/bed190e8d465fc8a07a05709c22924a3/Keith%20Devlin%20-%20The%20Unfinished%20game_%20Pascal%2C%20Fermat%20and%20the%20letters-Basic%20Books%20%282008%29.pdf) (Si no funciona, borrar del link todo lo que está antes de la IP)

# Tópicos 

0. [Factor Graphs and the Sum-product algorithm](https://ieeexplore.ieee.org/document/910572)
0. [Crash Course in Good and Bad Controls](https://papers.ssrn.com/sol3/Delivery.cfm/SSRN_ID4062645_code4146131.pdf?abstractid=3689437&mirid=1)
0. [Probabilistic Topic Models](https://oar.princeton.edu/bitstream/88435/pr1bv3w/1/OA_IntroductionProbabilisticTopicModels.pdf)
0. [TrueSkill: A Bayesian Skill Rating System](https://papers.nips.cc/paper/3079-trueskilltm-a-bayesian-skill-rating-system)
0. [TrueSkill Through Time: Revisiting the History of Chess](https://papers.nips.cc/paper/3331-trueskill-through-time-revisiting-the-history-of-chess)
0. [Match Box: Large Scale Online Bayesian Recommendations](https://www.microsoft.com/en-us/research/wp-content/uploads/2009/01/www09.pdf)
0. [Probabilistic Backpropagation for Scalable Bayesian Neural Networks](http://proceedings.mlr.press/v37/hernandez-lobatoc15.html)
0. [Parallel Bayesian Online Deep Learning for Click-Through Rate Prediction in Tencent Advertising System](https://arxiv.org/abs/1707.00802)
0. [Reinforcement Learning and Control as Probabilistic Inference: Tutorial and Review](https://arxiv.org/abs/1805.00909)

## Otros

0. [Optimal eye movement strategiesin visual search](https://www.cns.nyu.edu/~david/courses/perceptionGrad/Readings/NajemnikGeisler-Nature2005.pdf)
0. [What Are Bayesian Neural Network Posteriors Really Like?](https://arxiv.org/abs/2104.14421)

# Blogs

0. [Optimal transport](http://alexhwilliams.info/itsneuronalblog/2020/10/09/optimal-transport/)
0. [Bayesian optimization](https://distill.pub/2020/bayesian-optimization/)
0. [From autoencoder to beta-VAE](https://lilianweng.github.io/lil-log/2018/08/12/from-autoencoder-to-beta-vae.html)
0. [What is a variational autoencoder](https://jaan.io/what-is-variational-autoencoder-vae-tutorial/)
0. [Intuitively variational autoencoder](https://towardsdatascience.com/intuitively-understanding-variational-autoencoders-1bfe67eb5daf)

# Tools:

0. [Gaussain process with pytroch](https://gpytorch.ai/)
0. [GPy](https://github.com/SheffieldML/GPy)

# Cursos externos

0. Larry Wasserman [Statistical methods for machine learning](https://www.stat.cmu.edu/~larry/=sml/)
0. Tamara Broderik [Non parametric bayesian methods](https://tamarabroderick.com/tutorial_2016_mlss_cadiz.html)

# Historia 

Hobson, John. (2004) [Los orígenes orientales de la civilización de occidente](https://libgen.rocks/get.php?md5=9fb9e17c0203789eb321330af09191f0&key=9NB6QOBJLHRTVOGM)
Needham, Joseph et al. (2004) [Science and Civilization in China. Vol 7 Pt 2. General Conclusions and Reflections.](https://libgen.rocks/get.php?md5=c0cfb07bd82a9c54d37dd515bcb7450d&key=IMGZ33ANYSVSJ61F)

