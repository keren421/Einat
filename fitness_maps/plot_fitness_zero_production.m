Cost = [0.005 0.01];
time_limit = 10;
production = 0:0.01:2;
t = 0:1:30;
start_pop = 1e-3;

run_name = 'cost_0.5';
save_file = 1;
fig_num = 12;
%%
cost_producer = nan(length(production),length(t));
cost_resistant = nan(length(production),length(t));
A = (1-start_pop)/start_pop;

for i_p = 1:length(production)
    for i_t = 1:length(t)
        cur_p = production(i_p);
        cur_t  = t(i_t);
        g = exp(-0.5*cur_p);
        K = 1;
        cost_producer(i_p,i_t) =1/(1+A*exp(-g*cur_t));
        cost_resistant(i_p,i_r) = 0;
    end
end
%fitness_producer = 2*cost_producer - 1;

%%
figure(fig_num); clf;
imagesc(production, t, cost_producer');
set(gca,'Ydir','Normal')
title('Producer Fitness');
colorbar;
xlabel('Production');
ylabel('time_limit');

%%
if save_file 
    folder_path = ['C:\Users\Keren\Documents\MATLAB\Einat\Fitness_R_0\' run_name '\'];
    mkdir(folder_path)
    savefig([folder_path 'Fitness_matrix.fig'])
    saveas(gcf,[folder_path 'Fitness_matrix.jpg'])
    save([folder_path 'vars.mat'],'Cost','run_name', 'scoring_type','decay', 'production','resistance','cost*','fitness*') 
end