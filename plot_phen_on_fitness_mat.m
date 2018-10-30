producer_p = squeeze(Phen_v(1,2,1,:));
resistant_r = squeeze(Phen_v(1,1,2,:));
subplot(2,1,1);

for i = 1: length(producer_p)
    hold on; plot(producer_p(i),resistant_r(i),'*k')
    pause(0.01);
end
