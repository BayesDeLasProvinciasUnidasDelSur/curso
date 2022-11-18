# generate random samples from Gaussian distributions #
import pandas as pd
import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt

# number of data points
N = 100

true_mean_0 = 1
true_mean_1 = 3
true_mean_2 = 5

true_precision_0 = 10
true_precision_1 = 10
true_precision_2 = 10

def sample(component):
    if component == 0:
        return np.random.normal(true_mean_0, np.sqrt(1 / true_precision_0), 1)[0]
    if component == 1:
        return np.random.normal(true_mean_1, np.sqrt(1 / true_precision_1), 1)[0]
    else:
        return np.random.normal(true_mean_2, np.sqrt(1 / true_precision_2), 1)[0]

# weight distribution p can be changed to create more Gaussian component data
mask = np.random.choice([0, 1, 2], N, p=[0, 0, 1])
data = [sample(i) for i in mask]
df = pd.DataFrame(data)
df.to_csv('data1.csv', sep=',', header=False, index=False)

mask = np.random.choice([0, 1, 2], N, p=[0.4, 0.2, 0.4])
data = [sample(i) for i in mask]
df = pd.DataFrame(data)
df.to_csv('dataK.csv', sep=',', header=False, index=False)

