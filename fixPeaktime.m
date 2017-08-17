function [d,fn] = fixPeaktime(ShapeFE,doPlot,xtime)

ftime = 8e-9;
% LOCALIZAR MAXIMO LOCAL
xf = xtime;
yf = ShapeFE(xf);
ff= max(yf);
xm = xf(yf==ff);

% LOCALIZAR MAXIMO GLOBAL
format long
xn = linspace(min(xf),max(xf),10000000);
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