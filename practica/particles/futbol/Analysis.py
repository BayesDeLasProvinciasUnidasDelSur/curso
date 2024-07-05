from matplotlib import pyplot as plt
from collections import OrderedDict
import numpy as np
import random
from scipy import stats
import pandas as pd
import pickle
import math
from collections import defaultdict


# Data
teams = pd.read_csv("data/teams.csv")
results = pd.read_csv("data/results.csv")
startingXI = pd.read_csv("data/startingXI.csv")
fixture = pd.read_csv("data/fixtures.csv")
odds = pd.read_csv("data/odds.csv")

##
## 1. Exploring the First Season
##

def Analysing_Season(Season1):
    PointsSeason1 = np.repeat(0,len(teams.TeamID))
    biggestUpset = -1 # to unwser
    WeekSeason1Title = -1
    for week in range(1, max(Season1.Gameweek)+1):#week=1
        Season1Week = Season1[Season1.Gameweek == week]
        for i, Game in Season1Week.iterrows():#Game=Season1Week.iloc[0,]
            Diff = Game.HomeScore - Game.AwayScore
            biggestUpset = Diff if abs(Diff) > biggestUpset else biggestUpset
            PointsSeason1[Game.HomeTeamID-1] += \
                3 if Diff > 0 else (1 if Diff == 0 else 0)
            PointsSeason1[Game.AwayTeamID-1] += \
                3 if Diff < 0 else (1 if Diff == 0 else 0)
        DistanceFromMax = np.max(PointsSeason1) - PointsSeason1
        Candidate = np.argwhere(DistanceFromMax == np.min(DistanceFromMax))
        if Candidate.shape[0] == 1:
            DistanceFromMax[DistanceFromMax == 0] = 54*3 + 1
            if WeekSeason1Title == -1 and (np.min(DistanceFromMax) > (54-week)*3):
                WeekSeason1Title = week
                Winner = Candidate+1
    # 1 Which Team won the league in the fist season?
    Winner
    # 2 At what point in the season did that team secure their league title?
    WeekSeason1Title
    # 3 What result was the biggest upset?
    biggestUpset
    return {"Winner": Winner, "WeekTitle": WeekSeason1Title, "BiggestUpset": biggestUpset, "Points": PointsSeason1}


season1 = Analysing_Season(results[results.SeasonID == 1])
season2 = Analysing_Season(results[results.SeasonID == 2])

teams["PointsSeason1"] = season1["Points"]
teams["PointsSeason2"] = season2["Points"]

print("Winner =", teams.TeamName[season1["Winner"][0][0]-1])
print("Week Title =", season1["WeekTitle"] )
print("Biggest Upset=", season1["BiggestUpset"] )

##
## 2. Predicting the second season
##
## ####################################################### #
##              Hidden Inference Procedure                 #
##                                                         #
## Implements the Poisson-OD Model, specified in the paper #
## Guo 2012. "Score-Based Bayesian Skill Learning"         #
##                                                         #
## Symmetric team based and score based online MODEL       #
## - Symmetric means that we do not take into account      #
##   the difference in performances between playing Away   #
##   and playing at Home                                   #
## - Team based means that we estimate the offensive and   #
##   defensive skills of each team, without taking into    #
##   account the composition of each team at each match.   #
## - Score based means that the skill estimates were       #
##   inferred using just the score of each match, without  #
##   taking into account the number of attempts.           #
## - Online means that we have an estimate for each time   #
##   step, stored in the file "summary.csv". The prior     #
##   for one time step is the estimate at the previous     #
##   time step.                                            #
## ####################################################### #

# The output of the inference procedure.
summary = pd.read_csv("summary.csv")
print("The output of the inference procedure", summary)
print("Columns muOt is the mean estimate of the offensive skill at time t")
print("Columns stdOt is the std estimate of the offensive skill at time t")
print("Columns muDt is the mean estimate of the defensive skill at time t")
print("Columns stdDt is the std estimate of the defensive skill at time t")
# Adding a missing column
summary["stdD0"] = [3. for _ in range(28)] # prior

##
## 2.1 Consider how you might test this model, bearing in mind you have results available for the
## second season.
##
## Solution.
## Models must be evaluated by the strict application of probability rules. If we have all
## alternative models, we want to compute that the posterior probability of the models. P(Model|DataSet)
## If we have a subset of models, me can compare them by their bayes factor. If we have no preference
## between models, comparing models is equivalent to compare their joint prediction P(DataSet|Model)
##
## Note that by the strict application of probability rules prior prediction of a data set can be
## decomposed as the product of the prior prediction of each data point.
##
## P(DataSet = {d1, d2, d3 ... } | Model) = P(d1|Model) P(d2|d1,Model) P(d3|d1,d2,Model) ...
##
## Because we have used an inference procedure that give us the estimate of all teams at each time step
## it is straight forward to compute the joint prior prediction.

