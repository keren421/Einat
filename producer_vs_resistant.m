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
switch 5
    case 1
        fig_num = 100;
        N_P = 1 ; % number of resistants       
        N_R =1;
        maxit = 1000; % max number of fixations 
    case 2
        fig_num = 110;
        N_P = 1 ; % number of producers 
        N_R = 2; % number of resistants 
        maxit = 2000; % max number of fixations 
    case 3
        fig_num = 120;
        N_P = 1 ; % number of producers 
        N_R = 4; % number of resistants     
        maxit = 4000; % max number of fixations 
    case 4
        fig_num = 130;
        N_P = 1 ; % number of producers 
        N_R = 7; % number of resistants      
        maxit = 7000; % max number of fixations 
    case 5
        fig_num = 140;
        N_P = 1 ; % number of producers 
        N_R = 9; % number of resistants      
        maxit = 500; % max number of fixations 
    case 6
        fig_num = 145;
        N_P = 2 ; % number of producers 
        N_R = 4; % number of resistants     
        maxit = 3000; % max number of fixations 
end

%%
N= N_R + N_P;

if start_rand
    Phen = rand(N_P,2,N);
else
    Phen = zeros(N_P,2,N) ; %1:Res, 2:Production
end

load('saved_profiles\growth_curves_10000.mat')
t = 0 ; % number of cycles
it = 0 ; % number of fixation events
t_v = nan(maxit,1) ;
improvement = nan(maxit,1) ; %saves how beneficial was the mutation
Phen_v = nan(N_P,2,N,maxit) ; % keeps all phenotypes versus time
max_rounds = 1e8;
i_round = 0; 

%% run
cost_matrix = nan(N,N);
weight_matrix = nan(1,N);
weight_matrix(1,1:N_P) = 0.5/(N_P);
weight_matrix(1,N_P:N) = 0.5/(N_R);
for i = 1:N
    cost_matrix(i,i) = 0.5;
    for j= 1:i-1
        g1 = growth_rate(Phen(:,:,i), Cost);
        g2 = growth_rate(Phen(:,:,j), Cost);
        g = [g1,g2];
                
        [fastest_growth, faster_growing] = max(g);
        growth_ratio = g(3-faster_growing)/g(faster_growing);
        num_curve = find(r2>=growth_ratio,1,'first');
        
        cur_growth = [growth_curves{num_curve,1}*(1/fastest_growth), ...
                      growth_curves{num_curve,faster_growing+1}, ...
                      growth_curves{num_curve,4-faster_growing}];
                
        [y_i,y_j,~,~] = single_droplet(Phen(:,:,i),Phen(:,:,j),g,type_resist, scoring_type, decay, time_limit, cur_growth);
        cost_matrix(i,j) = y_i;
        cost_matrix(j,i) = y_j;
    end
end

%%
while (it<maxit)&&(t<max_rounds)
    for n = randi(2,1,2) %randperm(N)
        if n==1
            cur_n = randi([1, N_P]);
        else 
            cur_n = randi([N_P + 1, N]);
        end
        WT = Phen(:,:,cur_n) ;
        
        MT = WT ;
        % mutate
        if cur_n <= N_P
            p = 2; %production
            k = cur_n;
        else
            p = 1; %resistance
            k = randi(N_P);
        end
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
        for i = 1:N
            if 1 %i~=cur_n
                fWT = fWT + weight_matrix(i)*cost_matrix(cur_n,i);
                
                g1 = growth_rate(MT, Cost);
                g2 = growth_rate(Phen(:,:,i), Cost);
                g = [g1,g2];
 
                [fastest_growth, faster_growing] = max(g);
                growth_ratio = g(3-faster_growing)/g(faster_growing);
                num_curve = find(r2>=growth_ratio,1,'first');
                
                if (r2(num_curve)==1)&&(all(Phen(:,:,i)==0))&&(any(MT~=0))
                    MT(:)=0;
                    i =1;
                end
                cur_growth = [growth_curves{num_curve,1}*(1/fastest_growth), ...
                              growth_curves{num_curve,faster_growing+1}, ...
                              growth_curves{num_curve,4-faster_growing}];
                
                [y_i,y_j,~,~] = single_droplet(MT,Phen(:,:,i),g,type_resist, scoring_type, decay, time_limit, cur_growth);
                %[y1,y2,~,~] = single_droplet_with_solver(MT, Phen(:,:,i), g, type_resist, scoring_type, decay, time_limit);
                
                %if (y_i ~= y1)||(y_j~=y2)
                    %g
                %end
                M_cost_matrix(cur_n,i) = y_i;
                M_cost_matrix(i,cur_n) = y_j;

                fMT = fMT + weight_matrix(i)*y_i;
            end
        end

        % fixation
        threshold = fMT/fWT - 1;
    %         if fMT>=fWT
    %             1
    %         end
        if rand < threshold
            it = it + 1 ;
            Phen(:,:,cur_n) = MT ;
            Phen_v(:,:,:,it) = Phen ;
            t_v(it,1) = t ;
            improvement(it,1) = fMT/fWT ;
            cost_matrix = M_cost_matrix;
        else
            %threshold
        end
        
    	t = t + 0.5;
    end
    if ~mod(t,500), disp([t,it]); end
    if ~mod(t,500000)
        plotPhen(fig_num, N_P, N, Phen_v, t_v)
    end
end
if t>=max_rounds
    it = it + 1 ;
    Phen(:,:,cur_n) = wT ;
    Phen_v(:,:,:,it) = Phen ;
    t_v(it,1) = t ;
    improvement(it,1) = fMT/fWT ;
end
plotPhen(fig_num,N_P, N, Phen_v, t_v)
