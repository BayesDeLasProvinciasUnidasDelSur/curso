"""
   :copyright: (c) 2020 by Gustavo Landfried
   :license: BSD, see LICENSE for more details.   
"""
#import os
#import math
import numpy as np
from numpy.random import normal as rnorm
from matplotlib import pyplot as plt 

#__all__ = ["dW","wiener"]


    
""" 
---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---
            
                      Geometrical Browninan Motion.

Below you will find the functions to create the geometrical Browninan Motion

---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---
"""

"""
First of all we need to define the Norbert Wiener process: A real valued
continuous time stochastic process of the one-dimensional Brownian motion.
    - $W_0=0$
    - $W_t$ has Gaussian independent increments centered at $W_{t-1}$
    - $W$ has continuous paths: $W_{t}$ is continuous in $t$.
"""


def dW(pos=0,step=1):
    """
    The Gaussian independent increments of Norbert Wiener process.
    """
    return rnorm(pos,step,1)[0]

def wiener(iterations,step_length):
    """
    Norbert Wiener process:
        A real valued continuous time stochastic process 
        of the one-dimensional Brownian motion.
    """
    res = [0]
    for i in range(iterations):
        pos = res[-1]
        res.append(dW(pos,step_length))
    return res

def show_walks(n,iteratons=100,step_length=1):
    """
    Examples
    ---------
    show_walks(10)
    show_walks(10,1000,0.01) # See changes on scale
    """
    for i in range(n):
        plt.plot(wiener(iteratons,step_length))
        
"""
Now, we need to define a multiplicative process. We first will define the 
constant multiplicative process, and then we will perturbed.
"""

def multiplicative_process(n,rate,dt):
    """
    A constant growth rate process
    
    Parameters
    ----------
    n : int
        Number of time steps
    rate : float
        Constant growth rate
    dt : TYPE
        Delta time between time steps
    """
    wealth = [1]
    time = [0]
    for i in range(n):
        wealth.append(wealth[-1]*rate)
        time.append(time[-1]+dt)
    return time, wealth

def show_mult(n=120,rate=1.01,dt=1/12):
    """
    show_mult(100,1.04,dt=1)
    show_mult(12*12,1.01,dt=1/12)
    """
    x, y = multiplicative_process(n,rate,dt)
    plt.plot(x,np.log10(y))
    
def gr_mult(rate,dt):
    """
    Constant growth rate in a multiplicative process
    
    Examples
    --------
    gr_mult(1.125,1)
    gr_mult(1.01,1/12)
    """
    return np.log(rate)/dt

"""
To perturb the process in a consistent way, we remind ourselves
that what's constant about the process in the absence of noise is the
growth rate
"""

def perturbed_payment(rate=1.01,dt=1/12,sigma=0.1):
    """
    perturbed_payment(1.125,1,1)
    """
    gamma = np.log(rate)/dt
    dv = gamma*dt + sigma*dW(0,dt)
    return max(dv,-0.9999)

def walk_perturbed_payment(n,rate,dt,sigma=100,log=False):
    """
    walk_perturbed_payment(100,1.01,1/12,3)
    """
    wealth = [1] 
    for _ in range(n):
        dv = perturbed_payment(rate,dt,sigma)
        wealth.append(wealth[-1]+wealth[-1]*dv)
    return wealth

def multiplicative_perturbed_history(n=100,iterations=1000,rate=1.005,dt=1/12,sigma=2):
    res = []
    for i in range(n):
        res.append(walk_perturbed_payment(iterations,rate,dt,sigma))
    return res

def show_walk_perturbed_payment(n=10,iterations=1000,rate=1.005,dt=1/12,sigma=2):
    """
    show_walk_perturbed_payment(n=10,sigma=2)
    plt.show()
    show_walk_perturbed_payment(n=1,sigma=0)
    """
    for i in range(n):
        plt.plot(np.log10(walk_perturbed_payment(iterations,rate,dt,sigma)) )
        
def gross_domestic_product(wealths):
    return np.sum(wealths)

def gross_domestic_product_per_capita(wealths):
    return gross_domestic_product(wealths)/len(wealths)

def democratic_domestic_product(wealths):
    return np.prod(wealths)

