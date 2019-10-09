import numpy as np
from numpy.random import normal as noise 
def generative_model(X, variance, w0 = -0.3, w1 = 0.5):
    '''Linear function plus noise'''
    return w0 + w1 * X + noise(0,variance,X.shape)
def synthetic_data(X, variance):
    '''Sinus function plus noise'''
    return 0.5 + np.sin(2 * np.pi * X) + noise(0,variance,X.shape)
