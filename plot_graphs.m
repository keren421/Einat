figure()
num_competitors = [1, 2, 3, 4, 5, 6, 7];
max_p_t_p = nan(1,7);
error = nan(1,7);
for i = num_competitors
    cur_p = max_production(i,:);
    cur_t = peak_time(i,:);
    max_p_t_p(i) = mean(cur_p(cur_t>0)./cur_t(cur_t>0));
    error(i) = std(cur_p(cur_t>0)./cur_t(cur_t>0))/sqrt(100);
end
errorbar(num_competitors, max_p_t_p, error, 'linewidth',2,'displayname','simulation');
grid on; box on;
title('Slope of Raise ')
xlabel('Number of Competitors')
ylabel('Max Production/Time to Peak')
set(gca,'fontsize',14)
%%
figure()
num_competitors = [1, 2, 3, 4, 5, 6, 7];
max_p_t_p = nan(1,7);
error = nan(1,7);
for i = num_competitors
    cur_p = max_production(i,:);
    cur_t = down_time(i,:);
    max_p_t_p(i) = mean(cur_p(cur_t>0)./cur_t(cur_t>0));
    error(i) = std(cur_p(cur_t>0)./cur_t(cur_t>0))/sqrt(100);
end
errorbar(num_competitors, max_p_t_p, error, 'linewidth',2,'displayname','simulation');
grid on; box on;
title('Slope of Raise ')
xlabel('Number of Competitors')
ylabel('Max Production/Time to Peak')
set(gca,'fontsize',14)
%%

figure(); hold all
num_r = [0,1];
for j = 1:length(num_r)
    errorbar(production_value, mean_total_time(:,j), error_total_time(:,j), 'linewidth',2,'displayname','simulation');
end
grid on; box on;
title('Time of losing production')
xlabel('Intial Production Value')
ylabel('Time [# mutations in producer]')
set(gca,'fontsize',14)