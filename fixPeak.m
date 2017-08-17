function [d,fn] = fixPeak(ShapeFE,doPlot,f)

% LOCALIZAR MAXIMO LOCAL
xf = (1:f:128);
yf = ShapeFE(xf);
ff= max(yf);
xm = xf(yf==ff);

% LOCALIZAR MAXIMO GLOBAL
format long
xn = linspace(1,128,10000000);
yn = ShapeFE(xn);
fn = max(yn);
xfn = xn(yn==fn);

% FATOR DE CORREÇÃO
d = xfn - xm;


if doPlot == 1
    figure
    plot(xn,yn/fn,':r'); hold on
end
end