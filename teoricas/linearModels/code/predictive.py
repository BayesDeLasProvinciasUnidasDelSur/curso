def predcitive(t, m_N, S_N, Phi, alpha, beta):
    sigma2 = Phi.t.dot(S_N.dot(Phi)) + (1/beta)
    mu = m_N.T.dot(Phi)
    return mu, sigma2 
