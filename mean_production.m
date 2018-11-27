 h = gcf;
axesObjs = get(h, 'Children');
dataObjs = get(axesObjs, 'Children');
lines = dataObjs{2};

log_dt = linspace(4,5,10);
dt = 10.^(log_dt);

average_production = nan(length(lines),length(log_dt));
var_production = nan(length(lines),length(log_dt));
run_type = nan(length(lines),1);

for i = 1:length(lines)
    temp_t = lines(i).XData;
    temp_p = lines(i).YData;
    temp_p = temp_p(~isnan(temp_p));
    temp_t = temp_t(~isnan(temp_p));
    
    I = find(diff(temp_t)==0);
    temp_t(I+1) = temp_t(I) + 0.5;
    run_type(i) = str2double(lines(i).DisplayName);
    
    cum_production = cumtrapz(temp_t,temp_p);
    for j = 1:length(log_dt)
        interped_cum_production = interp1(temp_t,cum_production,0:dt(j):max(temp_t));
        interped_cum_production(1) = 0;
        window_mean = diff(interped_cum_production)./dt(j);
        average_production(i,j) = mean(window_mean);
        var_production(i,j) = std(window_mean);
    end
    
    %var_production(i) =  trapz(temp_t,temp_p)/max(temp_t);
end

%%
figure(); hold all;
fig_legends = cell(length(dt),1);
CM = jet(length(dt));
for j = 1:length(log_dt)
    errorbar(run_type,average_production(:,j),var_production(:,j),'color',CM(j,:))
    xlabel('num of resistant strains');
    ylabel('aveage production value');
    grid on;
    fig_legends{j} = ['dt = ' num2str(dt(j))];
end
legend(fig_legends);

