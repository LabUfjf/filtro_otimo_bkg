function [ data ] = fixBGSample(data,samples)

base = 256; % 4ns entre amostras do ru�do
f = round(base/samples);
data=data(1:f:f*samples,:);

end

