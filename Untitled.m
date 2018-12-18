Cost = [0.005 0.01];
time_limit = 0.99;
decay = 1;
scoring_type = 'loser_dies_winner_gets_rest';
type_resist = 'max';
production = 0.5;

producer = [0 production]; 
resistant = [0 0];

g1 = growth_rate(producer, Cost);
g2 = growth_rate(resistant, Cost);
g = [g1,g2];
single_droplet_with_solver(producer,resistant, g, type_resist, scoring_type, decay, time_limit)