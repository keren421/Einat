scoring_type = 'winner_gets_all'; % 'winner_gets_all', 'loser_dies_winner_gets_rest', 'loser_remains_winner_gets_rest'
type_resist = 'max'; % max , plus, resist
decay = 1;
start_rand = false;
Cost = [0.05 0.5] ; % resistance and production costs
Mut_prod = 0.5; % chance of a mutation affecting production 1-Pprod chance of affecting resistance ;
Mut_size = [-0.2 -0.2]; % average size of resistant and production mutations (typically should be <=0)
Mut_size_std = [0.2 0.2]; % standard deviation of resistant and production mutations
Mut_0 = [0.0 0.0] ; % chance of null mutations causing complete loss of resistant(1) or production(2) 
maxit = 1000; %1000 ; % max number of fixations 
switch 2
    case 1
        fig_num = 110;
        N = 2 ; % number of species
        K = 2 ; % number of antibiotics        
        maxit = 1000; % max number of fixations 
    case 2
        fig_num = 100;
        N = 8 ; % number of species
        K = 4 ; % number of antibiotics
        maxit = 4000;% max number of fixations 
end