using Test

mutable struct DAG
    p::Dict{String,Array{Float64}}
    function DAG()
        return new(Dict{String,Vector{Int64}}()) 
    end
end

dag = DAG()
dag.p["e"] = [0.999 0.001]
dag.p["t"] = [0.992 0.008]
dag.p["r|t"] = [ [0.99 0.01] 
                 [0.01 0.99] ]
dag.p["a|e,t"] = zeros(Float64,(2,2,2))
dag.p["a|e,t"][:,1,1] = [0.99 0.01] 
dag.p["a|e,t"][:,2,1] = [0.01 0.99] 
dag.p["a|e,t"][:,1,2] = [0.01 0.99] 
dag.p["a|e,t"][:,2,2] = [0.0001 0.9999] 
# Llamada
dag.p["l|a"] = [ [0.99 0.01] 
                 [0.01 0.99] ]

function bien_formada(formula)
    false && throw(error("Formula MAL formada"))
end
                 
function sin_espacios(str)
    str=filter(x -> !isspace(x), str)
end

function leer(consulta)#consulta = "a"
    bien_formada(consulta);sin_espacios(consulta)
    
    izq,der = occursin("|",consulta) ? split(consulta,"|") : (consulta,missing)
    
    marginal = Dict{String,Union{Missing, Int64}}()
    for elem in split(izq,",") 
        n,v = occursin("=",elem) ? (split(elem,"=")[1],parse(Int64,split(elem,"=")[2])) : (elem,missing)
        marginal[n] = v 
    end
    
    condicional = Dict{String,Union{Missing, Int64}}()
    if der !== missing
        for elem in split(der,",") 
            n,v = occursin("=",elem) ? (split(elem,"=")[1],parse(Int64,split(elem,"=")[2])) : (elem,missing)
            condicional[n] = v 
        end
    end
    return(marginal,condicional)
end

leer("alarma")
m,c = leer("a|e = 1, t")
leer("alarma,l=10|e = 1, terremoto")


function parents(dag::DAG, node::String)#node="a"
    res = Vector{String}(); sin_espacios(node)
    for (k,v) in dag.p#(k,v)=dag.p["a|e,t"]
        m,c = leer(k)
        if node == first(keys(m))
            for q in keys(c)
                push!(res,q)
            end
        end
    end
    return res
end

parents(dag,"e")

function ejes(dag::DAG)
    res = Vector{Tuple{String,String}}()
    for k in keys(dag.p)
        m,c = leer(k)
        for q in keys(c)
            eje = (q,first(keys(m)))
            println(eje)
            push!(res,eje)
        end
    end
    return res
end

ejes(dag)

function nodos(dag::DAG)
    res = Set{String}()
    for k in keys(dag.p)
        m,c = leer(k)
        push!(res,first(keys(m)))
    end
    return res
end

nodos(dag)

function hojas(dag::DAG)
    esMadre = Dict{String,Bool}()
    esHija =  Dict{String,Bool}()
    for v in nodos(dag)
        esMadre[v] = false; esHija[v] = false 
    end
    for e in ejes(dag)
        esMadre[e[1]] = true; esHija[e[2]] = true
    end
    
    res = Vector{String}()
    for v in nodos(dag)
        if esMadre[v] & !esHija[v]
            push!(res,"f_"*v)
        elseif !esMadre[v] & esHija[v]
            push!(res,v)
        end
    end
    return res
end

hojas(dag)

function el_factor_de(variable)#variable="a"
    sin_espacios(variable)
    for k in keys(dag.p)
        m,c = leer(k)
        if first(keys(m)) == variable
            return k
        end
    end
end

el_factor_de("a")

function argumento_en(variable)
    sin_espacios(variable)
    res = Set{String}()
    for k in keys(dag.p)
        m,c = leer(k)
        if variable in union(keys(m),keys(c))
            push!(res, "f_"*first(keys(m)))
        end
    end
    return res
end

argumento_en("a")
argumento_en("t")
argumento_en("e")
argumento_en("r")

function vecindad(dag::DAG, nodo)#nodo="f_a"
    sin_espacios(nodo)
    esFactor = occursin("_",nodo)
    if esFactor
        v = split(nodo,"_")[2]
        m,c = leer(el_factor_de(v))
        res = union(keys(m),keys(c))
    else
        res = argumento_en(nodo)
    end
    return res
end

vecindad(dag,"a")

mutable struct Variable
    nombre::String
    mensajes::Dict{String,Union{Missing,Array{Float64}}}
    function Variable(dag::DAG,nombre::String)
        sin_espacios(nombre)
        mensajes = Dict{String,Union{Missing,Array{Float64}}}()
        for f in argumento_en(nombre)
            mensajes[f] = missing
        end
        return new(nombre,mensajes)
    end
end

Variable(dag,"a")

