import numpy as np
import matplotlib.pyplot as plt


total_data = []
data = {'ratio': [0, 0.1429, 0.2857, 0.4286, 0.5714, 0.7143, 0.8571, 1.0],
        'time': [1933.645, 1772.21, 1443.585, 1374.935, 1226.66, 1069.96, 1155.52, 681.44],
        'error': [139.0318, 126.1837, 105.3513, 104.0944, 89.04468, 68.71419, 78.92554, 49.55671],
        'num_resistants' : 7,
        'resistance': 0.5}
total_data.append(data)

data = {'ratio': [0, 0.25, 0.5, 0.75, 1],
        'time': [1961.065, 1700.05, 1474.315, 1069.715, 582.675],
        'error': [131.98, 119.8835, 106.944, 62.29, 41.3566],
        'num_resistants' : 4,
        'resistance': 0.5}
total_data.append(data)

data = {'ratio': [0, 0.5, 1],
        'time': [1751.58, 1250.07, 592.91],
        'error': [117.57, 76.62, 41.58],
        'num_resistants' : 2,
        'resistance': 0.5}
total_data.append(data)

data = {'ratio': [0, 1],
        'time': [1659.99, 577.585],
        'error': [132.367, 37.82],
        'num_resistants' : 1,
        'resistance': 0.5}
total_data.append(data)

data = {'ratio': [0, 0.25, 0.5, 0.75, 1],
        'time': [3309.92, 2840.905, 2228.52, 1776.555, 1007.39],
        'error': [135.6044, 129.9645, 99.97926, 84.25126, 62.05427],
        'num_resistants' : 4,
        'resistance': 1}
total_data.append(data)

data = {'ratio': [0, 0.5, 1],
        'time': [3219.83, 2470.895, 910.135],
        'error': [154.3232, 109.5544, 59.0689],
        'num_resistants' : 2,
        'resistance': 1}
total_data.append(data)

data = {'ratio': [0, 1],
        'time': [3275.1, 878.5],
        'error': [143.929, 55.8208],
        'num_resistants' : 1,
        'resistance': 1}
total_data.append(data)

fig, ax = plt.subplots(figsize=(7, 4))
from matplotlib import cm
from matplotlib.colors import rgb2hex
spectral = cm.get_cmap('Set1')
colors_list = spectral(np.linspace(0,1,10))
for data in total_data:
    # example data
    x = data['ratio']
    y = data['time']
    y_error = data['error']
    label = 'N_r = ' + str(data['num_resistants']) + ', r = ' + str(data['resistance'])
    if data['resistance'] == 1:
        marker = 's'
    else:
        marker = 'o'

    # standard error bars
    ax.errorbar(x, y, yerr=y_error,
                marker=marker, markersize=8, linestyle='dotted', color=rgb2hex(colors_list[data['num_resistants']]),
                label=label)

# tidy up the figure
#ax.set_xlim((0, 5.5))
ax.set_title('Time for Losing Production')
ax.set_xlabel('#Resistant Strains/Total Strains')
ax.set_ylabel('Time for Losing Production')
ax.legend()
plt.show()
fig.savefig('going_down.png', transparent=True, dpi=80, bbox_inches="tight")