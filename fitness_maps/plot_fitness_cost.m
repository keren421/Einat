%Cost = [0.005 0.01];
Cost = [0.005 0.01];
time_limit = 0.9;
scoring_type = 'loser_dies_winner_gets_rest'; % 'winner_gets_all', 'loser_dies_winner_gets_rest', 'loser_remains_winner_gets_rest'
production = 0.0:0.01:10;
resistance = [0.01]; %0.0:0.01:5;

run_name = 'loser_remains_time_limit_10';
save_file = 0;
fig_num = 10;
%%
decay = 1;
producer = zeros(1,2);
resistant = zeros(1,2);
cost_producer = nan(length(production),length(resistance));
cost_resistant = nan(length(production),length(resistance));

for i_p = 1:length(production)
    for i_r = 1:length(resistance)
        producer(2) = production(i_p);
        resistant(1) = resistance(i_r);
        
        g1 = growth_rate(producer, Cost);
        g2 = growth_rate(resistant, Cost);
        g = [g1,g2];
        
        [y_p,y_r,~,~] = single_droplet_with_solver(producer,resistant,g,'max', scoring_type, decay, time_limit);
        cost_producer(i_p,i_r) = y_p;
        cost_resistant(i_p,i_r) = y_r;
%         if (y_r~=-1)&&(isnan(resistance_value(i_p)))
%             resistance_value(i_p) = resistance(i_r);
%         end
%         [y,~,~,~] = single_droplet(producer,zeros(1,2),Cost,'max', scoring_type, decay);
%         cost_producer(i_p,i_r) = cost_producer(i_p,i_r) + y;
%         [y,~,~,~] = single_droplet(resistant,zeros(1,2),Cost,'max', scoring_type, decay);
%         cost_resistant(i_p,i_r) = cost_resistant(i_p,i_r) + y;
    end
end
fitness_producer = cost_producer;
fitness_resistant= cost_resistant;

%%
figure(10); clf;

subplot(1,2,1);
imagesc(production, resistance, fitness_producer');
set(gca,'Ydir','Normal')
title('Producer Fitness');
colorbar;
xlabel('Production');
ylabel('Resistance');

subplot(1,2,2); 
imagesc(production, resistance, fitness_resistant');
set(gca,'Ydir','Normal')
title('Resistant Fitness');
colorbar;
xlabel('Production');
ylabel('Resistance');
%%
resistance_value = nan(length(production),1);
for i_p = 1:length(production)
    for i_r = 1:length(resistance)
        y_r = cost_resistant(i_p,i_r);
        if (y_r~=-0)&&(isnan(resistance_value(i_p)))
            resistance_value(i_p) = resistance(i_r);
        end
    end
end
figure(); plot(production, resistance_value,'linewidth',2)
title('Minimal Resistance for Producing Value')
xlabel('Production');
ylabel('Minimal Resistance');
set(gca,'fontsize',14);
grid on

%%
production_value = nan(length(resistance),1);
for i_r = 1:length(resistance)
    [~,I] = max(cost_producer(:,i_r));
    if (~isempty(I))
        production_value(i_r) = production(I);
    end
end
figure(); plot(production_value,resistance,'linewidth',2)
title('Minimal Resistance for Producing Value')
xlabel('Production');
ylabel('Minimal Resistance');
set(gca,'fontsize',14);
grid on
%%
if save_file 
    folder_path = ['C:\Users\Keren\Documents\MATLAB\Einat\Fitness\' run_name '\'];
    mkdir(folder_path)
    savefig([folder_path 'Fitness_matrix.fig'])
    saveas(gcf,[folder_path 'Fitness_matrix.jpg'])
    save([folder_path 'vars.mat'],'Cost','run_name', 'scoring_type','decay', 'production','resistance','cost*','fitness*') 
end