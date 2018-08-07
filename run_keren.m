%% setup
switch 1
    case 1
        N = 2 ; % number of species
        K = 2 ; % number of antibiotics
        Cost = [0.05 0.5] ; % resistance and production costs
        Mut_prod = 0.5; % chance of a mutation affecting production 1-Pprod chance of affecting resistance ;
        Mut_size = [0 0]; % average size of resistant and production mutations (typically should be <=0)
        Mut_size_std = [0.05 0.05]; % standard deviation of resistant and production mutations
        Mut_0 = [0 0] ; % chance of null mutations causing complete loss of resistant(1) or production(2) 
    case 2
        N = 8 ; 
        K = 4 ; 
        Cost = [0.05 0.5] ; 
        Mut_prod = 0.5; 
        Mut_size = [0 0]; 
        Mut_size_std = [0.05 0.05]; 
        Mut_0 = [0 0] ; 
end

Phen = zeros(K,2,N) ; %1:Res, 2:Production
t = 0 ; % number of cycles
it = 0 ; % number of fixation events
maxit = 1000; %1000 ; % max number of fixations 
t_v = zeros(maxit,1) ;
Phen_v = zeros(K,2,N,maxit) ; % keeps all phenotypes versus time

%% run
while it<maxit
    for n = 1:N 
        WT = Phen(:,:,n) ;
        MT = WT ;
        k = randi(K) ; % chose number of antibiotic to mutate
        p = (rand>Mut_prod) + 1 ; % choose mutating production or resistance

        % mutate
        P0 = MT(k,p) ;
        P0 = P0 + Mut_size(p) + Mut_size_std(p)*randn ; 
        P0 = P0 * (rand>Mut_0(p));
        MT(k,p) = max(P0,0) ;
        
        if MT(k,1)<MT(k,2)
            %MT(k,2) = MT(k,1);
            MT = WT ;
        end
        
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
        if rand<fMT/fWT-1
            it = it + 1 ;
            Phen(:,:,n) = MT ;
            Phen_v(:,:,:,it) = Phen ;
            t_v(it,1) = t ;
        end
    end
    t = t + 1 ;
    if ~mod(t,100000), disp([t,it]); end
end
%% plot
figure(1);clf;
for k = 1:K
    subplot(K,1,k)
    hold on
    plot(t_v,reshape(Phen_v(k,1,:,:),N,[]),'-');
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot(t_v,reshape(Phen_v(k,2,:,:),N,[]),'--')
    title(sprintf('-Resistant, --Production, Antibiotic #%g',k))
end

%%
function [y1,y2] = single_droplet(P1,P2,cost)
f1 = fitness(P1,cost) ;
f2 = fitness(P2,cost) ;

switch 'keren'
    case 'roi'
        i1 = all(P1(:,1)>=P2(:,2)) ;
        i2 = all(P2(:,1)>=P1(:,2)) ;
        res = f1+f2 ;
        %why divide by f1+f2?
        y1 = i1/(i1+i2)*f1 ;
        y2 = i2/(i1+i2)*f2 ;
    case 'keren'
        growth1 = f1 - min(sum(max(P2(:,2)-P1(:,1),0)),f1);
        growth2 = f2 - min(sum(max(P1(:,2)-P2(:,1),0)),f2);
        y1 = growth1/(growth1+growth2);
        y2 = growth2/(growth1+growth2) ;
    case 'keren_2'
        growth1 = f1 - min(sum(max(P2(:,2)+P1(:,2)-P1(:,1),0)),f1);
        growth2 = f2 - min(sum(max(P1(:,2)+P2(:,2)-P2(:,1),0)),f2);
        y1 = growth1/(growth1+growth2);
        y2 = growth2/(growth1+growth2) ;
end
end


function f = fitness(P,cost)
%any reason to do it with exp or just random choice?
f = exp(-sum(P(:,1)*cost(1) + P(:,2)*cost(2))) ;
end

