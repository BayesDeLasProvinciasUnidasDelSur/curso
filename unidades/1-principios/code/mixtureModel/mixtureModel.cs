using Microsoft.VisualBasic.FileIO;
using Microsoft.ML.Probabilistic.Algorithms;
using Microsoft.ML.Probabilistic.Distributions;
using Microsoft.ML.Probabilistic.Models;
using Range = Microsoft.ML.Probabilistic.Models.Range;
namespace MixtureModels{
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
  public void infer_media_y_precision_de_k_gaussiana(){
    Console.WriteLine("");
  }
  public void infer_media_precision_y_pesos_de_k_gaussiana(){
    Console.WriteLine("");
  }
  public void seleccion_de_la_complejidad_k_del_modelo(){
    Console.WriteLine("");
  }
}

class Program{
  static void Main(string[] args){
    double[] data1 = {4.97927135527903, 4.59200148907175, 5.186440451964069, 4.799267690885445, 4.44323651636977, 5.516809467200307, 4.878760996592614, 4.733303790317494, 4.819648433009107, 4.75018621913176, 5.047937996897632, 4.394096465840763, 4.877933263872199, 4.717038541890403, 4.932324049872676, 5.137812765262641};

    double[] dataK = {4.97927135527903, 4.59200148907175, 5.186440451964069, 4.799267690885445, 4.44323651636977, 5.516809467200307, 4.878760996592614, 4.733303790317494, 4.819648433009107, 4.75018621913176, 5.047937996897632, 4.394096465840763, 4.877933263872199, 4.717038541890403, 4.932324049872676, 5.137812765262641};

    var modelos = new Models();
    modelos.inferir_media_de_una_gaussian(data1);
    modelos.infer_media_y_precision_de_una_gaussiana(data1);
    Console.WriteLine("Chau mundo!");
  }
}



}
