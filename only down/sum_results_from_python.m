figure(); hold all;


colors_list = lines(7);

ratio = [0, 0.1429, 0.2857, 0.4286, 0.5714, 0.7143, 0.8571, 1.0];
t = [1933.645, 1772.21, 1443.585, 1374.935, 1226.66, 1069.96, 1155.52, 681.44];
error_t = [139.0318, 126.1837, 105.3513, 104.0944, 89.04468, 68.71419, 78.92554, 49.55671];
n_r = 7;
r = 0.5;
label = ['N_r = ' num2str(n_r) ', r = ' num2str(r)]; 
errorbar(ratio, t, error_t,'s-.','color',colors_list(n_r,:),'linewidth',2,'displayname',label);

%%
ratio = [0, 0.25, 0.5, 0.75, 1];
t = [1961.065, 1700.05, 1474.315, 1069.715, 582.675];
error_t = [131.98, 119.8835, 106.944, 62.29, 41.3566];
n_r = 4;
r = 0.5;
label = ['N_r = ' num2str(n_r) ', r = ' num2str(r)]; 
errorbar(ratio, t, error_t,'s-.','color',colors_list(n_r,:),'linewidth',2,'displayname',label);

%%
ratio = [0, 0.5, 1];
t = [1751.58, 1250.07, 592.91];
error_t = [117.57, 76.62, 41.58];
n_r = 2;
r = 0.5;
label = ['N_r = ' num2str(n_r) ', r = ' num2str(r)]; 
errorbar(ratio, t, error_t,'s-.','color',colors_list(n_r,:),'linewidth',2,'displayname',label);

%%
ratio = [0, 1];
t = [1659.99, 577.585];
error_t = [132.367, 37.82];
n_r = 1;
r = 0.5;
label = ['N_r = ' num2str(n_r) ', r = ' num2str(r)]; 
errorbar(ratio, t, error_t,'s-.','color',colors_list(n_r,:),'linewidth',2,'displayname',label);

%%

ratio = [0, 0.25, 0.5, 0.75, 1];
t = [3309.92, 2840.905, 2228.52, 1776.555, 1007.39];
error_t = [135.6044, 129.9645, 99.97926, 84.25126, 62.05427];
n_r = 4;
r = 1;
label = ['N_r = ' num2str(n_r) ', r = ' num2str(r)]; 
errorbar(ratio, t, error_t,'s--','color',colors_list(n_r,:),'linewidth',2,'displayname',label);

%%

ratio = [0, 0.25, 0.5, 0.75, 1];
t = [3309.92, 2840.905, 2228.52, 1776.555, 1007.39];
error_t = [135.6044, 129.9645, 99.97926, 84.25126, 62.05427];
n_r = 4;
r = 1;
label = ['N_r = ' num2str(n_r) ', r = ' num2str(r)]; 
errorbar(ratio, t, error_t,'s--','color',colors_list(n_r,:),'linewidth',2,'displayname',label);

%%

ratio = [0, 0.5, 1];
t = [3219.83, 2470.895, 910.135];
error_t = [154.3232, 109.5544, 59.0689];
n_r = 2;
r = 1;
label = ['N_r = ' num2str(n_r) ', r = ' num2str(r)]; 
errorbar(ratio, t, error_t,'s--','color',colors_list(n_r,:),'linewidth',2,'displayname',label);

%%

ratio = [0, 1];
t = [3275.1, 878.5];
error_t = [143.929, 55.8208];
n_r = 1;
label = ['N_r = ' num2str(n_r) ', r = ' num2str(r)]; 
errorbar(ratio, t, error_t,'s--','color',colors_list(n_r,:),'linewidth',2,'displayname',label);

%%

title('Time for Losing Production')
xlabel('#Resistant Strains/Total Strains')
ylabel('Time for Losing Production')
legend('Location','best')
box on;
grid on