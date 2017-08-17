function [bg] = BGinfo(data)

% figure
% plot(data(:,1:100),'.r');hold on


D=abs(unique(sort(data(:))));
f = min(D);
bg.data = data - f;
% plot(bg.data(:,1:100),'.b')
% pause
% figure
%  plot(bg.data(:,1:200),'.k'); hold on
% pause
% bg.data = ApplyResolution(bg.data, 32, 2);
% plot(bg.data(:,1:100),'.k')
% pause
% sads
[bg.mu,bg.std,bg.error.mu,bg.error.std]=normfit(bg.data(:));

bg.pts.mu = mean(bg.data');
bg.pts.std = std(bg.data');
end