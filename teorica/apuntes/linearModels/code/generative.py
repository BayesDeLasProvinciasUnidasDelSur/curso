import numpy as np
from numpy.random import normal as noise 
def linear_model(X, variance, w0 = -0.3, w1 = 0.5):
    '''Linear function plus noise'''
    return w0 + w1 * X + noise(0,np.sqrt(variance),X.shape)
def sinus_model(X, variance):
    '''Sinus function plus noise'''
    return np.sin(2 * np.pi * X) + noise(0,np.sqrt(variance),X.shape)
