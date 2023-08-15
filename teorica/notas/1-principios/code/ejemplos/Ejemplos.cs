using Microsoft.ML.Probabilistic.Algorithms;
using Microsoft.ML.Probabilistic.Distributions;
using Microsoft.ML.Probabilistic.Models;
using Microsoft.ML.Probabilistic.Math;
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

  public void modelo_con_ruido(bool causaObservada){
    Console.WriteLine("Modelo con ruido");
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
  public void estimacion_de_ruido_simetrico(){
    Console.WriteLine("Estimacion de ruido simétrico");

    bool[] mediciones1 = {true,false,false,true,false};
    bool[] mediciones0 = {false,true,true,false,false};
    bool[] mediciones2 = {false,false,true,false,false};
    Range i = new Range(mediciones1.Length);

    var probabilidad = Variable.Beta(2,10); // La prevalencia
    var ruido1 = Variable.Beta(1,1); // El ruido (sea FalsePositive o TrueNegative)
    var ruido2 = Variable.Beta(2,25); // El ruido (sea FalsePositive o TrueNegative)
    var estado = Variable.Array<bool>(i).Named("Estado");
    estado[i] = Variable.Bernoulli(probabilidad).ForEach(i);
    var resultado1 = Variable.Array<bool>(i).Named("Resultado1");
    var resultado2 = Variable.Array<bool>(i).Named("Resultado2");
    using (Variable.ForEach(i)){
        resultado1[i] = (estado[i] != Variable.Bernoulli(ruido1));
        resultado2[i] = (estado[i] != Variable.Bernoulli(ruido2));
    }

    var engine = new InferenceEngine();

    resultado1.ObservedValue = mediciones1;
    resultado2.ObservedValue = mediciones2;
    Console.WriteLine("  P(ruido1|mediciones) = "+engine.Infer(ruido1));
    Console.WriteLine("  P(ruido2|mediciones) = "+engine.Infer(ruido2));
    Console.WriteLine("  P(estado|mediciones) = "+engine.Infer(estado));
    Console.WriteLine("  P(prev|mediciones) = "+engine.Infer(probabilidad));

  }
  public void seleccion_modelo_causal_mediante_observaciones(){
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
    // ToDo: Porbar Variable<bool>[] para definir observable solo a algunas de las variables.
    A.ObservedValue = dataA;
    B.ObservedValue = dataB;
    Bernoulli AcausesBdist = engine.Infer<Bernoulli>(AcausesB); // Infer posterior
    Console.WriteLine("  P(ModeloAB|Datos) = "+AcausesBdist);
  }

  public void seleccion_de_modelo_causal_mediante_intervenciones(){
    Range N = new Range(8);
    // El espacio de modelos
    var AcausesB = Variable.Bernoulli(0.5);

    // Las variables que comparten ambos modelos
    var A = Variable.Array<bool>(N).Named("A");
    var B = Variable.Array<bool>(N).Named("B");
    var doB = Variable.Array<bool>(N).Named("doB");
    using (Variable.If(AcausesB)){
      // ModeloAB
      using (Variable.ForEach(N)){
        using (Variable.If(doB[N])){
          A[N] = Variable.Bernoulli(0.5);
          B[N] = Variable.Bernoulli(0.5);
        }
        using (Variable.IfNot(doB[N])){
          A[N] = Variable.Bernoulli(0.5);
          B[N] = A[N] != Variable.Bernoulli(0.05);
        }
      }
    }
    using (Variable.IfNot(AcausesB)){
      // ModeloBA
      using (Variable.ForEach(N)){
        using (Variable.If(doB[N])){
          B[N] = Variable.Bernoulli(0.5);
          A[N] = B[N] != Variable.Bernoulli(0.05);
        }
        using (Variable.IfNot(doB[N])){
          B[N] = Variable.Bernoulli(0.5);
          A[N] = Variable.Bernoulli(0.5);
        }
      }
    }
    // Create an inference engine
    var engine = new InferenceEngine();

    bool[] boBdata =   {true, true, true, true, false, false, false, false};
    bool[] dataA = {true, true, false, true, true, false, false, false};
    bool[] dataB = {true, false, true, false, true, false, false, true};
    A.ObservedValue = dataA;
    B.ObservedValue = dataB;
    doB.ObservedValue = boBdata;
    Bernoulli AcausesBdist = engine.Infer<Bernoulli>(AcausesB); // Infer posterior
    Console.WriteLine("  P(ModeloAB|Datos, doB) = "+AcausesBdist);
  }
  public void probabilidad_de_una_moneda(bool[] data){
    Range i = new Range(data.Length);
    Variable<double> probabilidad = Variable.Beta(1, 1);
    var monedas =  Variable.Array<bool>(i);
    monedas[i] = Variable.Bernoulli(probabilidad).ForEach(i);
    monedas.ObservedValue = data;
    var engine = new InferenceEngine();
    Console.WriteLine("  P(probabilidad|Datos) = "+engine.Infer(probabilidad));
  }
  public void probabilidad_de_un_dado(int[] data){
    var engine = new InferenceEngine();
    Range i = new Range(data.Length);
    var probabilidad = Variable.DirichletUniform(6);
    Console.WriteLine("  P(probabilidad) = "+engine.Infer(probabilidad));
    var tiradas =  Variable.Array<int>(i);
    tiradas[i] = Variable.Discrete(probabilidad).ForEach(i);
    tiradas.ObservedValue = data;
    Console.WriteLine("  P(probabilidad|Datos) = "+engine.Infer(probabilidad));
    var lados = Variable.Discrete(probabilidad);
    Console.WriteLine("  P(lados|probabilidad) = "+engine.Infer(lados));
  }
  public void experimento_medico(bool[] control, bool[] tratamiento){
    InferenceEngine engine = new InferenceEngine();
    engine.ModelName = "Experimento médico";
    engine.SaveFactorGraphToFolder = "graphs";
    //engine.ShowFactorGraph = true;

    Range i_c = new Range(control.Length);
    Range i_t = new Range(tratamiento.Length);
    var grupo_control =  Variable.Array<bool>(i_c).Named("Control");
    var grupo_tratado =  Variable.Array<bool>(i_t).Named("Tratado");

    Variable<bool> esEfectivo = Variable.Bernoulli(0.5).Named("Efecto");

    using (Variable.If(esEfectivo)){
      Variable<double> probC = Variable.Beta(1, 1).Named("ProbC");
      grupo_control[i_c] = Variable.Bernoulli(probC).ForEach(i_c);
      Variable<double> probT = Variable.Beta(1, 1).Named("ProbT");
      grupo_tratado[i_t] = Variable.Bernoulli(probT).ForEach(i_t);
    }
    using (Variable.IfNot(esEfectivo)){
      Variable<double> probAll = Variable.Beta(1, 1).Named("ProbAll");
      grupo_control[i_c] = Variable.Bernoulli(probAll).ForEach(i_c);
      grupo_tratado[i_t] = Variable.Bernoulli(probAll).ForEach(i_t);
    }

    grupo_control.ObservedValue = control;
    grupo_tratado.ObservedValue = tratamiento;

    Console.WriteLine("P(esEfectivo|Data) = "+ engine.Infer(esEfectivo));
  }
  public void sorpresa_de_un_dado(int[] data){
    Variable<bool> evidence = Variable.Bernoulli(0.5).Named("evidence");

    IfBlock block = Variable.If(evidence);
    Range i = new Range(data.Length);
    var probabilidad = Variable.DirichletUniform(6);
    var tiradas =  Variable.Array<int>(i);
    tiradas[i] = Variable.Discrete(probabilidad).ForEach(i);
    tiradas.ObservedValue = data;
    block.CloseBlock();

    var engine = new InferenceEngine();
    double logEvidence = engine.Infer<Bernoulli>(evidence).LogOdds;
    Console.WriteLine("  P(Datos)"+Math.Exp(logEvidence/data.Length));
  }
  //public void probabilidad_de_un_dado_en_el_tiempo(int[] data){
    // Vamos a hacer un modelo que estime una probabilidad del dado que cambia en el tiempo.
  //}
}





}
