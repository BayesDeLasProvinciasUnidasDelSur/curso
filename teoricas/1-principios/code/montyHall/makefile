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
