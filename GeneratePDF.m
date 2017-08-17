function [x,y,h,mu] = GeneratePDF(kind,f)

npts = 10e2;
if strcmp(kind,'Normal')
    x = linspace(-10*f,10*f,npts); d = diff(x); h = d(1); d = d(1)/2; x = x+d;
    mu = 0;
    sigma = f;
    pd = makedist('Normal',mu,sigma);
    y = pdf(pd,x); y = y/max(y);
    th = y>0.001;
    y=y(th); x = x(th);
end

if strcmp(kind,'LogN')
    x = linspace(0,exp(f)*20,npts); d = diff(x); h = d(1); d = d(1)/2; x = x+d;
    mu = log(2);
    sigma = f;
    y = lognpdf(x,mu,sigma);  y = y/max(y);
    th = y>0.001;
    y=y(th); x = x(th);
end

if strcmp(kind,'Rayleigh')
    x = linspace(0,2,npts); d = diff(x); h = d(1); d = d(1)/2; x = x+d;
    b=0.5;
    mu = b;
    y = raylpdf(x,b);  y = y/max(y);
    th = y>0.001;
    y=y(th); x = x(th);
end

if strcmp(kind,'Weibull')
    x = linspace(0,0.25,npts); d = diff(x); h = d(1); d = d(1)/2; x = x+d;
    t = 3;
    mu = 0;
    lambda = 0.1;
    y = wblpdf(x,lambda,t); y = y/max(y);
    th = y>0.001;
    y=y(th); x = x(th);
end



end
