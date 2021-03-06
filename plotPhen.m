function [] = plotPhen(fig_num, K, N, Phen_v,t_v)
    figure(fig_num);clf;
    antibiotic_production = nan(length(t_v),K);
    for k = 1:K
        subplot(K,1,k)
        hold on
        plot(t_v,reshape(Phen_v(k,1,:,:),N,[]),'-');
        ax = gca;
        ax.ColorOrderIndex = 1;
        plot(t_v,reshape(Phen_v(k,2,:,:),N,[]),'--')
        title(sprintf('-Resistant, --Production, Antibiotic #%g',k))
        antibiotic_production(:,k) = sum(reshape(Phen_v(k,2,:,:),N,[]));
    end
    drawnow
    figure(fig_num+1);clf;
    hold on
    plot(t_v,antibiotic_production,'--')
    plot(t_v,sum(antibiotic_production,2),'-','linewidth',2)
    title('total prodution')
    drawnow
end