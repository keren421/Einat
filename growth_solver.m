% syms x(t) y(t) lambda1 lambda2
% eqns = [diff(x,t) == lambda1*x*(1-x-y), diff(y,t) == lambda2*y*(1-x-y)];
% conds = [y(0) == 0.001, x(0) == 0.001];
% sol = dsolve(eqns, conds)
%%
lambdas_1 = linspace(1e-3,1,5);
lambdas_2 = linspace(1e-3,1,5);
n0 = 1e-3;

%bacteria_growth_single = @(t,y) lambda1*y*(1-y);
% concentration = y(:,1)*production1 + y(:,2)*production2;
% I = find(concentration>min(resistance1,resistance2),1,'first');
for i_1 = 1:length(lambdas_1)
    for i_2 = 1:length(lambdas_2)
        lambda1 = lambdas_1(i_1);
        lambda2 = lambdas_2(i_2);
        
        
        bacteria_growth = @(t,y) [lambda1*y(1)*(1-y(1)-y(2)); ...
                                  lambda2*y(2)*(1-y(1)-y(2))];
                      
        find_steady_t = @(lambda, eps, n0) (1/lambda)*log((1+n0*eps-eps-n0)/(n0*eps));
        t1 = find_steady_t(lambda1, 1e-3, n0);
        t2 = find_steady_t(lambda2, 1e-3, n0);

        [t,y] = ode45(bacteria_growth,[0 min(t1,t2)],[n0, n0]);
        [k1,r1] = fitLogisticGrowth(t,y(:,1),n0)
        [k2,r2] = fitLogisticGrowth(t,y(:,2),n0)
    end
end

%%
function [k,r] = fitLogisticGrowth(t,y,n0)
    [xData, yData] = prepareCurveData( t, y );

    % Set up fittype and options.
    ft = fittype( ['k/(1+((k-' num2str(n0) ')/' num2str(n0) ')*exp(-r*t))'], 'independent', 't', 'dependent', 'y' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.StartPoint = [0.5 1];

    % Fit model to data.
    [fitresult, gof] = fit( xData, yData, ft, opts );
    coeff = coeffvalues(fitresult);
    k = coeff(1);
    r = coeff(2);
    % Plot fit with data.
    figure();
    h = plot( fitresult, xData, yData );
    legend( h, 'y1 vs. t', 'fit result', 'Location', 'NorthEast' );
    title('Population over time')
    % Label axes
    xlabel('t')
    grid on
end