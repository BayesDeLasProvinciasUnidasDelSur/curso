using Turing











@model rate_and_attemps(k,Nmax)
    p ~ Beta(1,1) # Rate
    n ~ Categorical(Nmax) # Attemps
    # Observed success
    for i in 1:length(k)
        k[i] ~ Binomial(p,n)
    end
end


























