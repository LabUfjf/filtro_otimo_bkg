function [data] = rmPedestalBG(data,do)

if do == 1
    md = mean2(data');
    data = data-md;
else
    data = data;
end

end