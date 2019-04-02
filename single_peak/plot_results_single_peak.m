
figure();
errorbar(cases, mean_max_production, error_max_production,'linewidth',2);
title('Max Production')
set(gca,'fontsize',14)
xlabel('Num of Competitors')
grid on

figure();hold all;
errorbar(cases, mean_total_time, error_total_time,'displayname','Total Time' ,'linewidth',2);
errorbar(cases, mean_peak_time, error_peak_time,'displayname','Time to Peak','linewidth',2);
errorbar(cases, mean_down_time, error_down_time,'displayname','Time Down','linewidth',2);
set(gca,'fontsize',14)
xlabel('Num of Competitors')
ylabel('Num Mutation of Producer')
grid on

%%
figure();
semilogy(cases, mean_total_time, 'displayname','Total Time' ,'linewidth',2);
hold all;
semilogy(cases, mean_peak_time, 'displayname','Time to Peak','linewidth',2);
semilogy(cases, mean_down_time, 'displayname','Time Down','linewidth',2);
set(gca,'fontsize',14)
xlabel('Num of Competitors')
ylabel('Num Mutation of Producer')
grid on

figure();
semilogy(cases, mean_max_production, 'linewidth',2);
title('Max Production')
set(gca,'fontsize',14)
xlabel('Num of Competitors')
grid on

