function [ out ] = fixSGSample(data,samples)

base = 256; % 4ns entre amostras do ruído
f = round(base/samples);

data=downsample(data,f);
[~,nm]=max(mean(data'));

d = abs((2*nm) - samples)/2;

out=data([(d+1):samples+d],:);

end
