num_iterations = 100;

production_value = 1; 
resistance_value = 0.5*production_value; %1;
others_value = 0;
num_resistants = [1 2 4 6];
total_time = nan(max(num_resistants)+1,num_iterations, length(num_resistants));
mean_total_time = nan(max(num_resistants)+1, length(num_resistants));
error_total_time = nan(max(num_resistants)+1, length(num_resistants));

%%
for j = 1:length(num_resistants)
    N_R = num_resistants(j);
    
    cases = cell(N_R,1);
    ratio = nan(N_R,1);
    time_all = nan(N_R,1);
    error_all = nan(N_R,1);

    for k=1:N_R+1
        cases{k} = 1:k-1;
        ratio(k) = k/N_R;
    end

    intial_resistance = others_value*ones(N_R,1);
    intial_production = production_value*ones(1,1);
    %%
    for k = 1:length(cases)
        
        fig_num_tot = j*100 + 10*k;
        fig_num_sim = fig_num_tot+5;
        intial_resistance(cases{k}) = resistance_value
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
            cur_max_p =  max(production);
            if cur_max_p<=production_value
                total_time(j,i_r,k) = t_v(end) - t_v(1);
                plot(t_v,production,'-','linewidth',2, ...
                        'displayname',['Iteration Num ' num2str(i_r)])
                i_r = i_r +1;
                drawnow
            else
                disp('Reached Higher production')
            end
        end
        
        mean_total_time(j,k) = mean(total_time(j,:,k));
        error_total_time(j,k) = std(total_time(j,:,k))/sqrt(num_iterations);
        x = 0.6*max(total_time(j,:,k));
        y = production_value;
        text(x,y,['Intial Resistance = ', num2str(intial_resistance'), newline, ...
        'Mean time = ' num2str(mean_total_time(j,k)) ' +- ' num2str(error_total_time(j,k))]);

    end
    title('total production')
    
    disp(['Mean time = ' num2str(mean_total_time(j,:)) ' +- ' num2str( error_total_time(j,:))])
    disp('Done :)')

end