num_iterations = 100;

cases = [1, 2, 3, 4, 5, 6, 7];
%N_R = 2;
production_value = 0; %1;
resistance_value = 0; %1;
others_value = 1;
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
% cases = cell(N_R,1);
% ratio = nan(N_R,1);
% time_all = nan(N_R,1);
% error_all = nan(N_R,1);
% 
% for j=1:N_R
%     cases{j} = 2:j;
%     ratio(j) = j/N_R;
% end

%%
for j = 5:length(cases)
    N_R = cases(j);
    fig_num_tot = j*100;
    fig_num_sim = fig_num_tot+10;
    intial_resistance = 0.0*ones(N_R,1);
    %intial_resistance(1) = resistance_value;
    %intial_resistance(cases{j}) = others_value;
    %%
    intial_production = production_value*ones(1,1);
    %close all
    i_r = 1;
    %%
    while i_r <= num_iterations
        i_r
        [Phen_v, t_v] = compete_with_intial_phen(N_R, fig_num_sim,intial_production, intial_resistance);
        figure(fig_num_tot); hold on
        production = squeeze(Phen_v(1,2,1,:));
        resistance = squeeze(Phen_v(1,1,2,:));
        t_v = t_v(~isnan(t_v));
        resistance = resistance(~isnan(t_v));
        production = production(~isnan(t_v));
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
            peak_time(j,i_r,k) = t_v(I) -start_time;
            total_time(j,i_r,k) = t_v(i_end) - start_time;
        end
        %if max(resistance) <= resistance_value
        plot(t_v - start_time,production,'-','linewidth',2, ...
                'displayname',['Iteration Num ' num2str(i_r)])
        i_r = i_r +1;
        drawnow
    end
    title('total production')
    
    for k = 1:num_peaks
        mean_peak_time(j,k) = mean(peak_time(j,:));
        error_peak_time(j,k) = std(peak_time(j,:))/sqrt(num_iterations);
        mean_total_time(j,k) = mean(total_time(j,:));
        error_total_time(j,k) = std(total_time(j,:))/sqrt(num_iterations);
        mean_max_production(j,k) = mean(max_production(j,:));
        error_max_production(j,k) = std(max_production(j,:))/sqrt(num_iterations);
    end
    
    x = 0.6*max(total_time(j,:));
    y = max(max_production(j,:));
    text(x,y,['Peak time = ' num2str(mean_peak_time(j)) ' +- ' num2str(error_peak_time(j)) , newline, ...
        'Mean time = ' num2str(mean_total_time(j)) ' +- ' num2str( error_total_time(j))]);
    disp(['Mean time = ' num2str(mean_total_time(j)) ' +- ' num2str( error_total_time(j))])
    disp('Done :)')

end