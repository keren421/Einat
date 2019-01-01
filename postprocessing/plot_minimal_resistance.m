needed_line = 'data9';
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
            r = -0.012564*p.^2 +0.44157*p+0.0077226;
            hold on
            plot(t,r,'k','displayname','minimal resistance')
        end
    end
end
