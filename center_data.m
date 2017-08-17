function [out] = center_data(data,center,mod)

%% CENTRALIZANDO SINAIS PARA O FIT
if strcmp(mod,'diff');
[~,im]=max(diff(data));
end
if strcmp(mod,'max');
[~,im]=max((data));
end

for i = 1:length(data);
out(:,i) = circshift(data(:,i),center-im(i));
end
