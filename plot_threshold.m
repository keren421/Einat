x = 0:0.0001:3;
figure(); plot(x, 0.5*(1+tanh(10*(x-1.15))),'linewidth',2)
xlabel('fMT/fWT');
ylabel('Threshold');
grid on;
%%
x = 0:0.0001:3;
figure(); plot(x, x-1,'linewidth',2)
xlabel('fMT/fWT');
ylabel('Threshold');
grid on;


