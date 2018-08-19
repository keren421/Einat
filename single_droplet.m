function [y1,y2] = single_droplet(P1,P2,cost,type)
    f1 = fitness(P1,cost) ;
    f2 = fitness(P2,cost) ;
    R1 = max(P1(:,2),P1(:,1));
    R2 = max(P2(:,2),P2(:,1));
    num_antibiotics = length(P1(:,1));
    max_t = 20;
    bacteria_growth = @(t,y) [f1*y(1)*(1-y(1)-y(2)); ...
                              f2*y(2)*(1-y(1)-y(2))];
    [t,y] = ode45(bacteria_growth,[0 max_t],[1e-3; 1e-3]);
    t_min = inf;
    pop_size = nan(1,2);
    losing_bacteria = nan;
    for i = 1:num_antibiotics
        concentration = cumtrapz(t,y(:,1)* P1(i,2) + y(:,2)*P2(i,2));
        [resistance, sensitive_type] = min([R1(i),R2(i)]);
        I = find(concentration>resistance,1,'first');
        if  isempty(I)
            I = length(t);
            sensitive_type =nan;
        end
        if t(I) <t_min
            t_min = t(I);
            pop_size = y(I,:);
            losing_bacteria = sensitive_type;
            if losing_bacteria ==1
                winning_bacteria = 2;
            elseif losing_bacteria ==2
                winning_bacteria = 1;
            else
                winning_bacteria = nan;
            end
        end
    end
    if isnan(losing_bacteria)
        y1 = y(end,1);
        y2 = y(end,2);
        return;
    end
        
    switch type
        case 'winner_gets_all'
            pop_size(losing_bacteria) = 0;
            pop_size(winning_bacteria) = 1;
        case 'loser_dies_winner_gets_rest'
            pop_size(winning_bacteria) = 1 - pop_size(losing_bacteria);
            pop_size(losing_bacteria) = 0;
        case 'loser_remains_winner_gets_rest'
            pop_size(winning_bacteria) = 1 - pop_size(losing_bacteria);
    end
    
    y1 = pop_size(1);
    y2 = pop_size(2);
end


function f = fitness(P,cost)
%any reason to do it with exp or just random choice?
f = exp(-sum(P(:,1)*cost(1) + P(:,2)*cost(2))) ;
end
