function [data2] = ds(data,amostras)

data=downsample(data,2);
[~,nm]=max(mean(data'));
ne=ceil((amostras-1)/2);
nd=floor((amostras-1)/2);
data2=data([nm-ne:nm+nd],:);

end