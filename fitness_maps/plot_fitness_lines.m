%production = 0.0:0.01:10;
%resistance = 0.0:0.01:5;
sample_points = [1,2, 5, 10,26, 51, 76, 101,126, 151, 176, 201];
figure(); hold all;
CM = jet(length(sample_points));
for i = 1:length(sample_points)
    
    cur_point = sample_points(i);
    cur_r = resistance(cur_point);
    plot(production, cost_producer(:,cur_point),'linewidth',2,...
        'color',CM(i,:),'displayname',['R = ' num2str(cur_r)]);
end
grid on;
box on
legend show
set(gca,'fontsize',14)
xlabel('Production')
ylabel('Score');