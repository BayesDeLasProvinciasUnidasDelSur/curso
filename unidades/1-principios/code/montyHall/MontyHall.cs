// https://github.com/dotnet/infer/blob/57c888024c690ad2fdfd2f70214848485451c0e3/src/Examples/MontyHall/Window1.xaml.cs#L35
using Microsoft.ML.Probabilistic.Algorithms;
using Microsoft.ML.Probabilistic.Distributions;
using Microsoft.ML.Probabilistic.Models;
using Range = Microsoft.ML.Probabilistic.Models.Range;

namespace MontyHall{
public class Funciones{
  public void ejemplo1(int e, int d){
    // Modelo

    double[] prior = {1.0/3.0,1.0/3.0,1.0/3.0};
    var regalo = Variable.Discrete(prior);
    var eleccion = Variable.DiscreteUniform(3).Named("eleccion");
    var pista =  Variable.New<int>().Named("pista");
    // Variable<bool> pistaIsObserved;
    // pistaIsObserved = Variable.Observed<bool>(false);
    for (int a = 0; a < 3; a++){
      for (int b = 0; b < 3; b++){
        double[] probs = { 1, 1, 1 };
        for (int ps = 0; ps < 3; ps++){
          if (ps == a || ps == b){
            probs[ps] = 0;
          }
        }
        using (Variable.Case(eleccion, a)){
          using (Variable.Case(regalo, b)){
            Console.WriteLine(probs[0]+","+probs[1]+","+probs[2]);
            pista.SetTo(Variable.Discrete(probs));
          }
        }
      }
    }

    InferenceEngine engine = new InferenceEngine();

    Console.WriteLine("  Posterior del pista: "+engine.Infer(pista));
    eleccion.ObservedValue = e;
    Console.WriteLine("  Posterior del pista: "+engine.Infer(pista));
    pista.ObservedValue = d;
    Console.WriteLine("  Posterior del regalo: "+engine.Infer(regalo));

    Console.WriteLine("End Monty Hall!");
  }
}


class Program{
  static void Main(string[] args){
    var funciones = new Funciones();
    funciones.ejemplo1(0,1);
    Console.WriteLine("Chau mundo!");
  }
}

}
