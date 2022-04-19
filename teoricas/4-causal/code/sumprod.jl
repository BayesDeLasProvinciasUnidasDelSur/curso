using Test

# Entradera
pe = [0.999 0.001]
# Entradera
pt = [0.992 0.008]
# Redes
pr_t = [ [0.99 0.01] 
         [0.01 0.99] ]
# Alarma
pa_et= zeros(Float64,(2,2,2))
pa_et[:,1,1] = [0.99 0.01] 
pa_et[:,2,1] = [0.01 0.99] 
pa_et[:,1,2] = [0.01 0.99] 
pa_et[:,2,2] = [0.0001 0.9999] 
# Llamada
pl_a = [ [0.99 0.01] 
         [0.01 0.99] ]

ne = 2; nt = 2; na = 2; nr = 2; nl = 2

function pr(r)
    res = 0.0
    for t in 1:nt
        res += pt[t]*pr_t[r,t]
    end
    return res
end

function pa(a)
    res = 0.0
    for e in 1:ne
        for t in 1:nt
            res += pe[e]*pt[t]*pa_et[a,e,t]
    end end
    return res
end

@test pa(2) ≈ 0.018812239
@test pa(2)*365 ≈ 6.8664673

function pl(l)
    res = 0.0
    for a in 1:na
        res += pa(a)*pl_a[l,a]
    end
    return res
end

@test pl(2)*365 ≈ 10.3791379



function pae(a,e)
    res = 0.0
    for t in 1:nt
        res += pe[e]*pt[t]*pa_et[a,e,t]
    end
    return res
end

function ple(l,e)
    res = 0.0
    for a in 1:na
        res += pae(a,e)*pl_a[l,a]
    end
    return res
end

function pl_e(l,e)
    return ple(l,e)/pe[e]
end

@test pl(2) ≈ 0.0284359944 # que llamen
@test pl_e(2,2) ≈ 0.980277615 # que llamen cuando entran


function plae(l,a,e)
    return pae(a,e)*pl_a[l,a]
end

function pl_ae(l,a,e)
    return plae(l,a,e)/pae(a,e)
end

pl_a[2,2]
pl_ae(2,2,2)


function pa_e(a,e)
    res = 0.0
    for t in 1:nt
        res += pt[t]*pa_et[a,e,t]
    end
    return res
end

function pl_e(l,e)
    res = 0.0
    for a in 1:na
        res += pa_e(a,e)*pl_a[l,a]
    end
    return res
end

function ptl(t,l)
    res = 0.0
    for e in 1:ne
        for a in 1:na
            res += pe[e]*pa_et[a,e,t]*pl_a[l,a] 
    end end
    return pt[t]*res
end

function pt_l(t,l)
    return ptl(t,l)/pl(l)
end

@test pt_l(2,2) ≈ 0.2757659
@test pt[2] ≈ 0.008

function pra(r,a)
    res = 0.0
    for e in 1:ne
        for t in 1:nt
            res += pe[e]*pt[t]*pa_et[a,e,t]*pr_t[r,t]
    end end
    return res
end

function pr_a(r,a)
    return pra(r,a)/pa(a)
end

@test pr_a(2,2) ≈ 0.422586589
@test pr(2) ≈ 0.01784

function pta(t,a)
    res = 0.0
    for e in 1:ne
        res += pe[e]*pt[t]*pa_et[a,e,t]
    end
    return res
end

function pt_a(t,a)
    return pta(t,a)/pa(a)
end

function pea(e,a)
    res = 0.0
    for t in 1:nt
        res += pe[e]*pt[t]*pa_et[a,e,t]
    end
    return res
end

function peta(e,t,a)
    return pe[e]*pt[t]*pa_et[a,e,t]
end

function pt_ea(t,e,a)
    return peta(e,t,a)/pea(e,a)
end

@test pt_a(2,2) ≈ 0.42100672
@test pt_ea(2,2,2) ≈ 0.0080793536

function ptel(t,e,l)
    res = 0.0
    for a in 1:na
        res += pe[e]*pt[t]*pa_et[a,e,t]*pl_a[l,a]
    end
    return res
end

function pel(e,l)
    res = 0.0
    for t in 1:nt
        for a in 1:na
            res += pe[e]*pt[t]*pa_et[a,e,t]*pl_a[l,a]
    end end
    return res
end

function pt_el(t,e,l)
    return ptel(t,e,l)/pel(e,l)
end

@test pt_l(2,2) ≈ 0.2757659
@test pt_el(2,2,2) ≈ 0.0080785441
