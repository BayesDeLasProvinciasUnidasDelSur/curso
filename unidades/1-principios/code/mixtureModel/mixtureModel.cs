using Microsoft.VisualBasic.FileIO;
using Microsoft.ML.Probabilistic.Algorithms;
using Microsoft.ML.Probabilistic.Distributions;
using Microsoft.ML.Probabilistic.Models;
using Microsoft.ML.Probabilistic.Math;
using Range = Microsoft.ML.Probabilistic.Models.Range;
namespace MixtureModels{
// https://dotnet.github.io/infer/userguide/Mixture%20of%20Gaussians%20tutorial.html
// https://towardsdatascience.com/bayesian-gaussian-mixture-models-without-the-math-using-infer-net-7767bb7494a0#:~:text=Bayesian Gaussian mixture models constitutes,outlier detection, or generative classifiers.
public class Models{
  public void inferir_media_de_una_gaussian(double[] data){
    Range numDataPoints = new Range(data.Length);
    var mean = Variable.GaussianFromMeanAndPrecision(0, 0.01).Named("Mean");
    VariableArray<double> x = Variable.Array<double>(numDataPoints).Named("x");

    x[numDataPoints] = Variable.GaussianFromMeanAndPrecision(mean, 1).ForEach(numDataPoints);

    x.ObservedValue = data;

    var engine1 = new InferenceEngine(new VariationalMessagePassing());
    var engine2 = new InferenceEngine();
    //engine.ShowFactorGraph = true;

    Gaussian postMean1 = engine1.Infer<Gaussian>(mean);
    Gaussian postMean2 = engine2.Infer<Gaussian>(mean);

    Console.WriteLine("P(mean|data)[VMP] = "+postMean1);
    Console.WriteLine("P(mean|data)[] = "+postMean2);
    Console.WriteLine("");
  }
  public void infer_media_y_precision_de_una_gaussiana(double[] data){
    Console.WriteLine("infer_media_y_precision_de_una_gaussiana");

    Range numDataPoints = new Range(data.Length);
    Variable<double> mean = Variable.GaussianFromMeanAndPrecision(0, 0.01).Named("Mean");
    Variable<double> precision = Variable.GammaFromShapeAndRate(2, 1);
    VariableArray<double> x = Variable.Array<double>(numDataPoints).Named("x");

    x[numDataPoints] = Variable.GaussianFromMeanAndPrecision(mean, precision).ForEach(numDataPoints);

    x.ObservedValue = data;

    var engine = new InferenceEngine();
    //engine.ShowFactorGraph = true;

    Gaussian postMean = engine.Infer<Gaussian>(mean);
    Gamma postPrecision = engine.Infer<Gamma>(precision);

    Console.WriteLine("P(mean|data) = "+postMean);
    Console.WriteLine("P(precision|data) = "+postPrecision);

    Console.WriteLine("");
  }
  public void infer_media_y_precision_de_k_gaussiana(double[] dataK, int K){
    Console.WriteLine("infer_media_y_precision_de_k_gaussiana");

    Range numDataPoints = new Range(dataK.Length);
    Range k = new Range(K);

    VariableArray<double> means = Variable.Array<double>(k).Named("Means");
    for (int i = 0; i < K; i++)
      means[i] = Variable.GaussianFromMeanAndPrecision(i, 0.1);

    var engine = new InferenceEngine();
    //engine.Algorithm = new VariationalMessagePassing();
    Gaussian[] postMean = engine.Infer<Gaussian[]>(means);
    for (int i = 0; i < K; i++){
        Console.WriteLine("P(mean{0}|Data) = ", postMean[i]);
    }


    VariableArray<double> precisions = Variable.Array<double>(k).Named("Precisions");
    precisions[k] = Variable.GammaFromShapeAndRate(2, 1).ForEach(k);

    VariableArray<double> x = Variable.Array<double>(numDataPoints).Named("x");

    VariableArray<int> z = Variable.Array<int>(numDataPoints).Named("z");

    using (Variable.ForEach(numDataPoints)){
      z[numDataPoints] = Variable.Discrete(k, new double[] { 1.0/3.0, 1.0/3.0, 1.0/3.0 });

      using (Variable.Switch(z[numDataPoints])){
        x[numDataPoints] = Variable.GaussianFromMeanAndPrecision( means[z[numDataPoints]], precisions[z[numDataPoints]]);
      }
    }

    x.ObservedValue = dataK;


    postMean = engine.Infer<Gaussian[]>(means);
    Gamma[] postPrecision = engine.Infer<Gamma[]>(precisions);
    Discrete[] postZ = engine.Infer<Discrete[]>(z);

    for (int i = 0; i < K; i++){
        Console.WriteLine("P(mean{1}|Data) = {0}", postMean[i],i);
        Console.WriteLine("P(precision{1}|Data = {0}", postPrecision[i],i);
    }
    for (int i = 0; i < 5; i++)
        Console.WriteLine("x = "+dataK[i]+ ": p(z) = "+postZ[i]);

    Console.WriteLine("");
  }
  public void infer_media_precision_y_pesos_de_k_gaussiana(){
    Console.WriteLine("");
  }
  public void seleccion_de_la_complejidad_k_del_modelo(){
    Console.WriteLine("seleccion_de_la_complejidad_k_del_modelo");

    Console.WriteLine("");
  }
}

// class Program{
//   static void Main(string[] args){
//     double[] data1 = {4.97927135527903, 4.59200148907175, 5.186440451964069, 4.799267690885445, 4.44323651636977, 5.516809467200307, 4.878760996592614, 4.733303790317494, 4.819648433009107, 4.75018621913176, 5.047937996897632, 4.394096465840763, 4.877933263872199, 4.717038541890403, 4.932324049872676, 5.137812765262641};
//
//     double[] dataK = {4.97927135527903, 4.59200148907175, 5.186440451964069, 4.799267690885445, 4.44323651636977, 5.516809467200307, 4.878760996592614, 4.733303790317494, 4.819648433009107, 4.75018621913176, 5.047937996897632, 4.394096465840763, 4.877933263872199, 4.717038541890403, 4.932324049872676, 5.137812765262641};
//
//     var modelos = new Models();
//     modelos.inferir_media_de_una_gaussian(data1);
//     modelos.infer_media_y_precision_de_una_gaussiana(data1);
//     Console.WriteLine("Chau mundo!");
//   }
// }
//

public class Funciones{
  public List<double> read_csv(string path){
    List<double> data2 = new List<double>();
    using(var reader = new StreamReader(@path)){
      //List<string> listA = new List<string>();
      while (!reader.EndOfStream){
        var line = reader.ReadLine();
        var values = line.Split('\n');
        data2.Add(Convert.ToDouble(values[0]));
        //listA.Add(values);
      }
    }
    return data2;
  }
}



}