# Observed results
win = (results.HomeScore - results.AwayScore)>0
draw = (results.HomeScore - results.AwayScore)==0
lose = (results.HomeScore - results.AwayScore)<0


def calculate_outcome_probabilities(team_i, team_j, summary, t=755):
    #team_i= match.HomeTeamID-1
    #team_j= match.AwayTeamID-1
    # Home score probability given estimates before season 2
    home_offense_diff = (summary[f"muO{t}"][team_i] - summary[f"muD{t}"][team_j],
                         math.sqrt(summary[f"stdO{t}"][team_i]**2 + summary[f"stdD{t}"][team_j]**2))
    p_home_score = calculate_marginal_probabilities(*home_offense_diff)
    # Away score probability given estimates before season 2
    away_offense_diff = (summary[f"muO{t}"][team_j] - summary[f"muD{t}"][team_i],
                         math.sqrt(summary[f"stdO{t}"][team_j]**2 + summary[f"stdD{t}"][team_i]**2))
    p_away_score = calculate_marginal_probabilities(*away_offense_diff)
    # Summation of the probability of all home winning scores
    p_home_win = np.sum(np.tril(np.outer(p_home_score, p_away_score), k=-1))
    # Summation of the probability of all home losing scores
    p_away_win = np.sum(np.tril(np.outer(p_away_score, p_home_score), k=-1))
    p_draw = 1 - (p_home_win + p_away_win)
    return p_home_win, p_draw, p_away_win

def calculate_marginal_probabilities(mean_diff, std_diff):
    #mean_diff, std_diff=home_offense_diff
    offense_diff = stats.norm(loc=mean_diff, scale=std_diff)
    # Marginal probability of Score
    # P(Score) = \sum_{d \in difference} P(Score|d)P(d)dx
    marginal_prob = []
    dx = 6*std_diff*2/1000 # for numerical integration
    d_grilla = np.arange(mean_diff-6*std_diff, mean_diff+6*std_diff, dx) # for numerical integration
    s = 0
    while (sum(marginal_prob) < 0.999) and (s < 20):
        marginal_prob.append(sum(stats.poisson(np.exp(d_grilla)).pmf(s) * offense_diff.pdf(d_grilla)) * dx)
        s += 1
    return marginal_prob/sum(marginal_prob)


win_prediction = []
draw_prediction = []
lose_prediction = []
for t in range(len(results.MatchID)):
    match=results.iloc[t,]
    #print(t)
    w, d, l = calculate_outcome_probabilities(match.HomeTeamID-1, match.AwayTeamID-1, summary, t)
    win_prediction.append(w)
    draw_prediction.append(d)
    lose_prediction.append(l)

log_evidence_whole_history = \
        (np.sum(np.log(np.array(win_prediction)[win]))+\
        np.sum(np.log(np.array(draw_prediction)[draw]))+\
        np.sum(np.log(np.array(lose_prediction)[lose])))

log_evidence_season_2 = \
        (np.sum(np.log(np.array(win_prediction)[756:][win[756:]]))+\
        np.sum(np.log(np.array(draw_prediction)[756:][draw[756:]]))+\
        np.sum(np.log(np.array(lose_prediction)[756:][lose[756:]])))


geometric_mean_own_model_whole_history = np.exp(log_evidence_whole_history/1512)
geometric_mean_own_model_season2 = np.exp(log_evidence_season_2/756)
print("Geometric mean of predictions", geometric_mean_own_model_whole_history )
print("Geometric mean of predictions (season 2)", geometric_mean_own_model_season2 )

##
## 2.2
## Produce a visualisation showing how likely you predict each team is to finish in each position.
##
## Solution: to predict the position of each team we will use the probability of outcomes
## we have before the second season.
##

def compute_season_outcome_probabilities(summary):
    n_teams = summary.shape[0]
    p_outcome_before_season = {}
    for i in range(n_teams - 1):
        print(i)
        for j in range(i + 1, n_teams):
            p_outcome_before_season[f"{i + 1}vs{j + 1}"] = calculate_outcome_probabilities(i, j, summary)
    return p_outcome_before_season


# Compute the outcome probability between all pairs of teams
p_outcome_before_season2 = compute_season_outcome_probabilities(summary)

# Compute expected points for the second season given the probability of outcome
# between teams at the end of the first season.
Expected_Points = []
for focal in range(1,28+1):
    points = 0
    for other in range(1,28+1):
        if focal < other:
            points += sum(p_outcome_before_season2[f"{focal}vs{other}"]*np.array([3,1,0]))
        if focal > other:
            points += sum(p_outcome_before_season2[f"{other}vs{focal}"]*np.array([0,1,3]))
    Expected_Points.append(points*2)

# Save results
teams["ExpectedPoints"] = Expected_Points
print(teams)

