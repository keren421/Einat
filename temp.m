j = 50;
t_1 = growth_curves{j-1,1};
a_1 = growth_curves{j-1,2};
b_1 = growth_curves{j-1,3};
t_2 = growth_curves{j+2,1};
a_2 = growth_curves{j+2,2};
b_2 = growth_curves{j+2,3};
t_interp = unique([t_1;t_2],'sorted');

F = scatteredInterpolant([t_1;t_2], ...
    [r2(j-1)*ones(size(t_1));r2(j+1)*ones(size(t_1))], ...
    [a_1;a_2]);

a_interp = F(t_interp, r2(j)*ones(size(t_interp)));

figure(); hold on;
plot(t_1,a_1,'--b')
plot(t_2,a_2,'--b')
plot(growth_curves{j,1},growth_curves{j,2},'-k')
plot(t_interp,a_interp,'-r')