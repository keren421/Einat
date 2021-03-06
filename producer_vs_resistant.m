%% setup
scoring_type = 'loser_dies_winner_gets_rest'; % 'winner_gets_all', 'loser_dies_winner_gets_rest', 'loser_remains_winner_gets_rest'
type_resist = 'max'; % max , plus, resist
decay = 1;
start_option = 'zero'; % zero, rand, chosen
Cost = [0.005 0.01] ; % resistance and production costs
Mut_size = [0 -0.05]; % average size of resistant and production mutations (typically should be <=0)
Mut_size_std = [0.1 0.1]; % standard deviation of resistant and production mutations
Mut_0 = [0.01 0.01] ; % chance of null mutations causing complete loss of resistant(1) or production(2) 
minimal_phen = [0.01  0];
time_limit = 0.8; %0.8;
stop_flag_num_peak = 0;
if stop_flag_num_peak
    already_produced = 0;
    still_prducting = 0;
else
    still_prducting = 0; 
end
switch 3
    case 1
        fig_num = 100;
        N_P = 1 ; % number of resistants       
        N_R = 1;
        maxit = 1000; % max number of fixations 
    case 2
        fig_num = 110;
        N_P = 1 ; % number of producers 
        N_R = 2; % number of resistants 
        maxit = 1000; % max number of fixations 
    case 3
        fig_num = 170;
        N_P = 1 ; % number of producers 
        N_R = 4; % number of resistants     
        maxit = 4000; % max number of fixations 
    case 4
        fig_num = 150;
        N_P = 1 ; % number of producers 
        N_R = 7; % number of resistants      
        maxit = 1000; % max number of fixations 
    case 5
        fig_num = 140;
        N_P = 1 ; % number of producers 
        N_R = 9; % number of resistants      
        maxit = 9000; % max number of fixations 
    case 6
        fig_num = 145;
        N_P = 2 ; % number of producers 
        N_R = 4; % number of resistants     
        maxit = 3000; % max number of fixations 
end
%%
if strcmp(start_option,'chosen')
    intial_production = 0.5*ones(N_P,1);
    intial_resistance = 0.4*ones(N_R,1);
    intial_resistance(1) = 0.4 ;%0.25; % 0.25 - resistant to 0.5
    intial_resistance(2) = 0.4 ;%0.25; % 0.25 - resistant to 0.5
    intial_resistance(3) = 0.4 ;%0.25; % 0.25 - resistant to 0.5
end
%%
dt_print = 1000;
dt_view = 10000;
%%
N= N_R + N_P;

switch start_option
    case 'rand'
        Phen = rand(N_P,2,N);
    case 'zero'
        Phen = zeros(N_P,2,N) ; %1:Res, 2:Production
        Phen(:,1,N_P+1:N) = minimal_phen(1); %1:Res, 2:Production
    case 'chosen'
        Phen = zeros(N_P,2,N) ; %1:Res, 2:Production
        Phen(:,2,1:N_P) = intial_production; %1:Res, 2:Production
        Phen(:,1,N_P+1:N) = intial_resistance; %1:Res, 2:Production
end

load('saved_profiles\growth_curves_10000.mat')
t = 0 ; % number of cycles
it = 1 ; % number of fixation events
t_v = nan(maxit,1) ;
improvement = nan(maxit,1) ; %saves how beneficial was the mutation
Phen_v = nan(N_P,2,N,maxit) ; % keeps all phenotypes versus time
Phen_v(:,:,:,it) = Phen ; 
t_v(it,1) = t ;
max_rounds = 2e5;
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
            p = 2; %production
            k = cur_n;
        else 
            cur_n = 2; %randi([N_P + 1, N]);
            p = 1; %resistance
            k = randi(N_P);
        end
        WT = Phen(:,:,cur_n) ;
        MT = WT ;
        % mutate
        P0 = MT(k,p) ;
        P0 = P0 + Mut_size(p) + Mut_size_std(p)*randn ; 
        P0 = P0 * (rand>Mut_0(p));
        MT(k,p) = max(P0,minimal_phen(p));

        if all(all(WT == MT))
            continue;
        end
        % calc average fitness
        fWT = 0 ;
        fMT = 0 ;
        M_cost_matrix = cost_matrix;
        for i = 1:N
            if i~=cur_n
                fWT = fWT + weight_matrix(i)*cost_matrix(cur_n,i);
                
                g1 = growth_rate(MT, Cost);
                g2 = growth_rate(Phen(:,:,i), Cost);
                g = [g1,g2];
 
                [fastest_growth, faster_growing] = max(g);
                growth_ratio = g(3-faster_growing)/g(faster_growing);
                num_curve = find(r2>=growth_ratio,1,'first');
                
                if growth_ratio == r2(num_curve)
                    cur_growth = [growth_curves{num_curve,1}*(1/fastest_growth), ...
                                  growth_curves{num_curve,faster_growing + 1}, ...
                                  growth_curves{num_curve,4 - faster_growing}];
                else
                    t_after = growth_curves{num_curve,1};
                    faster_after = growth_curves{num_curve,faster_growing + 1};
                    slower_after = growth_curves{num_curve,4 - faster_growing};
                    t_before = growth_curves{num_curve-1,1};
                    faster_before = growth_curves{num_curve-1,faster_growing + 1};
                    faster_before = interp1(t_before,faster_before,t_after);
                    slower_before = growth_curves{num_curve-1,4 - faster_growing};
                    slower_before = interp1(t_before,slower_before,t_after);

                    faster_interp = (faster_before*(r2(num_curve)-growth_ratio) + ...
                                    faster_after*(growth_ratio-r2(num_curve-1)))/(r2(num_curve) - r2(num_curve-1));

                    slower_interp = (slower_before*(r2(num_curve)-growth_ratio) + ...
                                    slower_after*(growth_ratio-r2(num_curve-1)))/(r2(num_curve) - r2(num_curve-1));

                    cur_growth = [t_after*(1/fastest_growth), ...
                                  faster_interp, ...
                                  slower_interp];
                end
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
    if ~mod(t,dt_print), disp([t,it]); end
    if ~mod(t,dt_view)
        plotPhen(fig_num, N_P, N, Phen_v, t_v)
    end
    
    if ~still_prducting && stop_flag_num_peak && any(Phen(:,2,1:N_P)>2*Mut_size_std(2))
        already_produced = already_produced + 1;
        still_prducting = 1;
    end
    if still_prducting  && all(Phen(:,2,1:N_P)<Mut_size_std(2))
        still_prducting = 0;
        if already_produced>=stop_flag_num_peak
            break
        end
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
