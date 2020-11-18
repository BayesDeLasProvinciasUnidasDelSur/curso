import numpy as np
def posterior(alpha, beta, t, Phi):
    S_N_inv = alpha * np.eye(Phi.shape[1]) + beta * Phi.T.dot(Phi)
    S_N = np.linalg.inv(S_N_inv)
    m_N = beta * S_N.dot(Phi.T).dot(t)
    return m_N, S_N

def prior(alpha, beta, M):
    S_0_inv = alpha * np.eye(M)
    S_0 = np.linalg.inv(S_0_inv)
    m_0 = np.zeros((1,M))
    return m_0, S_0