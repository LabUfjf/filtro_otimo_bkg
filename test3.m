close all; clear variables; clc
%% Teste convolução - MSE
samples = 100;
ordem = 20;
evt = 5000;
% [shape.test,~]=hist(randn(1000000,1),samples);
[shape.goal,~]=hist(randn(1000000,256),samples);
shape.test = shape.goal;
sind = Coefciente_OF2(shape.goal,ordem,'max',samples);
shape.test=shape.test(sind{1},:);

% figure
% plot(shape.test)

% A = filter(shape.goal,1,shape.test);
% A = conv(shape.test,shape.goal);

% plot(shape.goal,'.k')
n = length(shape.goal)+length(shape.test);

shape.conv.goal = [shape.goal; NaN*ones(size(shape.test))];
shape.conv.test = [NaN*ones(size(shape.goal)); shape.test];
shape.valid.goal = [ones(1,length(shape.goal)) zeros(1,length(shape.test))];
shape.valid.test = [zeros(1,length(shape.goal)) ones(1,length(shape.test))];

k=0;
for i = 1:n
    %     shape.goal(1:i)
    %     shape.test(end-i:end)
    %     disp(['goal=' num2str(sum(shape.valid.goal(1:i))) ' test=' num2str(sum(shape.valid.test(end-(i-1):end)))])
    if sum(shape.valid.goal(1:i))>=ordem && length(shape.valid.goal(1:i))<=length(shape.goal) && sum(shape.valid.test(end-(i-1):end))>=ordem
        k=k+1;
        WC = shape.conv.goal(1:i,:).*shape.conv.test(end-(i-1):end,:);
        WC = reshape(WC(~isnan(WC)),length(WC(~isnan(WC)))/size(WC,2),size(WC,2));
        C(k,:) = sum(WC);
        
        WMSE = (shape.conv.goal(1:i,:)-shape.conv.test(end-(i-1):end,:)).^2;
        WMSE = reshape(WMSE(~isnan(WMSE)),length(WC(~isnan(WC)))/size(WC,2),size(WC,2));
        mse(k,:)=(1/ordem)*sum(WMSE);
        
        subplot(3,1,1);plot(shape.conv.goal(1:i),'-ok'); hold on;axis tight
        subplot(3,1,1);plot(shape.conv.test(end-(i-1):end),'-or');hold off; axis tight
        subplot(3,1,2);plot(C,'-ob'); axis tight
        subplot(3,1,3);plot(mse,'-og'); axis tight
        pause
    end
    
end

% [mi]=find(mse==min(mse));
% figure
% plot(C,'r');hold on
% plot(mse,'b')
% plot(mi,mse(mi),'ob')
% plot(mi,C(mi),'or')