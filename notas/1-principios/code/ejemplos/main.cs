using Ejemplos;
using Microsoft.ML.Probabilistic.Algorithms;
using Microsoft.ML.Probabilistic.Distributions;
using Microsoft.ML.Probabilistic.Models;
using Range = Microsoft.ML.Probabilistic.Models.Range;


var simples = new Simples();

// Ejemplos basicos
//simples.logica_con_incertidumbre();
//simples.modelo_con_ruido(true);
//simples.modelo_con_ruido(false);

 //simples.estimacion_de_ruido_simetrico();
simples.hui_walter_BLCA();

// Ejemplos: Evaluacion de modelos
//simples.seleccion_modelo_causal_mediante_observaciones();
//simples.seleccion_de_modelo_causal_mediante_intervenciones();
//simples.probabilidad_de_una_moneda(new bool[] {true, false,true,true,true,false});
//simples.experimento_medico(new bool[] {false,true,false,false,false}, new bool[] {true,true,false,true,true});

// Ejemplos con dados (multinomial - dirichlet)
//simples.probabilidad_de_un_dado(new int[] {0,1,1,1,4,3,2,5});
//simples.sorpresa_de_un_dado(new int[] {0,0,0,0,0,0,1,0,1});

Console.WriteLine("Chau mundo!");

