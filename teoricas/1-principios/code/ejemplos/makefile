all: obj/forense.csproj.nuget.dgspec.json
	@echo "El proyecto ya está creado"
	@echo "Correlo con: "
	@echo "  - 'dotnet run'"


obj/forense.csproj.nuget.dgspec.json:
	dotnet new console
	dotnet add package Microsoft.ML.Probabilistic
	dotnet add package Microsoft.ML.Probabilistic.Compiler
	dotnet add package Microsoft.ML.Probabilistic.Learners
	touch .gitignore
	echo bin/ > .gitignore
	echo obj/ >> .gitignore
	echo GeneratedSource/ >> .gitignore
	echo 'using Microsoft.ML.Probabilistic.Algorithms;' > Program.cs
	echo 'using Microsoft.ML.Probabilistic.Distributions;' >> Program.cs
	echo 'using Microsoft.ML.Probabilistic.Models;' >> Program.cs
	echo 'using Range = Microsoft.ML.Probabilistic.Models.Range;' >>  Program.cs
	echo 'Console.WriteLine("Chau mundo!");' >> Program.cs
	mv Program.cs Ejemplos.cs


