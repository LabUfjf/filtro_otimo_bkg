function [shape] = Gauss(setup,x,phase)
format long
doPlot = 0;
analytic = 0;
%% Parâmetros da Gaussiana
sigma = setup.sg.var;
mu = setup.sg.mu;
%% Correção para pico ficar no centro da amostragem
d = diff(x); d = d(1)/2; x = x+d;
%% Calculando Shape da Phase 0
% load ShapeFe
% % ffun = fittype('Gauss6');
%  cfun = fit(x',ShapeFE(linspace(1,128,length(x))),'Gauss6');
% %    y = cfun(x)'; 
%      y1 = (1/sqrt(2*pi*(sigma^2)))*exp(-((x-mu).^2)/(2*(sigma^2)));
%      y2 = (1/sqrt(2*pi*(2*sigma^2)))*exp(-((x-mu*1.25).^2)/(2*(2*sigma^2)));
%      y3 = (1/sqrt(2*pi*(4*sigma^2)))*exp(-((x-mu*1.5).^2)/(2*(4*sigma^2)));
%      y = y1+y2+y3;
     y = (1/sqrt(2*pi*(sigma^2)))*exp(-((x-mu).^2)/(2*(sigma^2)));
    fc = max(y); % calculando fator de normalização (pico = 1) pra phase 0
    shape.zero = y/fc;
    if (doPlot == 1); figure; plot(x,shape.zero,':sk');hold on; end

%% Derivadas Contínuas
if analytic == 1
    shape.deriv.d1 = -((x-mu)/((sigma^3)*sqrt(2*pi))).*exp((-(x-mu).^2)/(2*(sigma^2)));
%     shape.deriv.d1 = ones(1,length(shape.deriv.d1));
    shape.deriv.d2 = -(((sigma^2)-((x-mu).^2))/((sigma^5)*sqrt(2*pi))).*exp((-(x-mu).^2)/(2*(sigma^2)));

else
    xd = linspace(min(x),max(x),100000); h = diff(xd); h = h(1);
%     yd = cfun(xd)';
%     figure
%     plot(yd)
% %     pause
    yd = (1/sqrt(2*pi*(sigma^2)))*exp(-((xd-mu).^2)/(2*(sigma^2)));
%      y1 = (1/sqrt(2*pi*(sigma^2)))*exp(-((xd-mu).^2)/(2*(sigma^2)));
%      y2 = (1/sqrt(2*pi*(2*sigma^2)))*exp(-((xd-mu*1.25).^2)/(2*(2*sigma^2)));
%      y3 = (1/sqrt(2*pi*(4*sigma^2)))*exp(-((xd-mu*1.5).^2)/(2*(4*sigma^2)));
%      yd = y1+y2+y3;
    dd1 = diff(yd)/h; dd2 = diff(dd1)/h; dd3 = diff(dd2)/h;
    shape.deriv.d1 = interp1(xd,[dd1 0],x,'linear');
    shape.deriv.d2 = interp1(xd,[dd2 0 0],x,'linear');
    shape.deriv.d3 = interp1(xd,[dd3 0 0 0],x,'linear');
end


%% Calculando Shape com Phase
d = diff(x); d = d(1);
phase = phase*d;

x = x+phase;
%  y = cfun(x)'; 
 y = (1/sqrt(2*pi*(sigma^2)))*exp(-((x-mu).^2)/(2*(sigma^2)));
%      y1 = (1/sqrt(2*pi*(sigma^2)))*exp(-((x-mu).^2)/(2*(sigma^2)));
%      y2 = (1/sqrt(2*pi*(2*sigma^2)))*exp(-((x-mu*1.25).^2)/(2*(2*sigma^2)));
%      y3 = (1/sqrt(2*pi*(4*sigma^2)))*exp(-((x-mu*1.5).^2)/(2*(4*sigma^2)));
%      y = y1+y2+y3;
shape.phase = y/fc;
if (doPlot == 1); plot(x,shape.phase,'or');
    legend('Shape[Phase = 0]' ,['Shape[Phase = ' num2str(phase/(2*d)) ']'])
end

% c = round(length(shape.zero)/2);
% [~,m.phase] = find(shape.phase==max(shape.phase));
% m.phase = c-m.phase;
% shape.phase = circshift(shape.phase,[1,m.phase]);
% figure
% plot(shape.zero,'.k'); hold on
% plot(shape.phase,'.r')


if (doPlot == 1)
figure
plot(y,':b'); hold on
plot(shape.deriv.d1,':k'); hold on
plot(shape.deriv.d2,':r')
pause
end

end