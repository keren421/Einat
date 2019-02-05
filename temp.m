j = 5000;
growth_ratio = r2(j);
dj_up = 500;
dj_down = 50;
t_after = growth_curves{j+dj_up,1};
faster_after = growth_curves{j+dj_up,2};
slower_after = growth_curves{j+dj_up,3};
t_before = growth_curves{j-dj_down,1};
faster_before = growth_curves{j-dj_down,2};
faster_before = interp1(t_before,faster_before,t_after);
slower_before = growth_curves{j-dj_down,3};
slower_before = interp1(t_before,slower_before,t_after);

faster_interp = (faster_before*(r2(j+dj_up)-growth_ratio) + ...
                faster_after*(growth_ratio-r2(j-dj_down)))/(r2(j+dj_up) - r2(j-dj_down));

slower_interp = (slower_before*(r2(j+dj_up)-growth_ratio) + ...
                slower_after*(growth_ratio-r2(j-dj_down)))/(r2(j+dj_up) - r2(j-dj_down));



figure(); hold on;
plot(t_after,faster_after,'--b')
plot(t_before,faster_before,'--b')
plot(growth_curves{j,1},growth_curves{j,2},'-k')
plot(t_after,faster_interp,'-r')

figure(); hold on;
plot(t_after,slower_after,'--b')
plot(t_before,slower_before,'--b')
plot(growth_curves{j,1},growth_curves{j,3},'-k')
plot(t_after,slower_interp,'-r')