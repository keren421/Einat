%% setup
scoring_type = 'loser_remains_winner_gets_rest'; % 'winner_gets_all', 'loser_dies_winner_gets_rest', 'loser_remains_winner_gets_rest'
type_resist = 'max'; % max , plus, resist
decay = 1;
start_rand = false;
Cost = [0.05 0.5] ; % resistance and production costs
Mut_prod = 0.5; % chance of a mutation affecting production 1-Pprod chance of affecting resistance ;
Mut_size = [-0.2 -0.2]; % average size of resistant and production mutations (typically should be <=0)
Mut_size_std = [0.2 0.2]; % standard deviation of resistant and production mutations
Mut_0 = [0.1 0.1] ; % chance of null mutations causing complete loss of resistant(1) or production(2) 
maxit = 1000; %1000 ; % max number of fixations 
switch 2
    case 1
        fig_num = 100;
        N = 2 ; % number of species
        K = 2 ; % number of antibiotics        
        maxit = 1000; % max number of fixations 
    case 2
        fig_num = 110;
        N = 8 ; % number of species
        K = 4 ; % number of antibiotics
        maxit = 4000;% max number of fixations 
    case 3
        fig_num = 120;
        N = 8 ; % number of species
        K = 2 ; % number of antibiotics
        maxit = 4000;% max number of fixations 
end

%%
if start_rand
    Phen = rand(k,2,N);
else
    Phen = zeros(K,2,N) ; %1:Res, 2:Production
end

t = 0 ; % number of cycles
it = 0 ; % number of fixation events
t_v = nan(maxit,1) ;
improvement = nan(maxit,1) ; %saves how beneficial was the mutation
Phen_v = nan(K,2,N,maxit) ; % keeps all phenotypes versus time
max_rounds = 1e6;
i_round = 0; 

%% run
cost_matrix = nan(N,N);
production_resistance = nan(K,N);
for i = 1:N
    for j= 1:i-1
        [y_i,y_j,pr_i,pr_j] = single_droplet(Phen(:,:,i),Phen(:,:,j),Cost,type_resist, scoring_type, decay);
        cost_matrix(i,j) = y_i;
        cost_matrix(j,i) = y_j;
        production_resistance(:,i) = pr_i;
        production_resistance(:,j) = pr_j;
    end
end

while (it<maxit)&&(t<max_rounds)
    for n = randperm(N) 
        WT = Phen(:,:,n) ;
        MT = WT ;
        k = randi(K) ; % chose number of antibiotic to mutate
        p = (rand>Mut_prod) + 1 ; % choose mutating production or resistance
        % mutate
        P0 = MT(k,p) ;
        P0 = P0 + Mut_size(p) + Mut_size_std(p)*randn ; 
        P0 = P0 * (rand>Mut_0(p));
        MT(k,p) = max(P0,0) ;
      
        if all(all(WT == MT))
            continue;
        end
        % calc average fitness
        fWT = 0 ;
        fMT = 0 ;
        M_cost_matrix = cost_matrix;
        M_production_resistance = production_resistance;
        for i = 1:N
            if i~=n
                fWT = fWT + cost_matrix(n,i);
                
                [y_i,y_j,pr_i,~] = single_droplet(MT,Phen(:,:,i),Cost,type_resist, scoring_type, decay);
                M_cost_matrix(n,i) = y_i;
                M_cost_matrix(i,n) = y_j;
                M_production_resistance(:,n) = pr_i;
                
                fMT = fMT + y_i;
            end
        end
        
        % fixation
        threshold = fMT/fWT - 1;
%         if fMT>=fWT
%             1
%         end
        if rand < threshold
            it = it + 1 ;
            Phen(:,:,n) = MT ;
            Phen_v(:,:,:,it) = Phen ;
            t_v(it,1) = t ;
            improvement(it,1) = fMT/fWT ;
            cost_matrix = M_cost_matrix;
            production_resistance = M_production_resistance;
        end
    end
    t = t + 1 ;
    if ~mod(t,500), disp([t,it]); end
    if ~mod(t,50000)
        plotPhen(fig_num, K, N, Phen_v, t_v)
    end
end
if t>=max_rounds
    it = it + 1 ;
    Phen(:,:,n) = MT ;
    Phen_v(:,:,:,it) = Phen ;
    t_v(it,1) = t ;
    improvement(it,1) = fMT/fWT ;
end
plotPhen(fig_num, K, N, Phen_v, t_v)
%% plot
