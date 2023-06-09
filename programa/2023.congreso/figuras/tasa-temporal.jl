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

function coop_fitness(e,c,r,N;Qc=1,Qs=1)
    return ((c-r)/N)*(1-e)*Qs +(r/N)*e*Qc
end
function coop_temporal_average(n, e, ambiente, N; Qc=1, Qs=1)
    res = 1.0
    p_fitness = pdf(Binomial(n,ambiente))
    for r in 0:n#r=0
        res *= coop_fitness(e,n,r,N, Qc = Qc, Qs = Qs)^p_fitness[r+1]
    end
    return res
end

coop_temporal_average(5, 0.99,0.5,5,Qc=3.0, Qs = 1.2)

Q_c=3.0
Q_s=1.2

# fig = plot(e, ((0.5*Q_c).^e).*((0.5*Q_s).^(1.0.-e)),label="0.50", xlab="p: frecuencia típica", ylab="r: tasa de crecimiento", legend=(0.15,0.9), thickness_scaling = 1.5, grid=false, foreground_color_legend = nothing)
# plot!(e, ((0.71*Q_c).^e).*((0.29*Q_s).^(1.0.-e)),label="0.71",color=2)
# plot!(e, ((0.99*Q_c).^e).*((0.01*Q_s).^(1.0.-e)),label="0.99",color=3)
#  # <\Delta x>
# plot!(e, 0.5.*e.*Q_c.+0.5.*(1.0.-e).*Q_s, label=false, line=:dot, color=1)
# plot!(e, 0.71.*e.*Q_c.+0.29.*(1.0.-e).*Q_s, label=false, line=:dot, color=2)
# plot!(e, 0.99.*e.*Q_c.+0.01.*(1.0.-e).*Q_c, label=false, line=:dot, color=3)
# # Analisis
# plot!([0.5,0.5], [((0.5*Q_c)^0.5)*((0.5*Q_s)^0.5),Q_c*0.5*0.5+Q_s*0.5*0.5], color="black", line=:arrow, label=false)
#
#
# plot!([0.5, 0.5], [0.0, 3.0], label=false, line=:dot, color="black")
# plot!([0.0, 1.0], [1.0, 1.0], label=false, color="gray", alpha=0.2)
#
#
# savefig(fig, "pdf/tasa-temporal-0.pdf")
# savefig(fig, "png/tasa-temporal-0.png")
#
# fig = plot(e, ((0.5*Q_c).^e).*((0.5*Q_s).^(1.0.-e)), xlab="p: frecuencia típica", ylab="r: tasa de crecimiento", legend=(0.15,0.9), thickness_scaling = 1.5, grid=false, foreground_color_legend = nothing, color="gray", alpha=0.5,label=false)
# plot!(e, ((0.71*Q_c).^e).*((0.29*Q_s).^(1.0.-e)),color="gray", alpha=0.5,label=false)
# plot!(e, 0.5.*e.*Q_c.+0.5.*(1.0.-e).*Q_s, label=false, line=:dot, color="gray", alpha=0.5)
# plot!(e, 0.71.*e.*Q_c.+0.29.*(1.0.-e).*Q_s, label=false, line=:dot, color="gray", alpha=0.5)
# aN = zeros(Float64,(N,length(e)))
# for i in 1:N
#     aN[i,:] .= coop_temporal_average.(i,0.99,e,i,Qc=3.0,Qs=1.2)
# end
# plot!(e,aN[1,:], label="1", color=1)
# plot!(e,aN[2,:], label="2", color=2)
# plot!(e,aN[3,:], label="3", color=3)
# plot!(e,aN[4,:], label="4", color=4)
# plot!(e,aN[5,:], label="5", color=5)
# #plot!(e,aN[7,:], color=3, label=false)
# #plot!(e,aN[8,:], color=3, label=false)
# #plot!(e,aN[9,:], color=3, label=false)
# #plot!(e,aN[10,:], color=3, label=false)
#
# plot!([0.71, 0.71], [0.0, 3.0], label=false, line=:dot, color="black")
# plot!([0.0, 1.0], [1.0, 1.0], label=false, color="gray", alpha=0.2)
#
# savefig(fig, "pdf/tasa-temporal-1.pdf")
# savefig(fig, "png/tasa-temporal-1.png")

eN = zeros(Float64,(N,length(e)))
for i in 1:N
    eN[i,:] .= coop_temporal_average.(i,e,0.5,i; Qc=3.0, Qs=1.2)
end
fig= plot(e,eN[1,:], xlab="b: apuesta", ylab="r: tasa de crecimiento", legend=(0.15,1.0), thickness_scaling = 1.5, label="1", grid=false, foreground_color_legend = nothing)
plot!([0.5,0.5],[0.0,maximum(eN)], color="black", line=:dash, label=false)
plot!(e,eN[2,:], color=2, label="2")
plot!(e,eN[3,:], color=3, label="3")
plot!(e,eN[4,:], color=4, label="4")
plot!(e,eN[5,:], color=5, label="5")
scatter!([e[argmax(eN[1,:])]],[eN[1,argmax(eN[1,:])]], color=1, label=false)
scatter!([e[argmax(eN[2,:])]],[eN[2,argmax(eN[2,:])]], color=2, label=false)
scatter!([e[argmax(eN[3,:])]],[eN[3,argmax(eN[3,:])]], color=3, label=false)
scatter!([e[argmax(eN[4,:])]],[eN[4,argmax(eN[4,:])]], color=4, label=false)
scatter!([e[argmax(eN[5,:])]],[eN[5,argmax(eN[5,:])]], color=5, label=false)
savefig(fig, "pdf/tasa-temporal-2.pdf")
#savefig(fig, "png/tasa-temporal-2.png")
run(`pdfcrop --margins '0 0 0 0' pdf/tasa-temporal-2.pdf pdf/tasa-temporal-2.pdf`)



