using MixtureModels;
using System.IO;

var fun = new MixtureModels.Funciones();

double[] data1 = fun.read_csv("data/data1.csv").ToArray();
double[] dataK = fun.read_csv("data/dataK.csv").ToArray();

var modelos = new MixtureModels.Models();
modelos.inferir_media_de_una_gaussian(data1);
modelos.infer_media_y_precision_de_una_gaussiana(data1);
modelos.infer_media_y_precision_de_k_gaussiana(dataK, 3);
Console.WriteLine("Chau mundo!");

