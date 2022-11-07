using Microsoft.ML.Probabilistic.Algorithms;
using Microsoft.ML.Probabilistic.Distributions;
using Microsoft.ML.Probabilistic.Models;
using Range = Microsoft.ML.Probabilistic.Models.Range;

// Modelo
var regalo = Variable.Discrete([1.0/3.0,1.0/3.0,1.0/3.0]);
var eleccion = Variable.Discrete([1.0/3.0,1.0/3.0,1.0/3.0]);

// El sistema de inferencia
InferenceEngine engine = new InferenceEngine();

Console.WriteLine("End Monty Hall!");
