function [Xout,Yout] = histmean(data,n,interp,bint)

bin_corr = 1;

data=sort(data);

if strcmp(bint,'auto')
    bin = calcnbins(data,'fd');
else
    bin = bint;
end

X = linspace(min(data),max(data),bin);
d=diff(X);d=d(1);

if n == 0
    n = 1;
end

V.s = ([1:n]*d)/n;
M.Vs = repmat(V.s',1,bin);
V.X = repmat(X,n,1);
M.XVs = M.Vs+V.X;

[y.M,x.M]=hist(data,M.XVs);
Y=reshape(y.M,n,bin);

for i = 1:n
    Yint(i,:)= interp1(M.XVs(i,:),Y(i,:),x.M(:),interp,0);
end


Xout=x.M(:);

if n ~= 1
    Yout=mean(Yint);
end

if bin_corr == 1
    Yout = interp1(Xout,Yout,X,interp,0);
    Xout = X;
end

end