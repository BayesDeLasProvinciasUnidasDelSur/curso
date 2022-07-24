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

function mass_change(m=33.3;a=0.28, M = 442.0)
    return (a*m^(3/4))* (1- ((m/M)^(1/4)) )
end

function sigmoidal(t, m0=33.3, M=442.0, a=0.28)
    # see west2001-ontogeneticGrowth
    return (1-(1-(m0/M)^(1/4))*exp(-a*t/(4*M^(1/4))))
end

plot(cumsum(mass_change.(34:441)))
plot(sigmoidal.(1:2500))
plot(sigmoidal.(2:10001)-sigmoidal.(1:10000)
