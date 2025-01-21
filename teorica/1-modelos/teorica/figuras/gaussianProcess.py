import numpy as np
import matplotlib.pyplot as plt

# Define the RBF kernel (covariance function)
def rbf_kernel(X1, X2, length_scale=1.0, variance=1.0):
    sqdist = np.sum(X1**2, 1).reshape(-1, 1) + np.sum(X2**2, 1) - 2 * np.dot(X1, X2.T)
    return variance * np.exp(-0.5 / length_scale**2 * sqdist)

# Gaussian Process class
class GaussianProcess:
    def __init__(self, kernel=rbf_kernel, mean_function=None):
        self.kernel = kernel
        self.mean_function = mean_function if mean_function else self.zero_mean
    def zero_mean(self, X):
        return np.zeros((X.shape[0], 1))
    def fit(self, X_train, y_train, noise=1e-10):
        self.X_train = X_train
        self.y_train = y_train
        self.noise = noise
        self.K = self.kernel(X_train, X_train) + noise * np.eye(len(X_train))
        self.K_inv = np.linalg.inv(self.K)
    def predict(self, X_test):
        K_star = self.kernel(self.X_train, X_test)
        K_star_star = self.kernel(X_test, X_test)
        mu_star = self.mean_function(X_test) + K_star.T.dot(self.K_inv).dot(self.y_train - self.mean_function(self.X_train))
        cov_star = K_star_star - K_star.T.dot(self.K_inv).dot(K_star)
        return mu_star, cov_star


# Generate some training data
np.random.seed(1)
X_train = np.random.uniform(-5, 5, (10, 1))
y_train = np.sin(X_train) + 0.1 * np.random.randn(10, 1)

# Fit the Gaussian Process model
gp = GaussianProcess()
gp.fit(X_train, y_train, noise=.01)

# Generate test points and make predictions
X_test = np.linspace(-6, 6, 100).reshape(-1, 1)
mu_test, cov_test = gp.predict(X_test)

# Plot the results
plt.figure(figsize=(10, 6))
plt.plot(X_train, y_train, 'ro', label='Datos',color="black")
plt.plot(X_test, np.sin(X_test),  '--', color="black", label='Función objetivo',linewidth=2)
plt.plot(X_test, mu_test, 'b', label='Estimación media', linewidth=2)
plt.fill_between(X_test.ravel(), 
                 mu_test.ravel() - 1.96 * np.sqrt(np.diag(cov_test)), 
                 mu_test.ravel() + 1.96 * np.sqrt(np.diag(cov_test)), 
                 alpha=0.2, color='b', label='Intervalo de credibilidad 95%')
ax = plt.gca()
ax.tick_params(axis='both', labelsize=20)
legend = plt.legend(loc="lower left",fontsize=14, edgecolor=(0, 0, 0, 0), facecolor=(1, 1, 1, 0))
legend.get_frame().set_alpha(None)
legend.get_frame().set_facecolor((0, 0, 0, 0))
plt.savefig("pdf/GaussianProcess.pdf",bbox_inches='tight')
plt.savefig('png/GaussianProcess.png', bbox_inches='tight', transparent=False)
plt.close()



