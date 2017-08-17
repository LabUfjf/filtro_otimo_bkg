function [ data ] = fixBGSample(data,samples)

base = 256; % 4ns entre amostras do ruído
f = round(base/samples);
data=data(1:f:f*samples,:);

end

