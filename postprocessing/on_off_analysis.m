h = gcf;
legend
axesObjs = get(h, 'Children');
try
    dataObjs = get(axesObjs, 'Children');
    lines = dataObjs{2};
catch
    lines = get(axesObjs, 'Children');
end

peak_height = cell(length(lines),1);
t_peaks = cell(length(lines),1);

average_t_on = nan(length(lines),1);
median_t_on = nan(length(lines),1);
var_t_on = nan(length(lines),1);
average_t_off = nan(length(lines),1);
median_t_off = nan(length(lines),1);
var_t_off = nan(length(lines),1);
run_type = nan(length(lines),1);
average_peak_height = nan(length(lines),1);
median_peak_height = nan(length(lines),1);
var_peak_height = nan(length(lines),1);

for i = 1:length(lines)
    run_type(i) = str2double(lines(i).DisplayName);
    t = lines(i).XData;
    p = lines(i).YData;
    p = p(~isnan(p));
    t = t(~isnan(p));

    cum_production = cumtrapz(t,p);
    average_production = (cum_production(end)- cum_production(1))/(t(end)-t(1));

%     figure();
%     plot(t,p./max(p));
%     hold all
    on_off = p>average_production;
%     plot(t,0.5*on_off);

    deriv_on_off = diff(on_off);
    i_on_to_off = find(deriv_on_off<0);
    i_off_to_on = find(deriv_on_off>0);
    on_to_off = t(i_on_to_off);
    off_to_on = t(i_off_to_on);
    
    trim_length = min(length(on_to_off),length(off_to_on));
    on_to_off = [t(1), on_to_off(1:trim_length)];
    off_to_on = off_to_on(1:trim_length);
    
    time_on = on_to_off(2:length(off_to_on)+1) - off_to_on;
    time_off = off_to_on - on_to_off(1:length(off_to_on));
    
    average_t_on(i) = mean(time_on);
    median_t_on(i) = median(time_on);
    var_t_on(i) = std(time_on)/sqrt(length(time_on)); 

    average_t_off(i) = mean(time_off);
    median_t_off(i) = median(time_off);
    var_t_off(i) = std(time_off)/sqrt(length(time_off)); 
    
    peaks = nan(length(off_to_on),1);
    for j = 1:length(off_to_on)
        peaks(j) = max(p(i_off_to_on(j):i_on_to_off(j)));
    end
    peak_height{i} = peaks;
    t_peaks{i} = time_on';
    
    
    average_peak_height(i) = mean(peaks);
    median_peak_height(i) = median(peaks);
    var_peak_height(i) = std(peaks)/sqrt(length(peaks)); ;
    
%     figure();
%     hist([time_on', time_off'])
%     grid on;
%     title(['Histogram of Peak Production - ' num2str(run_type(i)) ' strains'])
end
%%
figure(); hold all;
errorbar(run_type,average_t_on,var_t_on,'linewidth',2,'displayname','\Deltat on\rightarrowoff')
%plot(run_type,median_t_on,'*')
errorbar(run_type,average_t_off,var_t_off,'linewidth',2,'displayname','\Deltat off\rightarrowon')
%plot(run_type,median_t_off,'*')
legend;
xlabel('num of resistant strains');
ylabel('Average \Deltat');
grid on;
xlim([min(run_type),max(run_type)]);
set(gca,'fontsize',14)
%%
xlabel('\Deltat');
%%
figure(); hold all;
errorbar(run_type,average_peak_height,var_peak_height,'linewidth',2)
plot(run_type,median_peak_height,'x','markersize',14,'linewidth',2)
legend('Average Peak Production','Median Peak Production');
xlabel('num of resistant strains');
ylabel('Peak Production');
set(gca,'fontsize',14);
grid on;
xlim([min(run_type),max(run_type)]);
%%
for i = 1:length(lines)
    figure();
    hist(peak_height{i})
    grid on;
    title(['Histogram of Peak Production - ' num2str(run_type(i)) ' strains'])
    figure();
    hist(t_peaks{i})
    grid on;
    title(['Histogram of Peak Time - ' num2str(run_type(i)) ' strains'])
end
%%
A = nan(length(peak_height{5}),3);
A(:,1) = peak_height{5};
A(1:length(peak_height{3}),2) = peak_height{3};
A(1:length(peak_height{2}),3) = peak_height{2};
figure();
hist(A, linspace(0,6,30));
grid on;
box on
set(gca,'fontsize',14);
legend('1 resistant strain','4 resistant strains','7 resistant strains')
xlabel('Peak Height')