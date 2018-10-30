 h = gcf;
axesObjs = get(h, 'Children');
dataObjs = get(axesObjs, 'Children');
lines = dataObjs{2};

average_production = nan(length(lines),1);
run_type = nan(length(lines),1);

for i = 1:length(lines)
    temp_t = lines(i).XData;
    temp_p = lines(i).YData;
    average_production(i) = trapz(temp_t,temp_p)/max(temp_t);
    run_type(i) = str2double(lines(i).DisplayName);
end

figure(); plot(run_type,average_production,'-*')
xlabel('num of resistant strains');
ylabel('aveage production value');
grid on;
