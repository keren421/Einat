Cost = [0.05 0.1];
time_limit = nan;
scoring_type = 'loser_dies_winner_gets_rest'; % 'winner_gets_all', 'loser_dies_winner_gets_rest', 'loser_remains_winner_gets_rest'
production = 0:0.01:2;
resistance = 0:0.01:1;

run_name = 'loser_remains_time_limit_10';
save_file = 0;
fig_num = 11;
%%
decay = 1;
producer = zeros(1,2);
resistant = zeros(1,2);
cost_producer = nan(length(production),length(resistance));
cost_resistant = nan(length(production),length(resistance));

for i_p = 1:length(production)
    for i_r = 1:length(resistance)
        producer(1,2) = production(i_p);
        resistant(1,1) = resistance(i_r);
        [y_p,y_r,~,~] = single_droplet(producer,resistant,Cost,'max', scoring_type, decay, time_limit);
        cost_producer(i_p,i_r) = y_p;
        cost_resistant(i_p,i_r) = y_r;
%         [y,~,~,~] = single_droplet(producer,zeros(1,2),Cost,'max', scoring_type, decay);
%         cost_producer(i_p,i_r) = cost_producer(i_p,i_r) + y;
%         [y,~,~,~] = single_droplet(resistant,zeros(1,2),Cost,'max', scoring_type, decay);
%         cost_resistant(i_p,i_r) = cost_resistant(i_p,i_r) + y;
    end
end
fitness_producer = 2*cost_producer - 1;
fitness_resistant= 2*cost_resistant - 1;

%%
figure(fig_num); clf;

subplot(2,1,1);
imagesc(production, resistance, fitness_producer');
set(gca,'Ydir','Normal')
title('Producer Fitness');
colorbar;
xlabel('Production');
ylabel('Resistance');

subplot(2,1,2); 
imagesc(production, resistance, fitness_resistant');
set(gca,'Ydir','Normal')
title('Resistant Fitness');
colorbar;
xlabel('Production');
ylabel('Resistance');

%%
if save_file 
    folder_path = ['C:\Users\Keren\Documents\MATLAB\Einat\Fitness\' run_name '\'];
    mkdir(folder_path)
    savefig([folder_path 'Fitness_matrix.fig'])
    saveas(gcf,[folder_path 'Fitness_matrix.jpg'])
    save([folder_path 'vars.mat'],'Cost','run_name', 'scoring_type','decay', 'production','resistance','cost*','fitness*') 
end