% syms x(t) y(t) lambda1 lambda2
% eqns = [diff(x,t) == lambda1*x*(1-x-y), diff(y,t) == lambda2*y*(1-x-y)];
% conds = [y(0) == 0.001, x(0) == 0.001];
% sol = dsolve(eqns, conds)
%%
production1 = 2;
production2 = 1;
resistance1 = 3;
resistance2 = 1000;
lambda1 = 2;
lambda2 = 0;
intial_pop =[1e-3; 1e-3];
bacteria_growth = @(t,y) [lambda1*y(1)*(1-y(1)-y(2)); ...
                          lambda2*y(2)*(1-y(1)-y(2))];

[t,y] = ode45(bacteria_growth,[0 20],intial_pop);
dndt = [gradient(y(:,1),t), ...
        gradient(y(:,2),t)];
concentration = cumtrapz(t,dndt(:,1)*production1 + dndt(:,2)*production2);
I = find(concentration>min(resistance1,resistance2),1,'first');

find_steady_t = @(lambda, eps, n0) (1/lambda)*log((1+n0*eps-eps-n0)/(n0*eps));
t1 = find_steady_t(lambda1, 1e-1, 1e-3)
t2 = find_steady_t(lambda2, 1e-1, 1e-3)
figure(2); clf;
title('Population over time')
plot(t,y); hold all;
plot(t,intial_pop(1)*exp(lambda1*t)./(1+intial_pop(1)*(exp(lambda1*t)-1)));
plot([t(I), t(I)],[y(I,1),y(I,2)],'*', 'displayname','''killing time''')
figure(3); clf;
title('Growth rate over time')
plot(t,dndt); hold all;
figure(1); clf; hold on;
title('concentration rate over time');
plot(t,concentration);
plot(t,y(:,1)*production1 + y(:,2)*production2);
plot(t(I),concentration(I),'*','displayname','Resistance');


