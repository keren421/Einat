figure(); hold all

%% 4 resistant, r = 0.4
ratio = [0, 0.1429, 0.2857, 0.4286, 0.5714, 0.7143, 0.8571, 1.0];
time = [1933.645, 1772.21, 1443.585, 1374.935, 1226.66, 1069.96, 1155.52, 681.44];
error = [139.0318, 126.1837, 105.3513, 104.0944, 89.04468, 68.71419, 78.92554, 49.55671];
errorbar(ratio, time, error,'displayname','7 resistant, r = 0.5');
%% 4 resistant, r = 0.4
ratio = [0 0.25 0.5 0.75 1];
time = [1961.065 1700.05 1474.315 1069.715 582.675];
error = [131.98 119.8835 106.944 62.29 41.3566];
errorbar(ratio, time, error,'displayname','4 resistant, r = 0.5');

%% 2 resistant, r = 0.5
ratio = [0 0.5 1 ];
time = [1751.58 1250.07 592.91];
error = [117.57 76.62 41.58];
errorbar(ratio, time, error,'displayname','2 resistant, r = 0.5');

%% 1 resistant, r = 0.5
ratio = [0 1];
time = [1659.99 577.585];
error = [132.367 37.82];
errorbar(ratio, time, error,'displayname','1 resistant, r = 0.5');
%% 4 resistant, p = 1, r = 1
ratio = [0 0.25 0.5 0.75 1];
time = [3309.92, 2840.905, 2228.52, 1776.555, 1007.39];
error = [135.6044, 129.9645, 99.97926, 84.25126, 62.05427];
errorbar(ratio, time, error,'displayname','4 resistant, p = 1, r = 1');


%% 2 resistant, r = 0.5
ratio = [0 0.5 1 ];
time = [3219.83, 2470.895, 910.135];
error = [154.3232, 109.5544, 59.0689];
errorbar(ratio, time, error,'displayname','2 resistant, p = 1, r = 1');

%% 1 resistant, p = 1, r = 1
ratio = [0 1];
time = [3275.1, 878.5];
error = [143.929, 55.8208];
errorbar(ratio, time, error,'displayname','1 resistant, p=1, r = 1');

