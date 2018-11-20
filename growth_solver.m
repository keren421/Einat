% syms x(t) y(t) lambda1 lambda2
% eqns = [diff(x,t) == lambda1*x*(1-x-y), diff(y,t) == lambda2*y*(1-x-y)];
% conds = [y(0) == 0.001, x(0) == 0.001];
% sol = dsolve(eqns, conds)
%%
lambdas_1 = 1; %linspace(1e-3,1,5);
lambdas_2 = linspace(1e-3,1,10000);
n0 = 1e-3;
fig_num = 1;
growth_curves = cell(length(lambdas_2),2);
%bacteria_growth_single = @(t,y) lambda1*y*(1-y);
% concentration = y(:,1)*production1 + y(:,2)*production2;
% I = find(concentration>min(resistance1,resistance2),1,'first');
for i_1 = 1:length(lambdas_1)
    for i_2 = 1:length(lambdas_2)
        lambda1 =lambdas_1(i_1);
        lambda2 = lambdas_2(i_2);
        
        
        bacteria_growth = @(t,y) [lambda1*y(1)*(1-y(1)-y(2)); ...
                                  lambda2*y(2)*(1-y(1)-y(2))];
                      
        find_steady_t = @(lambda, eps, n0) (1/lambda)*log((1+n0*eps-eps-n0)/(n0*eps));
        t1 = find_steady_t(lambda1, 1e-3, n0);
        t2 = find_steady_t(lambda2, 1e-3, n0);

        [t,y] = ode45(bacteria_growth,[0 min(t1,t2)],[n0, n0]);
        y1 = y(:,1);
        y2 = y(:,2);
        growth_curves{i_2,1} = t;
        growth_curves{i_2,2} = y1;
        growth_curves{i_2,3} = y2;
        
%        figure(fig_num); clf; hold all;
%        title(['lambda1 = ' num2str(lambda1) ',lambda2 = ' num2str(lambda2)])
%         [k1,r1] = fitLogisticGrowth(t,y(:,1),n0,lambda1,fig_num)
%         [k2,r2] = fitLogisticGrowth(t,y(:,2),n0,lambda2,fig_num)
        fig_num = fig_num + 1;
    end
end
r2 = lambdas_2;
%%
clear all
load('saved_profiles\growth_curves.mat')
g1 = 0.9996;
g2 = 0.8;
g = [g1,g2];
n0 = 1e-3;

bacteria_growth = @(t,y) [g1*y(1)*(1-y(1)-y(2)); ...
                          g2*y(2)*(1-y(1)-y(2))];

find_steady_t = @(lambda, eps, n0) (1/lambda)*log((1+n0*eps-eps-n0)/(n0*eps));
t1 = find_steady_t(g1, 1e-3, n0);
t2 = find_steady_t(g2, 1e-3, n0);
[T,Y] = ode45(bacteria_growth,[0 min(t1,t2)],[n0, n0]);    
figure(1);clf; plot(T,Y(:,1));  
figure(2); clf; plot(T,Y(:,2));
pause(1);
[fastest_growth, faster_growing] = max(g);
growth_ratio = g(3-faster_growing)/g(faster_growing);
num_curve = find(r2>=growth_ratio,1,'first');

cur_growth = [growth_curves{num_curve,1}*(1/fastest_growth), growth_curves{num_curve,faster_growing+1}, growth_curves{num_curve,4-faster_growing}];

figure(1);hold all; plot(cur_growth(:,1),cur_growth(:,2));  
figure(2);hold all; plot(cur_growth(:,1),cur_growth(:,3));
                
%%
function [k,r] = fitLogisticGrowth(t, y, n0, lambda, fig_num)
    [xData, yData] = prepareCurveData( t, y );

    % Set up fittype and options.
    ft = fittype( ['k/(1+((k-' num2str(n0) ')/' num2str(n0) ')*exp(-r*t))'], 'independent', 't', 'dependent', 'y' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.StartPoint = [0.5 lambda];

    % Fit model to data.
    [fitresult, gof] = fit( xData, yData, ft, opts );
    coeff = coeffvalues(fitresult);
    k = coeff(1);
    r = coeff(2);
    % Plot fit with data.
    figure(fig_num); hold all;
    h = plot( fitresult, xData, yData );
    legend( h, 'y1 vs. t', 'fit result', 'Location', 'NorthEast' );
    % Label axes
    xlabel('t')
    grid on
end