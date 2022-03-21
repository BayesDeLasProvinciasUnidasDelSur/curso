using Plots
using Random
using Statistics
using Distributions
using LinearAlgebra
using Documenter

function coin(p=0.71, n=1)
    rand(Binomial(n,p))
end

A = 0.71 # ambiente
N = 10 # 
ns = [i for i in 1:N] 
e = [i for i in 0.0:0.0001:1.0] # estrategias (a veces ambiente)

function coop_fitness(e,c,r,N)
    return ((c-r)/N)*(1-e)+(r/N)*e
end
function coop_temporal_average(n, e, ambiente, N)
    res = 1.0
    p_fitness = pdf(Binomial(n,ambiente))
    for r in 0:n#r=0
        res *= coop_fitness(e,n,r,N)^p_fitness[r+1]
    end
    return res
end

fig = plot(e, 0.99.*e.+0.01*(1.0.-e),label=false, xlab="Environment", ylab="Growth rate", legend=(0.15,0.99), thickness_scaling = 2.0, grid=false, foreground_color_legend = nothing, linewidth=2, legendtitle = "Strategy", legendtitlefontsize = 10,background_color_legend = nothing, color="white")
plot!(e, (0.5.^e).*(0.5.^(1.0.-e)),label="0.50", linewidth=2, color=1)
 # <\Delta x>
savefig(fig, "pdf/tasa-temporal-0-a.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/tasa-temporal-0-a.pdf pdf/tasa-temporal-0-a.pdf`) 
plot!(e, (0.71.^e).*(0.29.^(1.0.-e)),label="0.71", linewidth=2, color=2)
savefig(fig, "pdf/tasa-temporal-0-b1.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/tasa-temporal-0-b1.pdf pdf/tasa-temporal-0-b1.pdf`) 
plot!(e, 0.71.*e.+0.29*(1.0.-e), label=false, line=:dot, color=2, linewidth=2) 
savefig(fig, "pdf/tasa-temporal-0-b.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/tasa-temporal-0-b.pdf pdf/tasa-temporal-0-b.pdf`) 
plot!(e, (0.99.^e).*(0.01.^(1.0.-e)),label="0.99", linewidth=2, color=3)
plot!(e, 0.99.*e.+0.01*(1.0.-e), label=false, line=:dot, color=3, linewidth=2)
# Analisis
#plot!([0.5,0.5], [(0.71^0.5)*(0.29^0.5),0.71*0.5+0.29*0.5], color="black", line=:arrow, label=false, linewidth=2)
savefig(fig, "pdf/tasa-temporal-0.pdf")
savefig(fig, "png/tasa-temporal-0.png")
run(`pdfcrop --margins '0 0 0 0' pdf/tasa-temporal-0.pdf pdf/tasa-temporal-0.pdf`) 

fig = plot(e, (0.5.^e).*(0.5.^(1.0.-e)),label=false, xlab="Environment", ylab="Frowth rate", legend=(0.15,0.9), thickness_scaling = 2.0, grid=false, foreground_color_legend = nothing, color="gray", alpha=0.5, linewidth=2 )
plot!(e, (0.71.^e).*(0.29.^(1.0.-e)),label=false, color="gray", alpha=0.5)
scatter!([0.71],[0.71^0.71*0.29^0.29], color="gray",label=false , markersize=5)
plot!(e, (0.99.^e).*(0.01.^(1.0.-e)),label=false, color="gray", alpha=0.5, linewidth=2)
 # <\Delta x>
plot!(e, 0.71.*e.+0.29*(1.0.-e), label=false, line=:dot, color="gray", alpha=0.5, linewidth=2)

aN = zeros(Float64,(N,length(e)))
for i in 1:N
    aN[i,:] .= coop_temporal_average.(i,0.99,e,i)
end
plot!(e,aN[1,:], label="1", color=1)
plot!(e,aN[2,:], label="2", color=2)
plot!(e,aN[3,:], label="3", color=3)
plot!(e,aN[4,:], label="4", color=4)
plot!(e,aN[5,:], label="5", color=5)
#plot!(e,aN[7,:], color=3, label=false)
#plot!(e,aN[8,:], color=3, label=false)
#plot!(e,aN[9,:], color=3, label=false)
#plot!(e,aN[10,:], color=3, label=false)
plot!(e, 0.99.*e.+0.01*(1.0.-e), label=false, line=:dot, color="black")
savefig(fig, "pdf/tasa-temporal-1.pdf")
savefig(fig, "png/tasa-temporal-1.png")
run(`pdfcrop --margins '0 0 0 0' pdf/tasa-temporal-1.pdf pdf/tasa-temporal-1.pdf`) 


eN = zeros(Float64,(N,length(e)))
for i in 1:N
    eN[i,:] .= coop_temporal_average.(i,e,0.71,i)
end
fig= plot(e,eN[1,:], xlab="Strategy", legend=(0.15,1.0), thickness_scaling = 2.0, label="1", grid=false, foreground_color_legend = nothing, linewidth=2.0, color=4)
plot!([0.71,0.71],[0.0,maximum(eN)], color="black", line=:dash, label=false, linewidth=2, legendtitle =  "Group size", legendtitlefontsize =10,background_color_legend = nothing)
scatter!([e[argmax(eN[1,:])]],[eN[1,argmax(eN[1,:])]], color=4, label=false, markersize=5)
savefig(fig, "pdf/tasa-temporal-2-a.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/tasa-temporal-2-a.pdf pdf/tasa-temporal-2-a.pdf`) 
plot!(e,eN[2,:], color=5, label="2", linewidth=2)
scatter!([e[argmax(eN[2,:])]],[eN[2,argmax(eN[2,:])]], color=5, label=false, markersize=5)
savefig(fig, "pdf/tasa-temporal-2-b.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/tasa-temporal-2-b.pdf pdf/tasa-temporal-2-b.pdf`) 
plot!(e,eN[3,:], color=6, label="3", linewidth=2)
scatter!([e[argmax(eN[3,:])]],[eN[3,argmax(eN[3,:])]], color=6, label=false, markersize=5)
savefig(fig, "pdf/tasa-temporal-2.pdf")
savefig(fig, "png/tasa-temporal-2.png")
run(`pdfcrop --margins '0 0 0 0' pdf/tasa-temporal-2.pdf pdf/tasa-temporal-2.pdf`) 



