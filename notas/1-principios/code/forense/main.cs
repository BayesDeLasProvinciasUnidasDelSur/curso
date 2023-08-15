using Microsoft.ML.Probabilistic.Algorithms;
using Microsoft.ML.Probabilistic.Distributions;
using Microsoft.ML.Probabilistic.Models;
using Range = Microsoft.ML.Probabilistic.Models.Range;
namespace Forense{

public class Apuntes{
  public void Example1(){
    // The model defined using the modelling API
    Variable<double> mean = Variable.GaussianFromMeanAndVariance(0, 100);
    Variable<double> precision = Variable.GammaFromShapeAndScale(1, 1);
    VariableArray<double> data = Variable.Observed(new  double[] { 11, 5, 8, 9 });
    Range i = data.Range;
    data[i] = Variable.GaussianFromMeanAndPrecision(mean, precision).ForEach(i);

    // Create an inference engine for VMP
    InferenceEngine engine = new InferenceEngine(new VariationalMessagePassing());
    // Retrieve the posterior distributions
    Gaussian marginalMean = engine.Infer<Gaussian>(mean);
    Gamma marginalPrecision = engine.Infer<Gamma>(precision);
    Console.WriteLine("mean=" + marginalMean);
    Console.WriteLine("prec=" + marginalPrecision);
  }
}

class Program{
  static void Main(string[] args){
    var apunte = new Apuntes();
    apunte.Example1();
  }
}




} //End namespace
