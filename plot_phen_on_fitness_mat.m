producer_p = squeeze(Phen_v(1,2,1,:));
resistant_r = squeeze(Phen_v(1,1,2,:));
subplot(1,2,1);
hold on; plot(producer_p(1:30),resistant_r(1:30),'*-k')
subplot(1,2,1);
xlim([0 0.7]);
ylim([0 0.5])
 caxis([0.4 1.0])
set(gca,'fontsize',14)
subplot(1,2,2);
xlim([0 0.7]);
ylim([0 0.5])
caxis([0 0.55])
set(gca,'fontsize',14)