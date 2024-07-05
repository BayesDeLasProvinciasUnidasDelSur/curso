from matplotlib import pyplot as plt
from collections import OrderedDict
import numpy as np
import random
from scipy import stats
import pandas as pd
import pickle
import math
from collections import defaultdict

import particles
from particles import distributions as dists
from particles import smc_samplers as ssp
#from particles import state_space_models as ssm
from particles.collectors import Moments

# Data
teams = pd.read_csv("data/teams.csv")
results = pd.read_csv("data/results.csv")
startingXI = pd.read_csv("data/startingXI.csv")
fixture = pd.read_csv("data/fixtures.csv")


prior_loc = 0.0
prior_scale = 3.0
prior_dict = {}
for t in teams.TeamID:
    prior_dict[f"Offense{t}"] = dists.Normal(loc=prior_loc, scale=prior_scale)
    prior_dict[f"Defense{t}"] = dists.Normal(loc=prior_loc, scale=prior_scale)

#prior_dict[f"Offense{t}"] = dists.Cond(lambda x: \
#dists.Normal(loc=x[f"OffenseSkill{t}"], scale=0.25))
#prior_dict[f"Defense{t}"] = dists.Cond(lambda x: \
#dists.Normal(loc=x[f"DefenseSkill{t}"], scale=0.25))


prior = dists.StructDist(prior_dict)

class TeamBasedGoalBased(ssp.StaticModel):
    def logpyt(self, theta, t):  # density of Y_t given theta and Y_{0:t-1}
        Game = results.iloc[t,]
        #print(t)
        AttackHome = theta[f"Offense{Game.HomeTeamID}"] - theta[f"Defense{Game.AwayTeamID}"] #HomeOffenseSkill - AwayDefenseSkill
        AttackAway = theta[f"Offense{Game.AwayTeamID}"] - theta[f"Defense{Game.HomeTeamID}"]
        return dists.Poisson(np.exp(AttackHome)).logpdf(Game.HomeScore) + \
               dists.Poisson(np.exp(AttackAway)).logpdf(Game.AwayScore)


#class TeamBasedAttemptsBased(ssp.StaticModel):
    #def logpyt(self, theta, t):  # density of Y_t given theta and Y_{0:t-1}
        #n_particles = len(theta['Offense1'])
        #Game = results.iloc[t,]
        #AttackHome = theta[f"Offense{Game.HomeTeamID}"] - theta[f"Defense{Game.AwayTeamID}"] #HomeOffenseSkill - AwayDefenseSkill
        #AttackAway = theta[f"Offense{Game.AwayTeamID}"] - theta[f"Defense{Game.HomeTeamID}"]
        #return dists.Poisson(np.exp(AttackHome)).logpdf(Game.HomeShots) + \
               #dists.Poisson(np.exp(AttackAway)).logpdf(Game.AwayShots)




K = 20
N = 2000

#model = TeamBasedGoalBased(data=results, prior=prior)
#ibis = ssp.IBIS(model, len_chain=K, wastefree=True)
#simulator2 = particles.SMC(fk=ibis, N=N, ESSrmin=0.5,
                #store_history=True, verbose=True)
#simulator2.run()

muO_data = {}; muO_data["muO0"] = [0. for _ in range(28)]
stdO_data = {}; stdO_data["stdO0"] = [3. for _ in range(28)]
muD_data = {}; muD_data["muD0"] = [0. for _ in range(28)]
stdD_data = {}; stdD_data["stdO0"] = [3. for _ in range(28)]
for time in range(0, 1511):  # time=0
    muO_data[f"muO{time + 1}"] = [np.average(simulator2.hist.X[time].theta[f"Offense{i}"],
                                            weights=simulator2.hist.wgts[time].W) for i in range(1, 29)]
    stdO_data[f"stdO{time + 1}"] = [np.sqrt(np.average(
        (simulator2.hist.X[time].theta[f"Offense{i}"] -
        np.average(simulator2.hist.X[time].theta[f"Offense{i}"], weights=simulator2.hist.wgts[time].W))**2,
        weights=simulator2.hist.wgts[time].W)) for i in range(1, 29)]
    muD_data[f"muD{time + 1}"] = [np.average(simulator2.hist.X[time].theta[f"Defense{i}"],
                                            weights=simulator2.hist.wgts[time].W) for i in range(1, 29)]
    stdD_data[f"stdD{time + 1}"] = [np.sqrt(np.average(
        (simulator2.hist.X[time].theta[f"Defense{i}"] -
        np.average(simulator2.hist.X[time].theta[f"Defense{i}"], weights=simulator2.hist.wgts[time].W))**2,
        weights=simulator2.hist.wgts[time].W)) for i in range(1, 29)]


muO_df = pd.DataFrame(muO_data)
stdO_df = pd.DataFrame(stdO_data)
muD_df = pd.DataFrame(muD_data)
stdD_df = pd.DataFrame(stdD_data)

summary = pd.concat([teams, muO_df, stdO_df, muD_df, stdD_df], axis=1)
summary.to_csv("output/summary.csv")

#posterior_dict = {}
#posterior1 = dists.StructDist(posterior_dict)

#model2 = TeamBasedGoalBased(data=results[results.SeasonID==2], prior=posterior1)
#ibis2 = ssp.IBIS(model, len_chain=K)
#simulator2 = particles.SMC(fk=ibis2, N=N,
                #store_history=False, verbose=True)


#teams.to_csv("output/teams.csv")

