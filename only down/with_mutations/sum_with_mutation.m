
figure(); hold all;
colors_list = lines(3);
ratio_1 = [0,1];
ratio_2 = [0,0.5,1];
ratio_4 = [0,0.25,0.5,0.75,1];
errorbar(ratio_1, mean_total_time(1,1:2), error_total_time(1,1:2),'s-.','color',colors_list(1,:),'linewidth',2,'displayname','With Mutations - 1 Competitors');
errorbar(ratio_2, mean_total_time(2,1:3), error_total_time(2,1:3),'s--','color',colors_list(2,:),'linewidth',2,'displayname','With Mutations - 2 Competitors');
errorbar(ratio_4, mean_total_time(3,1:5), error_total_time(3,1:5),'s--','color',colors_list(3,:),'linewidth',2,'displayname','With Mutations - 4 Competitors');

title('Time for Losing Production')
xlabel('#Resistant Strains/Total Strains')
ylabel('Time for Losing Production')
legend('Location','best')
box on;
grid on