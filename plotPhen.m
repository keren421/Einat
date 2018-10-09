function [] = plotPhen(fig_num, K, N, Phen_v,t_v)
    figure(fig_num);clf;
    for k = 1:K
        subplot(K,1,k)
        hold on
        plot(t_v,reshape(Phen_v(k,1,:,:),N,[]),'-');
        ax = gca;
        ax.ColorOrderIndex = 1;
        plot(t_v,reshape(Phen_v(k,2,:,:),N,[]),'--')
        title(sprintf('-Resistant, --Production, Antibiotic #%g',k))
    end

    figure(fig_num+1);clf;
    hold on
    plot(t_v,sum(reshape(Phen_v(k,2,:,:),N,[])),'--')
    title('total prodution')
end