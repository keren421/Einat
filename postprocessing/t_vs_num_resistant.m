h = gcf;
legend
axesObjs = get(h, 'Children');
try
    dataObjs = get(axesObjs, 'Children');
    lines = dataObjs{2};
catch
    lines = get(axesObjs, 'Children');
end

run_type = nan(length(lines),1);
for i = 1:length(lines)
    if str2double(lines(i).DisplayName)== 1
        t = lines(i).XData;
        p = lines(i).YData;
        p = p(~isnan(p));
        t = t(~isnan(p));
        cum_production = cumtrapz(t,p);
        average_production = (cum_production(end)- cum_production(1))/(t(end)-t(1));
        
        on_off = p>average_production;
        
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
    end
end
%%

average_height = nan(length(lines),length(time_on));
max_height = nan(length(lines),length(time_on));
min_height = nan(length(lines),length(time_on));

for i = 1:length(lines)
    run_type(i) = str2double(lines(i).DisplayName);
    t = lines(i).XData;
    p = lines(i).YData;
    p = p(~isnan(p));
    t = t(~isnan(p));

    peaks = nan(length(off_to_on),1);
    for j = 1:length(off_to_on)
        max_height(i,j) = max(p(i_off_to_on(j):i_on_to_off(j)));
        min_height(i,j) = min(p(i_off_to_on(j):i_on_to_off(j)));
        average_height(i,j) = mean(p(i_off_to_on(j):i_on_to_off(j)));
    end
end
%%
I_resistant = find(run_type>1);
I_minimal = find(run_type==0);

above_mean = nan(1,length(time_on));
for i = 1:length(time_on)
    above_mean(i) = sum(average_height(I_resistant,i)>average_height(I_minimal,i))/length(I_resistant);
end
figure(); plot(above_mean,time_on,'*')
grid on
box on
set(gca,'fontsize',14);
xlabel('Precentage Above Minimal Resistance')
ylabel('Time of Peak')