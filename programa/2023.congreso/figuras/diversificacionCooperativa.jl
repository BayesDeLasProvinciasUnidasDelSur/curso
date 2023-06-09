using Plots
using Random
using Statistics
using Distributions


function coin(p=0.71, n=1)
    rand(Binomial(n,p))
end

ps = [0.2, 0.5, 0.8]
caras = 3.0.*ps
secas = 1.2.*(1.0.-ps)

function r_caso_general_con_nInf(h::Float64,Qc=3.0, Qs=1.2, p1=0.2, p2=0.6)
    r1 =  h * (1-p1) * Qs + (1-h) * p2 * Qc
    r2 =  h * p2 * Qc + (1-h) * (1-p1) * Qs
    return r1^(1/2)*r2^(1/2)
end

function grilla_de_heterogeneidades()
    rs = []
    h = 0.0
    hs = []
    while h <= 1.0+0.0001
        push!(rs,r_caso_general_con_nInf(h))
        push!(hs,h)
        h = h + 0.01
    end
    return (hs, rs)
end

hs, rs = grilla_de_heterogeneidades()

fig= plot(hs,rs, xlab="h: Proporción en hemisferio A", ylab="r: tasa de crecimiento", legend=(0.15,1.0), thickness_scaling = 1.5, label=false, grid=false, foreground_color_legend = nothing)
savefig(fig, "pdf/diversificacionCooperativa.pdf")
run(`pdfcrop --margins '0 0 0 0' pdf/diversificacionCooperativa.pdf pdf/diversificacionCooperativa.pdf`)


