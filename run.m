%% setup
switch 1
    case 1
        start_rand = false;
        N = 2 ; % number of species
        K = 1 ; % number of antibiotics
        Cost = [0.5 0.5] ; % resistance and production costs
        Mut_prod = 0.5; % chance of a mutation affecting production 1-Pprod chance of affecting resistance ;
        Mut_size = [-0.05 -0.05]; % average size of resistant and production mutations (typically should be <=0)
        Mut_size_std = [0.05 0.05]; % standard deviation of resistant and production mutations
        Mut_0 = [0 0] ; % chance of null mutations causing complete loss of resistant(1) or production(2) 
    case 2
        start_rand = false;
        N = 8 ; 
        K = 4 ; 
        Cost = [0.5 0.5] ; 
        Mut_prod = 0.5; 
        Mut_size = [0 0]; 
        Mut_size_std = [0.05 0.05]; 
        Mut_0 = [0 0] ; 
end

%%
if start_rand
    Phen = rand(k,2,N);
else
    Phen = zeros(K,2,N) ; %1:Res, 2:Production
end

t = 0 ; % number of cycles
it = 0 ; % number of fixation events
maxit = 1000; %1000 ; % max number of fixations 
t_v = nan(maxit,1) ;
improvement = nan(maxit,1) ; %saves how beneficial was the mutation
Phen_v = nan(K,2,N,maxit) ; % keeps all phenotypes versus time
max_rounds = 1e8;
i_round = 0; 

%% run
while (it<maxit)&&(i_round<max_rounds)
    i_round = i_round + 1;
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
        
%         if MT(k,1)<MT(k,2)
%             %MT(k,2) = MT(k,1);
%             MT = WT ;
%         end
        
        % calc average fitness
        fWT = 0 ;
        fMT = 0 ;
        for i = 1:N
            if i~=n
                fWT = fWT + single_droplet(WT,Phen(:,:,i),Cost) ;
                fMT = fMT + single_droplet(MT,Phen(:,:,i),Cost) ;
            end
        end
        
        % fixation
        switch 'only_beneficial'
            case 'only_beneficial'
                thereshold = fMT/fWT - 1;
            case 'allow_negative'
                x = fMT/fWT;
                thereshold = 0.5*(1+tanh(10*(x-1.15)));
        end
        if rand < thereshold
            it = it + 1 ;
            Phen(:,:,n) = MT ;
            Phen_v(:,:,:,it) = Phen ;
            t_v(it,1) = t ;
            improvement(it,1) = fMT/fWT ;
        end
    end
    t = t + 1 ;
    if ~mod(t,100000), disp([t,it]); end
end
%% plot
figure(3);clf;
for k = 1:K
    subplot(K+1,1,k)
    hold on
    plot(t_v,reshape(Phen_v(k,1,:,:),N,[]),'-');
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot(t_v,reshape(Phen_v(k,2,:,:),N,[]),'--')
    title(sprintf('-Resistant, --Production, Antibiotic #%g',k))
end
subplot(k+1,1,k+1); hold on
plot(t_v,improvement,'-');

