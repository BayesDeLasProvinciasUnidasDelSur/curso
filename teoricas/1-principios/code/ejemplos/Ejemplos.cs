using Microsoft.ML.Probabilistic.Algorithms;
using Microsoft.ML.Probabilistic.Distributions;
using Microsoft.ML.Probabilistic.Models;
using Range = Microsoft.ML.Probabilistic.Models.Range;
namespace Ejemplos{

public class Simples{
  public void logica_con_incertidumbre(){
    Console.WriteLine("Lógica con incertidumbre");
    // Modelo
    Variable<bool> firstCoin = Variable.Bernoulli(0.5);
    Variable<bool> secondCoin = Variable.Bernoulli(0.5);
    Variable<bool> dosCaras = firstCoin & secondCoin;
    Variable<bool> algunaCara = firstCoin | secondCoin;

    // El sistema de inferencia
    InferenceEngine engine = new InferenceEngine();

    // Prior de la variable co-causada
    Console.WriteLine("  Prior de dosCaras: "+engine.Infer(dosCaras));
    Console.WriteLine("  Prior de algunaCara: "+engine.Infer(algunaCara));

    // Posterior de la variable co-causada
    firstCoin.ObservedValue = true;
    Console.WriteLine("  Posterior de dosCaras: "+engine.Infer(dosCaras));
    Console.WriteLine("  Posterior de algunaCara: "+engine.Infer(algunaCara));
  }

  public void modelo_causal_con_ruido(bool causaObservada){
    Console.WriteLine("Modelo causal con ruido");
    var causa = Variable.Bernoulli(0.5);
    var efecto = (causa != Variable.Bernoulli(0.05));
    InferenceEngine engine = new InferenceEngine();
    if(causaObservada){
      causa.ObservedValue = true;
      Console.WriteLine("  P(Efecto|Causa = 1) = "+engine.Infer(efecto));
     }
     else{
       efecto.ObservedValue = true;
       Console.WriteLine("  P(Causa|Efecto = 1) = "+engine.Infer(causa));
     }
  }
  public void seleccion_observacional_de_modelo_causal(){
    Console.WriteLine("Selección observacional de modelo causal");
    Range N = new Range(5);
    // El espacio de modelos
    var AcausesB = Variable.Bernoulli(0.5);

    // Las variables que comparten ambos modelos
    var A = Variable.Array<bool>(N).Named("A");
    var B = Variable.Array<bool>(N).Named("B");
    using (Variable.If(AcausesB)){
      // ModeloAB
      using (Variable.ForEach(N)){
        A[N] = Variable.Bernoulli(0.5);
        B[N] = A[N] != Variable.Bernoulli(0.05);
      }
    }
    using (Variable.IfNot(AcausesB)){
      // ModeloBA
      using (Variable.ForEach(N)){
        B[N] = Variable.Bernoulli(0.5);
        A[N] = B[N] != Variable.Bernoulli(0.05);
      }
    }
    // Create an inference engine
    var engine = new InferenceEngine();

    bool[] dataA = {true, true, false, true, true};
    bool[] dataB = {true, true, false, true, false};
    A.ObservedValue = dataB;
    B.ObservedValue = dataB;
    Bernoulli AcausesBdist = engine.Infer<Bernoulli>(AcausesB); // Infer posterior
    Console.WriteLine("  P(ModeloAB|Datos) = "+AcausesBdist);
  }
}





class Program{
  static void Main(string[] args){
    var simples = new Simples();
    simples.modelo_causal_con_ruido(true);
    simples.modelo_causal_con_ruido(false);
    simples.seleccion_observacional_de_modelo_causal();
    Console.WriteLine("Chau mundo!");
  }
}





}
