#using Plots

joint_prior_A = matrix(NA, nrow=3, ncol=3)
joint_prior_A[1,] = c(0, 1/6, 1/6)
joint_prior_A[2,] = c(1/6, 0, 1/6)
joint_prior_A[3,] = c(1/6, 1/6, 0)

joint_prior_Monty = matrix(NA, nrow=3, ncol=3)
joint_prior_Monty[1,] = c( 0,   0,   0)
joint_prior_Monty[2,] = c(1/6,  0,  1/3)
joint_prior_Monty[3,] = c(1/6, 1/3,  0)

joint_posterior_Monty = matrix(NA, nrow=3, ncol=3)
joint_posterior_Monty[1,] = c(0, 0, 0)
joint_posterior_Monty[2,] = c(1/3, 0, 2/3)
joint_posterior_Monty[3,] = c(0, 0, 0) 

entropia <- function(joint_prior = joint_prior_Monty){
    res = 0.0
    joint_prior_vector = as.vector(joint_prior[joint_prior>0.0])
    for(p in joint_prior_vector){
        res = res - (p*log(p))
    }
    return(res)
}
    
entropia(joint_prior_Monty) < entropia(joint_prior_A)

function Dkl(p,q)
    res = 0.0
    for i in 1:length(p)
        if p[i]>0.0
            res += p[i]*(log(q[i]/p[i]))
    end end
    return -res 
end

function alternative(i)
    Dkl([ [0 0 0] ; [i/100 0 1-i/100 ] ; [0 0 0] ], _prior_)
end

minimum(alternative.(1:100))
Dkl(_posterior_, _prior_)
plot(alternative.(1:100))
