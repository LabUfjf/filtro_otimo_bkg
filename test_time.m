

F = [linspace(1,1e6,10000)];

nevt = 100000;
for i=1:length(F);
% F(i)
[t] = timeGen(F(i),nevt);
A(i)=length(t)
[t] = timeGen(F(i),nevt);
[y] = PileupADD(setup,test,t,nevt);
% plot(y); hold on
 pause
end

plot(F,A/nevt,'.k')
grid on
set(gca,'Xscale','log','GridLineStyle',':')
set(gca,'Yscale','log')

ylabel('Events ')
xlabel('Events Frequency')


