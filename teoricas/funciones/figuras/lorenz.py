# -*- coding: utf-8 -*-


import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint
from mpl_toolkits.mplot3d import Axes3D

rho = 28.0
sigma = 10.0
beta = 8.0 / 3.0

def f(state, t):
  x, y, z = state  # unpack the state vector
  return sigma * (y - x), x * (rho - z) - y, x * y - beta * z  # derivatives

state0 = [1.0, 1.0, 1.0]
t = np.arange(0.0, 47.5, 0.001)
len(t)
states = odeint(f, state0, t)

fig = plt.figure(facecolor='white')

#fig.subplots_adjust(left=-0.2, right=1.2, top=1.1, bottom=-0.3)
ax = fig.gca(projection='3d',alpha=0.7)
ax.axis('off')
ax.margins(0)
ax.plot(states[:,0], states[:,1], states[:,2],color=(0,0,0),alpha=0.5,linewidth=0.75)
#i=0; step = 100
#while i < len(t):
#    ax.plot(states[i:(i+step),0], states[i:(i+step),1], states[i:(i+step),2],color=(0,0,0),alpha=0.3,linewidth=0.75)
#    i = i + step 
    
plt.savefig("lorenz.pdf",pad_inches =0,transparent =True,frameon=True)
bash_cmd = "pdfcrop --margins '0 0 0 0' lorenz.pdf lorenz.pdf"
#bash_cmd = "convert -density 400 lorenz.pdf -resize 100% lorenz.png"
plt.savefig("lorenz.png",pad_inches =0,transparent =True,frameon=True,dpi=1200)
import os
os.system(bash_cmd)


