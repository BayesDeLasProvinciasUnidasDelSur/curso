using Distributions
using Plots

# Bent coin lottery
x = Binomial(1000,0.1)

winningProb = 0.0; i = 0; nTickets = 0
while winningProb < 0.99
    delta = (0.99 - winningProb)
    if pdf(x)[i+1] < delta
        winningProb += pdf(x)[i+1]
        nTickets += binomial(BigInt(1000),i)
    else
        prop = delta/pdf(x)[i+1]
        winningProb += delta
        nTickets = prop*binomial(BigInt(1000),i)
    end
    i = i + 1
end

#
x4 = Binomial(4,0.1)
d4 = [1.0]
Hd4 = []
N4 = 0
for i in 0:4
    np = pdf(x4)[i+1]
    n = binomial(4,i)
    p = np/n
    for j in 1:n
        N4 += 1
        push!(d4,d4[end]-p)
        push!(Hd4,log(2,N4))
    end
end

x16 = Binomial(16,0.1)
d16 = [1.0]
Hd16 = []
N16 = 0
for i in 0:16
    np = pdf(x16)[i+1]
    n = binomial(16,i)
    p = np/n
    for j in 1:n
        N16 += 1
        push!(d16,d16[end]-p)
        push!(Hd16,log(2,N16))
    end
end

scatter(d4[2:end],Hd4./4)
scatter!(d16[2:end],Hd16./16)

scatter(log.(10,d4[2:end-1]),Hd4[1:end-1])


scatter(d4[2:end],Hd4)
scatter(d16[2:end],Hd16)

