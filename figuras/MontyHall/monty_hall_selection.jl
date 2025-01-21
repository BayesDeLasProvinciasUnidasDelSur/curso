using Plots
using Random

Random.seed!(0)

prior = 1/2
datos = [ rand(1:3) == 1 ? 0 : 1  for i in 1:16]
predicciones_A = [ (1/3)^(1-d) * (2/3)^d  for d in datos ] .*(1/2)
predicciones_B = [ 1/2  for d in datos ] .*(1/3)

evidencia_A = cumprod(predicciones_A )
evidencia_B = cumprod(predicciones_B )

p_datos = evidencia_A.*prior .+ evidencia_B.*prior
p_modelo_A = evidencia_A .* prior ./ p_datos 

p = plot([0.5; p_modelo_A], ylim=[0,1], ylab="P(Modelo | Datos)", xlab="Cantidad de datos"  ,thickness_scaling = 1.5, grid=false,  legend=false)
plot!(1.0.-[0.5; p_modelo_A])

savefig(p, "monty_hall_selection.pdf") 

