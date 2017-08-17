function [ShapeGauss] = FWHMGauss(ShapeFE)

NA = 128;
ne = 20000000;
np = 20000000;
bin = NA;
DATA.IN = randn(1,ne);
VBIN = linspace(min(DATA.IN),max(DATA.IN),bin);
[y.in,x.in]=hist(DATA.IN,VBIN);
y.in = y.in/max(y.in);

fitgauss = fit([1:NA]',y.in','gauss1');

x.hr = linspace(1,NA,np);
y.hr = fitgauss(x.hr);

x.fe = linspace(1,NA,np);
y.fe = ShapeFE(x.fe);

WG = fwhm(x.hr,y.hr);
WR = fwhm(x.fe,y.fe);

F = WG/WR;

DATA.FIX = DATA.IN/F;

[y.fix,x.fix]=hist(DATA.FIX,VBIN);
y.fix =  y.fix/max(y.fix);

ShapeGauss = fit([1:NA]',y.fix','gauss1');

% save ShapeGauss ShapeGauss
end