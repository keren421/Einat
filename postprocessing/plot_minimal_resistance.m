needed_line = 'data11';
draw_r = 1;
h = gcf;
legend
axesObjs = get(h, 'Children');
try
    dataObjs = get(axesObjs, 'Children');
    lines = dataObjs{2};
catch
    lines = get(axesObjs, 'Children');
end
for i = 1:length(lines)
    if strcmp(lines(i).DisplayName, needed_line)
        t = lines(i).XData;
        p = lines(i).YData;
        if draw_r
            r = -0.01271*p.^2 +0.5013*p;
            hold on
            plot(t,r,'k','displayname','minimal resistance')
        end
    end
end
