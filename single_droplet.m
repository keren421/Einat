function [y1,y2] = single_droplet(P1,P2,cost,type_resist,type)
    eps = 1e-6; %integral is computed until population 1-eps 
    intial_pop = 1e-3;
    
    f1 = fitness(P1,cost) ;
    f2 = fitness(P2,cost) ;
    switch type_resist
        case 'max'
            R1 = max(P1(:,2),P1(:,1));
            R2 = max(P2(:,2),P2(:,1));
        case 'plus'
            R1 = P1(:,2) + P1(:,1);
            R2 = P2(:,2) + P2(:,1);
        case 'resist'
            R1 = P1(:,1);
            R2 = P2(:,1);
    end
                    
    num_antibiotics = length(P1(:,1));
    
    find_steady_t = @(lambda, eps, n0) (1/lambda)*log((1+n0*eps-eps-n0)/(n0*eps));
    t1 = find_steady_t(f1, eps, intial_pop);
    t2 = find_steady_t(f2, eps, intial_pop);
    max_t = min(t1,t2) ;
    
    bacteria_growth = @(t,y) [f1*y(1)*(1-y(1)-y(2)); ...
                              f2*y(2)*(1-y(1)-y(2))];
    % try rewtitting as d[logy]/dt
    [t,y] = ode45(bacteria_growth,[0 max_t],[intial_pop; intial_pop]);
    t_min = inf;
    overall_losing_bacteria = nan;
    pop_size = y(end,:) ;
    for i = 1:num_antibiotics
        %concentration = cumtrapz(t,y(:,1)* P1(i,2) + y(:,2)*P2(i,2));
        concentration = y(:,1)* P1(i,2) + y(:,2)*P2(i,2);
        [resistance, most_sensitive] = min([R1(i),R2(i)]);
        I = find(concentration>resistance,1,'first');
        if ~isempty(I) && t(I)<t_min
            t_min = t(I);
            pop_size = y(I,:);
            overall_losing_bacteria = most_sensitive;
        end
    end
    if ~isnan(overall_losing_bacteria)
        overall_winning_bacteria = 3 - overall_losing_bacteria ;
        switch type
            case 'winner_gets_all'
                pop_size(overall_losing_bacteria) = 0;
                pop_size(overall_winning_bacteria) = 1;
            case 'loser_dies_winner_gets_rest'
                pop_size(overall_winning_bacteria) = 1 - pop_size(overall_losing_bacteria);
                pop_size(overall_losing_bacteria) = 0;
            case 'loser_remains_winner_gets_rest'
                pop_size(overall_winning_bacteria) = 1 - pop_size(overall_losing_bacteria);
        end
    end
    y1 = pop_size(1);
    y2 = pop_size(2);
end


function f = fitness(P,cost)
%any reason to do it with exp or just random choice?
f = exp(-sum(P(:,1)*cost(1) + P(:,2)*cost(2))) ;
end
