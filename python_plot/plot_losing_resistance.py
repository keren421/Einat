import numpy as np
import matplotlib.pyplot as plt


total_data = []
data = {'ratio': [0.25, 0.5, 0.75, 1.0],
        'time': [4622.555, 4358.385, 4222.845, 4306.03],
        'error': [275.8345, 262.5399, 251.9596, 212.5119],
        'num_resistants' : 4,
        'P' : 1, 'R_1' : 1, 'R_rest': 1}
total_data.append(data)

data = {'ratio': [0.25, 0.5, 0.75, 1.0],
        'time': [5024.135, 4355.4, 4753.51, 4588.84],
        'error': [299.0021, 270.438, 299.8353, 252.289],
        'num_resistants' : 4,
        'P' : 1,  'R_1' : 1, 'R_rest': 0.5}
total_data.append(data)

data = {'ratio': [0.33, 0.67, 1.0],
        'time': [4601.83, 4891.705, 4862.59],
        'error': [282.0832, 338.8723, 374.3504],
        'num_resistants' : 3,
        'P' : 1,  'R_1' : 1, 'R_rest': 0.5}
total_data.append(data)

data = {'ratio': [0.33, 0.33, 0.67, 1.0],
        'time': [4752.3, 4829.46, 4379.75, 4387.22],
        'error': [282.0832, 285.2131, 338.8723, 374.3504],
        'num_resistants' : 3,
        'P' : 1,  'R_1' : 1, 'R_rest': 1}
total_data.append(data)

data = {'ratio': [0.2, 0.2, 0.4, 0.6, 0.8, 1.0],
        'time': [4634.06, 4134.505, 3990.38, 4128.44, 4574.35, 5018.715],
        'error': [266.1778, 274.1378, 327.0484, 255.6639, 248.2072, 328.391],
        'num_resistants' : 5,
        'P' : 1,  'R_1' : 1, 'R_rest': 0.5}
total_data.append(data)

data = {'ratio': [0.2, 0.4, 0.6, 0.8, 1.0],
        'time': [4345.52, 4527.365, 4488.625, 5066.12, 4557.69],
        'error': [257.1792, 291.0449, 257.0336, 318.3969, 275.2084],
        'num_resistants' : 5,
        'P' : 1,  'R_1' : 1, 'R_rest': 1}
total_data.append(data)

fig, ax = plt.subplots(figsize=(7, 4))
from matplotlib import cm
from matplotlib.colors import rgb2hex
spectral = cm.get_cmap('Dark2_r')
#Accent, Dark2, Dark2_r, GnBu, GnBu_r, Greens, Greens_r, Greys, Greys_r, OrRd, OrRd_r, Oranges, Oranges_r, PRGn, PRGn_r, Paired, Paired_r, Pastel1, Pastel1_r, Pastel2, Pastel2_r, PiYG, PiYG_r, PuBu, PuBuGn, PuBuGn_r, PuBu_r, PuOr, PuOr_r, PuRd, PuRd_r, Purples, Purples_r, RdBu, RdBu_r, RdGy, RdGy_r, RdPu, RdPu_r, RdYlBu, RdYlBu_r, RdYlGn, RdYlGn_r, Reds, Reds_r, Set1, Set1_r, Set2, Set2_r, Set3, Set3_r, Spectral, Spectral_r, Wistia, Wistia_r, YlGn, YlGnBu, YlGnBu_r, YlGn_r, YlOrBr, YlOrBr_r, YlOrRd, YlOrRd_r, afmhot, afmhot_r, autumn, autumn_r, binary, binary_r, bone, bone_r, brg, brg_r, bwr, bwr_r, cividis, cividis_r, cool, cool_r, coolwarm, coolwarm_r, copper, copper_r, cubehelix, cubehelix_r, flag, flag_r, gist_earth, gist_earth_r, gist_gray, gist_gray_r, gist_heat, gist_heat_r, gist_ncar, gist_ncar_r, gist_rainbow, gist_rainbow_r, gist_stern, gist_stern_r, gist_yarg, gist_yarg_r, gnuplot, gnuplot2, gnuplot2_r, gnuplot_r, gray, gray_r, hot, hot_r, hsv, hsv_r, inferno, inferno_r, jet, jet_r, magma, magma_r, nipy_spectral, nipy_spectral_r, ocean, ocean_r, pink, pink_r, plasma, plasma_r, prism, prism_r, rainbow, rainbow_r, seismic, seismic_r, spring, spring_r, summer, summer_r, tab10, tab10_r, tab20, tab20_r, tab20b, tab20b_r, tab20c, tab20c_r, terrain, terrain_r, twilight, twilight_r, twilight_shifted, twilight_shifted_r, viridis, viridis_r, winter, winter_r

colors_list = spectral(np.linspace(0,1,5))
for data in total_data:
    # example data
    x = data['ratio']
    y = data['time']
    y_error = data['error']
    label = 'N_r = ' + str(data['num_resistants']) + ', r = ' + str(data['R_rest'])
    if data['R_rest'] == 1:
        marker = 's'
    else:
        marker = 'o'

    # standard error bars
    ax.errorbar(x, y, yerr=y_error,
                marker=marker, markersize=8, linestyle='dotted', color=rgb2hex(colors_list[data['num_resistants']-1]),
                label=label)

# tidy up the figure
#ax.set_xlim((0, 5.5))
ax.set_title('Time of Resistance Loss')
ax.set_xlabel('#Resistant Strains/Total Strains')
ax.set_ylabel('Time [# mutations of producer]')
ax.legend()
plt.show()
fig.savefig('losing_resistance.png', transparent=True, dpi=80, bbox_inches="tight")