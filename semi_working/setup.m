%% setup
scoring_type = 'loser_dies_winner_gets_rest'; % 'winner_gets_all', 'loser_dies_winner_gets_rest', 'loser_remains_winner_gets_rest'
type_resist = 'max'; % max , plus, resist
decay = 1;
start_rand = false;
Cost = [0.005 0.01] ; % resistance and production costs
Mut_size = [0 -0.05]; % average size of resistant and production mutations (typically should be <=0)
Mut_size_std = [0.1 0.1]; % standard deviation of resistant and production mutations
Mut_0 = [0 0] ; % chance of null mutations causing complete loss of resistant(1) or production(2) 
maxit = 1000; %1000 ; % max number of fixations 
time_limit = 0.99;
switch 3
    case 1
        fig_num = 100;
        N = 2 ; % number of resistants       
        maxit = 1000; % max number of fixations 
    case 2
        fig_num = 110;
        N = 3 ; % number of resistants       
        maxit = 1000; % max number of fixations 
    case 3
        fig_num = 120;
        N = 5 ; % number of resistants       
        maxit = 1000; % max number of fixations 
end