close all; clear variables; clc;
evt= 10e3;


n = 100;

mu = 0;
sigma = 100;

data = mu+sigma*randn(evt,1);
interp = 'linear';



bin = calcnbins(data);
[x,y] = histmean(data,n,'linear','auto');

[yh,xh] = hist(data,bin);

a = area2d(x,y);
ah = area2d(xh,yh);
ypdf = normpdf(x,mu,sigma);

% plot(x,y/a,'k','Linewidth',1); hold on
% plot(xh,yh/ah,':r','Linewidth',1); hold on

% 
% legend('Histmean','Hist','PDF')
[x,y] = histmean(data,n,'linear','auto');
h = diff(x); h=h(1);
r=ksr(x,y/a,h,2000);

plot(x,y/a,'*k');hold on
plot(r.x,r.f,'-r')
plot(x,ypdf,'--b','Linewidth',1); hold on
area2d(r.x,r.f)

% 
% [R] = roughness(x,y);
% nd=1;
% h = (R.k/((length(data)*(1^4)*R.d2y2)))^(1/5);
% h1 =((4/(nd+2))^(1/(nd+4)))*std(data)*n^(-1/(nd+4)); % cálculo do h("rule-of-thumb") ótimo pelo AMISE