def ranking(points):
    # Return the position of each team
    # given their points.
    points_copy = points.copy()
    res = np.zeros(len(points_copy))
    pos = 1
    while np.sum(points_copy > 0) > 0:
        max_points = np.max(points_copy)
        # In this implementation, teams with the same number
        # of points will be in the same position, without
        # taking into account the difference of scores.
        max_teams = np.where(points_copy == max_points)[0]
        ties = len(max_teams) # number of ties
        for team in max_teams:
            res[team] = pos
        points_copy[max_teams] = 0
        pos += ties # update position number
    return res

def simulate_league(p_outcome_before_season2, n_teams=28):
    points = np.zeros(n_teams)
    for match, probs in p_outcome_before_season2.items(): # All pair of teams
        team1, team2 = map(lambda x: int(x) - 1, match.split('vs'))
        for _ in range(2): # Home and Away
            points1, points2 = simulate_match(probs)
            points[team1] += points1
            points[team2] += points2
    return points

def simulate_match(p_win_draw_lose):
    outcome = np.random.choice([3, 1, 0], p=p_win_draw_lose)
    if outcome == 3:
        return (3, 0)  # win for home team
    elif outcome == 1:
        return (1, 1)  # draw
    else:
        return (0, 3)  # win for away team


# Simulating the outcome of season 2 using the probabilities before season 2
n_teams = 28
n_simulations = 2000
finishing_positions = np.zeros((n_teams,n_teams))
#
for i in range(n_simulations):
    points = simulate_league(p_outcome_before_season2, n_teams)
    rank = ranking(points)
    print(i)
    for t in range(n_teams):
        finishing_positions[t,int(rank[t])-1] += 1

# Convert results to a DataFrame
finishing_df = pd.DataFrame(finishing_positions/n_simulations)
finishing_df.columns = [f'Position{i+1}' for i in range(n_teams)]
finishing_df.index = [f'Team{i+1}' for i in range(n_teams)]

# Sorting probabilities
finishing_df_sorted = finishing_df.sort_values(by=['Position1', 'Position28'], ascending=[False, True])

# Heat map of probabilities
plt.figure(figsize=(12, 8))
plt.imshow(finishing_df_sorted, cmap='viridis', aspect='auto')
plt.colorbar(label='Frequency of Finishing Position')
plt.xticks(ticks=np.arange(n_teams), labels=finishing_df_sorted.columns, rotation=90)
plt.yticks(ticks=np.arange(n_teams), labels=finishing_df_sorted.index)
plt.xlabel('Positions')
plt.ylabel('Teams')
plt.title('Heatmap of Team Finishing Positions')
plt.savefig("finishing_positions.pdf")

# Heat map of log(probabilities)
plt.figure(figsize=(12, 8))
plt.imshow(np.log(finishing_df_sorted), cmap='viridis', aspect='auto')
plt.colorbar(label='Log(Frequency of Finishing Position)')
plt.xticks(ticks=np.arange(n_teams), labels=finishing_df_sorted.columns, rotation=90)
plt.yticks(ticks=np.arange(n_teams), labels=finishing_df_sorted.index)
plt.xlabel('Positions')
plt.ylabel('Teams')
plt.title('Heatmap of Team Finishing Positions')
plt.savefig("finishing_positions_log.pdf")

# Save simulation
finishing_df_sorted.to_csv("finishing_positions.csv")

##
## 3 Anything Else
## Difference between the geometric mean of the odds and my own model
##
## Summary: The Odds

# Odds
normalizer = (1/odds.Home +  1/odds.Draw +  1/odds.Away)
odds_geometric_mean = np.exp((np.sum(np.log(1/odds[win].Home/normalizer[win])) + np.sum(np.log(1/odds[draw].Draw/normalizer[draw])) + np.sum(np.log(1/odds[lose].Away/normalizer[lose])))/(27*28*2))
print("Geometric Mean of Odds prediction", odds_geometric_mean)
geometric_mean_difference = geometric_mean_own_model_season2 - odds_geometric_mean
print("Difference geometric mean predictions", geometric_mean_difference )

## Miami Estimates
#mean_miami = np.array(summary.iloc[14,2:1511+3])
#std_miami = np.array(summary.iloc[14,1511+3:1511*2+4])
#plt.figure(figsize=(12, 8))
#plt.plot(range(len(mean_miami)), mean_miami, label='Mean', color='blue')
#plt.ylim(-2,2)
#plt.fill_between(list(range(len(mean_miami))), list(mean_miami - std_miami), list(mean_miami + std_miami),
                 #color='blue', alpha=0.2, label='1 Std Dev')
#plt.xlabel('Time')
#plt.ylabel('Value')
#plt.title('Mean with 1 Std Dev Band')
#plt.savefig("miami_estimate.pdf")
