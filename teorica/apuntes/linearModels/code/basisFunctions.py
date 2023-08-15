import numpy as np

def identity_basis_function(x):
    return x

def gaussian_basis_function(x, mu=0, sigma=0.1):
    return np.exp(-0.5 * (x - mu) ** 2 / sigma ** 2)

def polynomial_basis_function(x, degree=1):
    return x ** degree

def phi(x, bf, args=None):
    if args is None:
        return np.concatenate([np.ones(x.shape), bf(x)], axis=1)
    else:
        return np.concatenate([np.ones(x.shape)] + [bf(x, *args)], axis=1)

