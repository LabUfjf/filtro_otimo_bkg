function [C]=MSEconv(Sfilter,Sgoal)

samples = size(Sfilter,1);
order = length(Sgoal);
n = order+samples;
shape.test = Sfilter;
clear Sfilter
shape.goal = Sgoal;
shape.est=[shape.goal; NaN*ones(samples,1)];
shape.conv.goal = repmat(shape.est,1,length(shape.test));
shape.conv.test = [NaN*ones(length(shape.goal),length(shape.test)); shape.test];
shape.valid.goal = [ones(1,size(shape.goal,1)) zeros(1,size(shape.test,1))];
shape.valid.test = [zeros(1,size(shape.goal,1)) ones(1,size(shape.test,1))];

wait = waitbar(0,'MSE Convolution');
k=0;
for i = 1:n

%       disp(['goal=' num2str(sum(shape.valid.goal(1:i))) ' test=' num2str(sum(shape.valid.test(end-(i-1):end)))])
    if sum(shape.valid.goal(1:i))>=order && sum(shape.valid.test(end-(i-1):end))>=order && length(shape.valid.goal(1:i))<=samples
        k=k+1
        WC = shape.conv.goal(1:i,:).*shape.conv.test(end-(i-1):end,:);
        WC = reshape(WC(~isnan(WC)),length(WC(~isnan(WC)))/size(WC,2),size(WC,2));
        C(k,:) = sum(WC);
        
        WMSE = (shape.conv.goal(1:i,:)-shape.conv.test(end-(i-1):end,:)).^2;
        WMSE = reshape(WMSE(~isnan(WMSE)),length(WC(~isnan(WC)))/size(WC,2),size(WC,2));
        mse(k,:)=(1/order)*sum(WMSE);
%         figure(12345)
%         subplot(3,1,1);plot(shape.conv.goal(1:i,1),'-ok'); hold on;axis tight
%         subplot(3,1,1);plot(shape.conv.test(end-(i-1):end,1),'-or');hold off; axis tight
%         subplot(3,1,2);plot(C(:,1),'-ob'); axis tight
%         subplot(3,1,3);plot(mse(:,1),'-og'); axis tight
%          pause
    end
    waitbar(i/n)
end
close(wait)
% [mi]=find(mse==min(mse));
% figure
% plot(C,'r');hold on
% plot(mse,'b')
% plot(mi,mse(mi),'ob')
% plot(mi,C(mi),'or')