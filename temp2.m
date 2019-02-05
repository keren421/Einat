figure(); plot(above_mean,time_on,'*')
grid on
box on
set(gca,'fontsize',14);
xlabel('Precentage Above Minimal Resistance')
ylabel('Time of Peak')

%%
num_r = 4;
precentage_above = (1:num_r)/num_r;
mean_time = nan(size(precentage_above));
var_time = nan(size(precentage_above));
for i =1:num_r
    cur_time_on = time_on(above_mean==precentage_above(i));
    mean_time(i) = mean(cur_time_on);
    var_time(i) = std(cur_time_on)/sqrt(length(cur_time_on));
end

figure(); hold all;
errorbar(precentage_above,mean_time,var_time,'linewidth',2)
