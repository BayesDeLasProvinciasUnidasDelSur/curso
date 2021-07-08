using Plots
using Random

budget = [0.0]
# Las puestas del reverdo Bayes # ToDo: pensarlo con Kelly también 
odd1 = 1/(2/3)
odd2 = 1/(1/3)
for i in 1:100000
    r = rand(1:3)
    if r != 3 
        push!(budget, budget[end] + odd1 - 1)
    else
        push!(budget, budget[end] - 1)
    end
end
plot(budget)

CAMBIAR = 2/3
TOLERENCIA = 1e-20

function vida(cambiar=CAMBIAR, tolerancia=TOLERENCIA)
    # Cerradura en 2
    # Pista en 1
    # Le quedan dos puertas
    creencia = [1.0]
    i = 0
    while creencia[end] > tolerancia
        i = i + 1
        regalo_en = rand(1:3)
        if regalo_en != 2
            push!(creencia, creencia[end]*(cambiar) )
        else
            push!(creencia, creencia[end]*(1-cambiar) )
        end
    end
    return (creencia, i)
end

function expectativa_de_vida(n,cambiar=CAMBIAR, tolerancia=TOLERENCIA)
    res = []
    for _ in 1:n
        push!(res, vida(cambiar,tolerancia)[2])
    end
    return sum(res)/n
end

rencarnaciones = 10000
expectativa_de_vida(1, 1/2)
expectativa_de_vida(rencarnaciones , 2/3)
expectativa_de_vida(rencarnaciones , 1.0)
expectativa_de_vida(rencarnaciones , 0.0)


