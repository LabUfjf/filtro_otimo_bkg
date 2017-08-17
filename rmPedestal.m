function [data] = rmPedestal(data,samples)
pts = round(samples*0.3);
% 
% figure
% plot(data(:,1:100),'.k'); hold on;

for i = 1:length(data)
    mu = mean(data(1:pts,i));
    data(:,i)=data(:,i)-mu;
end

% plot(data(:,1:100),'.r')
% pause
end