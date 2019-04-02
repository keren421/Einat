figure(); hold all

%4 resistant, r = 0.4
ratio = [0 0.25 0.5 0.75 1];
time = [5031 4119 5775 1830 1584];
error = [928 458 2358 247 183];
errorbar(ratio, time, error,'displayname','4 resistant, r = 0.4');

%% 2 resistant, r = 0.4
ratio = [0 0.5 0.5 1 0];
time = [1945 1295 1395 951 1648];
error = [361 223 178 166 282];
errorbar(ratio, time, error,'displayname','2 resistant, r = 0.4');

%% 2 resistant, r = 0.25
ratio = [0 0.5 0.5 1 0];
time = [1945 1898 2268 1298 1648];
error = [361 316 334 132 282];
errorbar(ratio, time, error,'displayname','2 resistant, r = 0.25');


%% 1 resistant, r = 0.4
ratio = [0 1];
time = [1190 1366];
error = [204 164];
errorbar(ratio, time, error,'displayname','1 resistant, r = 0.4');

%% 1 resistant, r = 0.25
ratio = [0 1];
time = [1190 1440];
error = [204 254];
errorbar(ratio, time, error,'displayname','1 resistant, r = 0.25');