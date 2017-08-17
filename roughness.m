function [R] = roughness(x,y)

mu=0;
sigma=1;

h = diff(x); h=h(1);
fitgauss=fit(x,y','gauss2');
figure
plot(fitgauss,x,y)
y=fitgauss(x);

dy = diff(y);
dy2 = dy.^2;

d2y = diff(dy);
d2y2 = d2y.^2;

R.dy2 = sum(dy2)*h;
R.d2y2 = sum(d2y2)*h;

ypdf = normpdf(x,mu,sigma);
a = area2d(x,ypdf);
ypdf = ypdf/a;
dypdf = diff(ypdf);
dy2pdf = dypdf.^2;
R.k = sum(dy2pdf)*h;

end