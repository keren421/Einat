syms x(t) y(t) lambda1 lambda2
eqns = [diff(x,t) == lambda1*x*(1-x-y), diff(y,t) == lambda2*y*(1-x-y)];
conds = [y(0) == 0.001, x(0) == 0.001];
sol = dsolve(eqns, conds)
%%
production1 = 1;
production2 = 0.95;
resistance1 = 2;
resistance2 = 3;
lambda1 = 1;
lambda2 = 0.95;

bacteria_growth = @(t,y) [lambda1*y(1)*(1-y(1)-y(2)); ...
                          lambda2*y(2)*(1-y(1)-y(2))];
[t,y] = ode45(bacteria_growth,[0 20],[1e-3; 1e-3]);
concentration = cumtrapz(t,y(:,1)*production1 + y(:,2)*production2);
figure(1); clf; plot(t,concentration);
figure(1); hold on; plot(t(I),concentration(I),'*','displayname','Resistance');
I = find(concentration>min(resistance1,resistance2),1,'first');
figure(2); clf;
plot(t,y); hold all;
plot([t(I), t(I)],[y(I,1),y(I,2)],'*', 'displayname','''killing time''')


