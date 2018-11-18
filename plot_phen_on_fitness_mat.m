producer_p = squeeze(Phen_v(1,2,1,:));
resistant_r = squeeze(Phen_v(1,1,2,:));
subplot(2,1,1);

    hold on; plot(producer_p(1:20),resistant_r(1:20),'*-k')
    pause(0.01);
