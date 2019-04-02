cases = [1, 2, 3, 4, 5, 6, 7];
%N_R = 2;
num_peaks = 2;
peak_time = nan(length(cases),num_iterations, num_peaks);
total_time = nan(length(cases),num_iterations, num_peaks);
max_production = nan(length(cases),num_iterations, num_peaks);
off_time = nan(length(cases),num_iterations, num_peaks);

mean_peak_time = nan(length(cases),num_peaks);
mean_total_time = nan(length(cases),num_peaks);
mean_max_production = nan(length(cases),num_peaks);
mean_off_time = nan(length(cases),num_peaks);
error_peak_time = nan(length(cases),num_peaks);
error_total_time = nan(length(cases),num_peaks);
error_max_production = nan(length(cases),num_peaks);
error_off_time = nan(length(cases),num_peaks);

%%
j = 7

h = gcf;
axesObjs = get(h, 'Children');
dataObjs = get(axesObjs, 'Children');
i_r = 0;
for i_l = 1:length(dataObjs)
    if strcmp(dataObjs(i_l).Type,'text')
        disp('This is a text object')
    else
        i_r = i_r+1;
        t_v = dataObjs(i_l).XData;
        production = dataObjs(i_l).YData;
        i_end = 1;
        i_start = 1;
        for k = 1:num_peaks
            i_start = find(production(i_end:end)>0.2,1,'first');
            i_start = i_end + i_start - 1;
            off_time(j,i_r,k) = t_v(i_start) - t_v(i_end);
            i_end = find(production(i_start:end)<0.1,1,'first');
            i_end = i_end + i_start - 1;
            start_time = t_v(i_start);
            [max_production(j,i_r,k),I] = max(production(i_start:i_end));
            I = I + i_start -1;
            peak_time(j,i_r,k) = t_v(I) -start_time;
            total_time(j,i_r,k) = t_v(i_end) - start_time;
        end
    end
end

%%
figure(); hold all;
fig_legends = cell(length(dt),1);
CM = jet(length(dt));
for j = 1:length(log_dt)
    errorbar(run_type,average_production(:,j),var_production(:,j),'color',CM(j,:),'linewidth',2)
    xlabel('num of resistant strains');
    ylabel('average production value');
    grid on;
    fig_legends{j} = ['dt = ' num2str(dt(j))];
end
legend(fig_legends);
set(gca,'fontsize',14);
xlim([min(run_type),max(run_type)]);
%ylim([0,0.4]);
