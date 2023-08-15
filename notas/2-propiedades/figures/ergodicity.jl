using Plots
using Random
using Statistics
using Distributions
using LinearAlgebra

function r(p=0.5)
    rand(Binomial(1,p))
end

function f(r)
    return r==0 ? 1.5 : 0.6
end


function game(n=100,d=1,t=1000, seed=1; costo = 0.0, reproduccion = 0.5, muerte = 0.4)#evolutivo=true
    Random.seed!(seed)
    res = zeros((n,t+1))
    res[:,1] .= 1.0
    i=2
    while i <= t+1
        cpr = (sum(res[1:(n-d),i-1].*(1-costo))/n)        
        for a in 1:n#a=1
            r = rand([0,1])
            rate = r==0 ? (1+reproduccion) : (1-muerte)
            res[a,i] = a<=(n-d) ? cpr*rate : (cpr+res[a,i-1])*rate
        end
        i = i +1 
    end
    return res
end


ensamble_average = 1.5*0.5+0.6*0.5 
time_average = exp(log(1.5)*0.5+log(0.6)*0.5)

N = 33
T = 2000

e = zeros((T,N))
for i in 1:N
    e[:,i] .= cumsum(log.([ f(r()) for i in 1:T]))
end

fig = plot(e, label=false, thickness_scaling = 2.0, grid=false, xlab="Time")
plot!([1,2000],[0,T*log(ensamble_average )], color="black", label=false, linewidth=2)
#plot!([1,2000],[0,T*log(time_average )], color="black", label=false)
savefig(fig, "pdf/ergodicity_individual_trayectories.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/ergodicity_individual_trayectories.pdf pdf/ergodicity_individual_trayectories.pdf`) 


fig = plot(e, label=false, thickness_scaling = 2.0, grid=false, xlab="Time", ylab="log(Resources)")
plot!([1,2000],[0,T*log(ensamble_average )], color="black", label=false, linewidth=2)
#plot!([1,2000],[0,T*log(time_average )], color="black", label=false)
savefig(fig, "pdf/ergodicity_individual_trayectories_y.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/ergodicity_individual_trayectories_y.pdf pdf/ergodicity_individual_trayectories_y.pdf`) 

N = 1
T = 1000000

e = zeros((T,N))
for i in 1:N
    e[:,i] .= cumsum(log.([ f(r()) for i in 1:T]))
end

fig = plot([1,T],[0,T*log(ensamble_average )], color="black", label=false, thickness_scaling = 2.0, grid=false, xlab="Time", ylab="log(Resources) ")
plot!([1,T],[0,T*log(time_average )], color=1, label=false)
#plot!(e, label=false, color=1)
savefig(fig, "pdf/ergodicity_individual_trayectories_longrun.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/ergodicity_individual_trayectories_longrun.pdf pdf/ergodicity_individual_trayectories_longrun.pdf`) 

Random.seed!(2)
N = 10000
T = 10

e = zeros((T+1,N))
for i in 1:N
    e[:,i] .= [[1]; cumprod([ f(r()) for i in 1:T])]
end

fig = plot(log.(e[:,1]), thickness_scaling = 2.0, grid=false, xlab="Time", ylab="log(Resources) ", label="10^0", legend=(0.15,0.9), foreground_color_legend = nothing, linewidth=2, background_color_legend = nothing )
plot!(1:T+1,log.([mean(e[t,1:(10^1)]) for t in 1:T+1]), linewidth=2, label="10^1")
plot!(1:T+1,log.([mean(e[t,1:(10^2)]) for t in 1:T+1]), linewidth=2, label="10^2")
#plot!(1:T+1,log.([mean(e[t,1:(10^3)]) for t in 1:T+1]), linewidth=2, label="10^3")
plot!(1:T+1,log.([mean(e[t,1:(10^4)]) for t in 1:T+1]), label="10^4", color="black", linewidth=2)
savefig(fig, "pdf/ergodicity_expectedValue.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/ergodicity_expectedValue.pdf pdf/ergodicity_expectedValue.pdf`) 


coop = game(100,0)[1,:]
fig=plot([1,1001], [0, 1001*log(time_average)], label=false, thickness_scaling = 2.0, grid=false, xlab="Time", ylab="log(Resources) ")
plot!([1,1001], [0, 1001*log(ensamble_average)], label=false, color="black")
plot!(log.(coop), label=false, color=3)
savefig(fig, "pdf/ergodicity_cooperation.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/ergodicity_cooperation.pdf pdf/ergodicity_cooperation.pdf`) 


coop0 = game(100,0)
coop1 = game(100,1)
coop2 = game(100,2)
fig = plot(log.(transpose(coop0[end:end,:])), color=3, thickness_scaling = 2.0, grid=false, xlab="Time", ylab="log(Resources) ", label="0 Defectors", legend=(0.15,0.9), foreground_color_legend = nothing, linewidth=2)
plot!([1,1000],[0,1000*log(ensamble_average )], color="black", label=false, linewidth=1)
savefig(fig, "pdf/ergodicity_desertion0.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/ergodicity_desertion0.pdf pdf/ergodicity_desertion0.pdf`) 
plot!(log.(transpose(coop1[end:end,:])), color=1, label=false)
plot!(log.(transpose(coop1[1:1,:])), color=1, label="1 Defectors", linewidth=2)
plot!([1,1000],[0,1000*log(ensamble_average )], color="black", label=false, linewidth=1)
savefig(fig, "pdf/ergodicity_desertion1.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/ergodicity_desertion1.pdf pdf/ergodicity_desertion1.pdf`) 
plot!(log.(transpose(coop2[end-1:end,:])), color=2, label=false)
plot!(log.(transpose(coop2[1:1,:])), color=2, label="2 Defectors", linewidth=2)
plot!([1,1000],[0,1000*log(ensamble_average )], color="black", label=false, linewidth=1)
savefig(fig, "pdf/ergodicity_desertion.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/ergodicity_desertion.pdf pdf/ergodicity_desertion.pdf`) 