def democratic_domestic_product_per_capita(wealths):
    return democratic_domestic_product(wealths)**(1/len(wealths))

def growth(state_t, state_0,dt=1):
    return (1/dt) * np.log(state_t/state_0)

def second_theil_index(gdp,ddp):
    return np.log(gdp) - np.log(ddp)


def gini(wealths):
    ys = np.array(sorted(wealths))
    denom = 2* sum([ (i+1)*ys[i] for i in range(len(ys))])
    numer = len(ys)* sum([ ys[i] for i in range(len(ys))])
    return denom/numer - (len(ys)+1)/len(ys)    
    

"""
---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---
                
                    Other functions (some used in a post)
            
---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---
"""


def change_in_utility(w):
    """
    w = np.array(list(map(lambda x: 10.0**x,np.arange(-10,10))) )
    change_in_utility(w)
    """
    return 1/w

def utility(w):
    return np.log(w)

def show_utility(w):
    """
    w = np.arange(-10,10,step=0.1) 
    show_utility(w)
    np.log(10**-10)
    """
    plt.plot(w,(utility(w)))
    plt.xticks(fontsize=12) # rotation=90
    plt.yticks(fontsize=12) # rotation=90
    plt.ylabel("Utility", fontsize=16 )
    plt.xlabel("Wealth", fontsize=16 )

"""
The Utility Theory considers that it is preferable to participate in this game
when the expected value is positive. Then, the Utility Theory systematically
observed how people acted contrary to what was considered optimal. Paired with 
a firm belief in its models, this has led to a narrative of human irrationality
in large parts of economics.

But if we analyze what really 

This is because we are facing a multiplicative process.
When the asymmetry between real physical effects of gains and losses is large, people quite reasonably 'pay to avoid losses' (e.g. buy insurance).
When it is not large, people don't unreasonably mind losses, and won't pay to avoid them.


"""

def simple_gamble(size):
    r = np.random.random()
    if r <= 0.5:
        res = 1.5*size
    else:
        res = 0.6*size
    return res

def walk_simple_gamble(iteratons):
    res = [1]
    for i in range(iteratons):
        res.append(simple_gamble(res[-1]))
    return res
    
def incest_rule(communities_size,exogamy=0.05):
    res = []
    migration_per_community = exogamy*sum(communities_size)/len(communities_size)
    for c in range(len(communities_size)):
        res.append(communities_size[c]*(1-exogamy) + migration_per_community)
    return res 

def init_communities(n_communities):
    communities = []
    for i in range(n_communities):
        communities.append(1.0)
    return communities

def walk_incest(iteratons,n_communities,incest=1):     
    communities = init_communities(n_communities)
    history = []
    history.append(communities)
    for i in range(iteratons):
        history.append(list(map(lambda x: simple_gamble(x), incest_rule(history[-1],incest) ) ))
    return history


def incest_rule_free_rider(communities_size,free_rider,exogamy=0.05):
    res = []
    n_free_riders = len(free_rider)
    size_not_free_rider = sum(map(lambda i: 0 if i in free_rider else communities_size[i], range(len(communities_size))))
    migration_per_community = exogamy*size_not_free_rider/len(communities_size)
    for c in range(len(communities_size)):#c=0
        res.append( communities_size[c]*(1-exogamy*int(not c in free_rider)) + migration_per_community)
    return res

def walk_incest_free_rider(iteratons,n_communities,n_free_riders=1,incest=1):
    communities = init_communities(n_communities)
    free_riders = list(range(n_free_riders))
    history = []
    history.append(communities)
    for i in range(iteratons):
        history.append(list(map(lambda x: simple_gamble(x), incest_rule_free_rider(history[-1],free_riders,incest) ) ))
    return history
 

"""
Share resource, but play you one game.
"""    

def walk_sharing(iteratons=1000,n_communities=150):
    communities = init_communities(n_communities)
    history = []
    history.append(communities)
    for i in range(iteratons):
        proportion = list(map(lambda x: x/n_communities, history[-1] ))
        shared = sum(history[-1])
        shared = simple_gamble(shared) # El problema es jugar en grupo. Ley de los grandes n\'umeros.
        history.append(list(map(lambda x: shared*x, proportion)))
    return history
