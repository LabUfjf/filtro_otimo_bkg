

load('fithistnoise.mat')

x = x(y~=0);
y = y(y~=0);

xfit = x(y~=0 & x>55e-3 & x<150e-3);
yfit = y(y~=0 & x>55e-3 & x<150e-3);
[fit1g] = fitA1gauss(xfit,yfit,0);
plot(fit1g,x,y)
hold on
d = diff(x);
plot(x-0.5*d(1),y,'o')
% cftool(xfit,yfit)


dim = [.2 .5 .3 .3];
str = {'General model Gauss1:',...
    'f(x) =  a1*exp(-((x-b1)/c1)^2)',...
    'Coefficients (with 95% confidence bounds):',...
    'a1 =       211.5  (205.2, 217.8)',...
    'b1 =     0.07146  (0.07026, 0.07266)',...
    'c1 =     0.02932  (0.0276, 0.03104)'};
annotation('textbox',dim,'String',str,'FitBoxToText','on');

% a = area2d(xfit,yfit);
%
% error = sqrt(yfit)/a;
% ys = yfit+error;
% yi = yfit-error;
% % plot(xfit,ys);
% % plot(xfit,yi);
% [fit1gs] = fitA1gauss(xfit,ys,0);
% [fit1gi] = fitA1gauss(xfit,yi,0);
% plot(fit1gs,xfit,ys)
% plot(fit1gi,xfit,yi)



%   General model Gauss1:
%      fitresult(x) =  a1*exp(-((x-b1)/c1)^2)
%      Coefficients (with 95% confidence bounds):
%        a1 =       211.5  (205.2, 217.8)
%        b1 =     0.07146  (0.07026, 0.07266)
%        c1 =     0.02932  (0.0276, 0.03104)