figure(); hold all;

% ratio = [0 0.33 0.67 1];
% time = [4277.055, 4259.64, 4429.85, 3779.84 ];
% error = [265.1686, 217.1045, 237.3676, 201.834];
% errorbar(ratio, time, error,'displayname','4 resistant,P = 1, R_1 = 1, r_rest = 1');

%%
figure();  hold all;

ratio = [0.25 0.5 0.75 1];
time = [4622.555, 4358.385, 4222.845, 4306.03];
error_all = [275.8345, 262.5399, 251.9596, 212.5119];
errorbar(ratio, time, error_all,'*','displayname','4 resistant,P = 1, R_1 = 1, r_rest = 1');

%%
hold all;

ratio = [0.25 0.5 0.75 1];
time = [5024.135, 4355.4, 4753.51, 4588.84];
error_all = [299.0021, 270.438, 299.8353, 252.289];
errorbar(ratio, time, error_all,'*','displayname','4 resistant,P = 1, R_1 = 1, r_rest = 0.5');

%%
hold all;

ratio = [0.33 0.67 1.0 0.33];
time = [4601.83, 4891.705, 4862.59, 4222.45];
error_all = [282.0832, 338.8723, 374.3504, 285.2131];
errorbar(ratio, time, error_all,'*','displayname','4 resistant,P = 1, R_1 = 1, r_rest = 0.5');
%%
hold all;

ratio = [0.33 0.67 1.0 0.33];
time = [4752.3, 4379.75, 4387.22, 4829.46];
error_all = [282.0832, 338.8723, 374.3504, 285.2131];
errorbar(ratio, time, error_all,'*','displayname','4 resistant,P = 1, R_1 = 1, r_rest = 1');

%%
figure(); hold all;

ratio = [0.2 0.4 0.6 0.8 1.0 0.2];
time = [4634.06, 3990.38, 4128.44, 4574.35, 5018.715, 4134.505];
error_all = [266.1778, 327.0484, 255.6639, 248.2072, 328.391, 274.1378];
errorbar(ratio, time, error_all,'*','displayname','5 resistant,P = 1, R_1 = 1, r_rest = 0.5');

%%
hold all;

ratio = [0.2 0.4 0.6 0.8 1.0];
time = [4345.52, 4527.365, 4488.625, 5066.12, 4557.69];
error_all = [257.1792, 291.0449, 257.0336, 318.3969, 275.2084];
errorbar(ratio, time, error_all,'*','displayname','5 resistant,P = 1, R_1 = 1, r_rest = 1');