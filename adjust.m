function [d,xa] = adjust(x,y,h,d)
n = length(d.y);

d.da{1} = y(n:end-n);
xa = x(n:end-n);
for i = 1:n
    x = x-(h/2);
    d.da{i+1} = interp1(x,[d.y{i} zeros(1,i)],x,'linear');
    d.da{i+1} = d.da{i+1}(n:end-n);
end
