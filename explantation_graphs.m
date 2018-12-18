num_prof = 9000;
production = 2;
resistance = 0.3;

t = growth_curves{num_prof,1};
resistant = growth_curves{num_prof,2};
producer = growth_curves{num_prof,3};

figure(2); clf; hold all;
plot(t,producer*production,'-','linewidth',2,'displayname','antibiotic concentration')
plot([0 max(t)], [resistance resistance],'--k','linewidth',1,'displayname','resistance')
t_death = interp1(producer*production,t,resistance,'linear',0);
plot(t_death,resistance,'*r','markersize',14,'linewidth',1)
%legend show
grid on
box on
set(gca,'fontsize',14);
xlabel('t')
ylabel('Antibiotic Concentration')


figure(1); clf; hold all;
plot(t,resistant,'-','linewidth',2,'displayname','resistant');
plot(t,producer,'-','linewidth',2,'displayname','producer');
legend show
plot([t_death t_death],[0 1],'--k','linewidth',1);
r_pop = interp1(t,resistant,t_death); 
p_pop = interp1(t,producer,t_death); 
plot([t_death t_death],[r_pop p_pop],'*r','markersize',14,'linewidth',1);
grid on
box on
set(gca,'fontsize',14);
xlabel('t')
ylabel('Antibiotic Concentration')

start_pop = p_pop;
K = 1 - r_pop;
g = r2(num_prof);
T = linspace(t_death, max(t),1000);
p_after = K./(1+((K-start_pop)/start_pop)*exp(-g*(T-t_death)));
plot(T,p_after,'-','linewidth',2,'displayname','producer');
%%
concentration = linspace(0,0.7,10000);
resistance = 0.3;
figure(3); clf; hold all;
plot(concentration,0.95*heaviside(resistance - concentration),'-','linewidth',2);
grid on
box on
set(gca,'fontsize',14);
xlabel('Antibiotic Concentraion')
ylabel('Growth Rate')
