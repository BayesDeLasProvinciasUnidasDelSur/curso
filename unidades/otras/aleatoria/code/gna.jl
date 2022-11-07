using Plots

global SEED = 0.1
global R = 4-1e-10


function step(r::Float64=R)
    global SEED = r*SEED*(1-SEED)
end

function long_step(t::Int64=30;r::Float64=R)
    for _ in 1:t
        step(r)
    end
    return SEED
end

function historia(t::Int64, r::Float64=R)
    res = Vector{Float64}()
    push!(res,SEED)
    for _ in 1:t
        long_step(r=r)
        push!(res,SEED)
    end
    return res
end


@time h = historia(10000)
sum(h.< 0.5)
plot(h[1:100])

function moneda()
    x_old = long_step(); x = long_step()
    while (!((x > 0.5) & (x_old < 0.5)) & !((x < 0.5) & (x_old > 0.5)))
        x_old = x; x = long_step()
    end
    return (x > 0.5) & (x_old < 0.5)
end

function monedas(t::Int64=64)
    res = Vector{Bool}()
    for _ in 1:t
        push!(res,moneda())
    end
    return res
end

