needed_line = 'data6';
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
            %r = -0.012564*p.^2 +0.44157*p+0.0077226;
            %r = -0.012734*p.^2 +0.47346*p+0.0054906;
            r = -0.012589*p.^2 +0.44144*p+0.0080862; %time limit = 0.8
            hold on
            %plot(t,r,'k','displayname','minimal resistance')
            plot(t,r,'k','displayname','0')
        end
    end
end
