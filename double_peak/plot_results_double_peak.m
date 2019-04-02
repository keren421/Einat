mean_total_time = squeeze(mean(total_time,2));
error_total_time = squeeze(std(total_time,0,2))/10;

mean_peak_time = squeeze(mean(peak_time,2));
error_peak_time = squeeze(std(peak_time,0,2))/10;

mean_off_time = squeeze(mean(off_time,2));
error_off_time = squeeze(std(off_time,0,2))/10;

mean_max_production = squeeze(mean(max_production,2));
error_max_production = squeeze(std(max_production,0,2))/10;

down_time = total_time - peak_time;
mean_down_time = squeeze(mean(down_time,2));
error_down_time = squeeze(std(down_time,0,2))/10;

%%
pearson_cor = nan(7,1);
figure(); plot(down_time(:,:,1)', down_time(:,:,2)','*')
for i =1:7
    pearson_cor(i) = corr(down_time(i,:,1)',down_time(i,:,2)');
end
figure(); plot(pearson_cor,'linewidth',2)
grid on;
set(gca,'fontsize',14)
xlabel('Number of Competitors')
ylabel('Pearson Correlation Coefficient')
box on
%%
pearson_cor = nan(7,1);
figure(); plot(max_production(:,:,1)', max_production(:,:,2)','*')
grid on;
set(gca,'fontsize',14)
xlabel('Max Production in 1st cycle')
ylabel('Max Production in 2nd cycle]')
box on
for i =1:7
    pearson_cor(i) = corr(max_production(i,:,1)',max_production(i,:,2)');
end

figure(); plot(pearson_cor,'linewidth',2)
grid on;
set(gca,'fontsize',14)
xlabel('Number of Competitors')
ylabel('Pearson Correlation Coefficient')
box on
%%
figure(); hold all;
errorbar(cases, mean_max_production(:,1), error_max_production(:,1),'s-.','linewidth',2,'displayname','1st peak');
errorbar(cases, mean_max_production(:,2), error_max_production(:,2),'o--','linewidth',2,'displayname','2nd peak');
grid on;set(gca,'fontsize',14)
xlabel('Number of Competitors')
ylabel('Maximum Production')
title('Production')
grid on


%%
figure(); hold all;
colors_list = lines(3);
errorbar(cases, mean_total_time(:,1), error_total_time(:,1),'s-.','color',colors_list(1,:),'linewidth',2,'displayname','Total Time - 1st peak');
errorbar(cases, mean_total_time(:,2), error_total_time(:,2),'o--','color',colors_list(1,:),'linewidth',2,'displayname','Total Time - 2nd peak');
errorbar(cases, mean_peak_time(:,1), error_peak_time(:,1),'s-.','color',colors_list(2,:),'linewidth',2,'displayname','Time to Peak - 1st peak');
errorbar(cases, mean_peak_time(:,2), error_peak_time(:,2),'o--','color',colors_list(2,:),'linewidth',2,'displayname','Time to Peak - 2nd peak');
errorbar(cases, mean_down_time(:,1), error_down_time(:,1),'s-.','color',colors_list(3,:),'linewidth',2,'displayname','Time from Peak - 1st peak');
errorbar(cases, mean_down_time(:,2), error_down_time(:,2),'o--','color',colors_list(3,:),'linewidth',2,'displayname','Time from Peak - 2nd peak');

grid on;
set(gca,'fontsize',14)
xlabel('Number of Competitors')
ylabel('Time [# Mutations of Producer]')
title('Time Differences')
grid on
%%
figure(); hold all;
errorbar(cases, mean_peak_time(:,1), error_peak_time(:,1),'s-.','linewidth',2,'displayname','1st peak');
errorbar(cases, mean_peak_time(:,2), error_peak_time(:,2),'s-.','linewidth',2,'displayname','2nd peak');
grid on;
%%
figure(); hold all;
errorbar(cases, mean_off_time(:,2), error_off_time(:,2),'s-.','linewidth',2);
grid on;
grid on;
set(gca,'fontsize',14)
xlabel('Number of Competitors')
ylabel('Time [# Mutations of Producer]')
title('Time Differences')
grid on
