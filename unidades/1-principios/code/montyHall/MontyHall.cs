// https://github.com/dotnet/infer/blob/57c888024c690ad2fdfd2f70214848485451c0e3/src/Examples/MontyHall/Window1.xaml.cs#L35
using Microsoft.ML.Probabilistic.Algorithms;
using Microsoft.ML.Probabilistic.Distributions;
using Microsoft.ML.Probabilistic.Models;
using Range = Microsoft.ML.Probabilistic.Models.Range;

namespace MontyHall{
public class Funciones{
  public void basico(int e, int d){
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
  public void monty_hall_con_sesgo_y_varias_pistas(int[] data_eleccion, int[] data_pista){
    InferenceEngine engine = new InferenceEngine();

    Range i = new Range(data_eleccion.Length);
    var probaEsconder = Variable.DirichletUniform(3);
    var regalo =  Variable.Array<int>(i);
    regalo[i] = Variable.Discrete(probaEsconder).ForEach(i);
    var eleccion =  Variable.Array<int>(i);
    eleccion[i] = Variable.DiscreteUniform(3).ForEach(i);
    var pista =  Variable.Array<int>(i);
    for (int j = 0; j < data_eleccion.Length; j++){
    for (int a = 0; a < 3; a++){
      for (int b = 0; b < 3; b++){
        double[] probs = { 1, 1, 1 };
        for (int ps = 0; ps < 3; ps++){
          if (ps == a || ps == b){
            probs[ps] = 0;
          }
        }
        using (Variable.Case(eleccion[j], a)){
          using (Variable.Case(regalo[j], b)){
            pista[j].SetTo(Variable.Discrete(probs));
          }
        }
      }}
    }
    eleccion.ObservedValue = data_eleccion;
    pista.ObservedValue = data_pista;
    Console.WriteLine(" P(sesgo|elecciones,pistas)= "+engine.Infer(probaEsconder));
    Console.WriteLine(" P(regalo|elecciones,pistas)= "+engine.Infer(regalo));
  }
  public void seleccion_monty_hall_con_sesgo_y_varias_pistas(int[] data_eleccion, int[] data_pista){
    // Seleccion de modelo entre monty_hall_con_sesgo_y_varias_pistas y base
  }
  public void monty_hall_con_sesgo_y_varios_regalos_y_pistas(int[] data_regalos, int[] data_eleccion, int[] data_pista)
    // Debido a que cuando sabemos el regalo, no aporta informaciómn saber la pista y la elección, entonces vamos a hacer un ejemplo en el que a veces conocemos el regalo y a veces conocemos la pista y la eleccion.
  }
}

class Program{
  static void Main(string[] args){
    var funciones = new Funciones();
    funciones.basico(0,1);
    funciones.monty_hall_con_sesgo_y_varias_pistas(new int[] {0,0,0,0,0}, new int[] {1,1,1,2,1});
    Console.WriteLine("Chau mundo!");
  }
}

}
