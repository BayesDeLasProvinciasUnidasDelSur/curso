import numpy as np
import networkx as nx
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv("data/redAAGo.csv")
data = data.iloc[0:100,:]
data['started'] = pd.to_datetime(data['started'])
reference_date = pd.to_datetime('2001-01-01')

data['started'] = (data['started'] - reference_date).dt.months
data['w'] = [str(row['white']) + "-" + str(row['started']) for _, row in data.iterrows() ]

data.iloc[1,:]

# Crea un nuevo grafo bipartito
G = nx.Graph()

# Agrega nodos de los partidos
G.add_nodes_from(data.index, bipartite=0)

# Agrega nodos de los jugadores
players = set(data['black']).union(set(data['white']))
G.add_nodes_from(players, bipartite=1)

# Agrega las aristas entre los partidos y los jugadores
for _, row in data.iterrows():
    G.add_edge(row.name, row['black'])
    G.add_edge(row.name, row['white'])
    print(row.name)



node_colors = {0: 'lightblue', 1: 'lightgreen'}

# Dibuja la red bipartita
nx.draw(G, node_color=[node_colors[G.nodes[node]['bipartite']] for node in G.nodes], node_size=500, font_size=8, edge_color='gray')


# Muestra el plot
plt.show()

# Muestra el pl
