function [d,xa] = deriv(x,y,h,ntimes)

for i = 1:ntimes
    if i == 1
        d.y{i} = diff(y)/h;
    else
        d.y{i} = diff(d.y{i-1})/h;
    end    
   
end

[d,xa] = adjust(x,y,h,d);




