using Random
using Plots

delta_expected = 1.5*0.5+0.6*0.5 - 1 # <\Delta x>
time_average = log(1.5)*0.5+log(0.6)*0.5 # <\Delta ln x>
    

function game(n=100,d=1,t=1000)
    res = zeros((n,t+1))
    res[:,1] .= 1.0
    for i in 2:(t+1)#i=2
        cpr = sum(res[1:(n-d),i-1])/n
        for a in 1:n
            if rand([0,1]) == 0
                res[a,i] = a<=(n-d) ? cpr*1.5 : (cpr+res[a,i-1])*1.5
            else
                res[a,i] = a<=(n-d) ? cpr*0.6 : (cpr+res[a,i-1])*0.6
            end
        end
    end
    return res
end

h=game(33,33,2000)
ylim = (log(minimum(h)),log((1+delta_expected)^2000))

p = plot(log.(transpose(h)),legend = false, thickness_scaling = 1.5, grid=false,  ylim = ylim)
plot!([1,2000],log.([1.0,(1+delta_expected)^2000 ]), color="black")
plot!([1,2000],log.([1.0,(1+time_average)^2000]), color="black")

savefig(p, "cpr_individual.pdf") 

p = plot(log.(transpose(game(100,0,2000))),legend = false, color="green", thickness_scaling = 1.5, grid=false, ylim = ylim)
plot!(log.(transpose(game(100,1,2000))),legend = false, color="blue")
plot!(log.(transpose(game(100,10,2000))),legend = false, color="red")
#plot!([1,2000],log.([1.0,(1+delta_expected)^2000 ]), color="black")
#plot!([1,2000],log.([1.0,(1+time_average)^2000]), color="black")

savefig(p, "cpr_cooperation.pdf") 

#######################

# Normalizaci'on


function normalization(h)
    res = zeros(size(h))
    for c in 1:size(res)[2]
        base = sum(h[:,c])
        for r in 1:size(res)[1]
            res[r,c] = h[r,c]/base
        end
    end
    return res
end

h = game(10,0,1000)
plot(transpose(normalization(h)),legend=false)

h = game(100,1,2000)
plot(transpose(normalization(h)),legend=false)

h = game(100,10,2000)
plot(transpose(normalization(h)),legend=false)

h = game(100,100,10000)
plot(transpose(normalization(h)),legend=false)

#######################

# Algoritmo evolutivo



#######################

# sigmoidea

#######################

# west2001-ontogeneticGrowth
# A general model for ontogenetic growth

# Ontogenetic development is fuelled by metabolism and occurs primarily by cell division.
# The rate of energy transformation is the sum of two terms, one of which represents the maintenance of existing tissue, and the other, the creation of new tissue.

function ontogeneticGrowth(t, m0=0.001,a=0.08, M = 1000.1)
    return (1 - (1 - ( (m0/M)^(1/4) ))*exp(-(a*t)/(4*M^(1/4))))^4
end

plot(ontogeneticGrowth.(1:2000),legend=false)


function explotacion(n, t0=2000)
    
end
