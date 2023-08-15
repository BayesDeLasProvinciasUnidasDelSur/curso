#using Plots

global _prior_ = [ [0 0 0] ; [1/6 0 1/3 ] ; [1/6 1/3 0 ] ] 
global _posterior_ = [ [0 0 0] ; [1/3 0 2/3 ] ; [0 0 0 ] ] 


function prior(r,s) return _prior_[r,s] end
function prior() return _prior_ end
function posterior(r,s) return _posterior_[r,s] end
function posterior() return _posterior_ end

function Dkl(p,q)
    res = 0.0
    for i in 1:length(p)
        if p[i]>0.0
            res += p[i]*(log(q[i]/p[i]))
    end end
    return -res 
end

p = [ [0 0 0] ; [1/100 0 1-1/100 ] ; [0 0 0] ]
q = _prior_

function alternative(i)
    Dkl([ [0 0 0] ; [i/100 0 1-i/100 ] ; [0 0 0] ], _prior_)
end

minimum(alternative.(1:100))
Dkl(_posterior_, _prior_)
plot(alternative.(1:100))
