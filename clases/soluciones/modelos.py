
def compute_model_posterior(log_ev):
    le = np.array(log_ev) # lista de [log p(D|M_i)] vectorizada
    lp = np.log(1/len(log_ev)) # log p(M_i), mismo para todos los modelos
    propotional_log_posterior = le + lp #  log p(D|M) + log P(M)  el posterior proporcional
    c  = np.max(le + lp) # Constante
    propotional_log_posterior = propotional_log_posterior  - c #
    model_posterior = np.exp(propotional_log_posterior)/sum(np.exp(propotional_log_posterior))
    return model_posterior
