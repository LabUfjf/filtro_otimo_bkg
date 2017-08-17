function [Nmax] = convMSE(data,shape,base)


nevt = length(data);
td = size(data,1);
nd = size(data,2);
tf = size(shape,1);
nc=(td-tf+1);
dMean = 1;
THmse = 5;

dataW =[data; NaN*ones(tf,nd)];
shapeW = [shape; NaN*ones(td,1)];

for s = 1:nc
    MF(:,s) = circshift(shapeW,s-1);
end

waitmse = waitbar(0,'MSE - Convolution Point Choice ...');
for evt = 1:nevt
    
    MSENAN=(repmat(dataW(:,evt),1,nc)-MF).^2;
    MSENAN(isnan(MSENAN))=0;
    MSE(:,evt)=(1/tf)*sum(MSENAN);
    find_center=find(MSE(:,evt)==min(MSE(:,evt)));
    [mi(evt)]=find_center(1);
    
    if evt>THmse
        Nmean = round(mean(mi(~isnan(mi))));
        %     mi(evt)
        %     pause
        vetor= abs(mi - Nmean) > dMean;        
        mi(vetor==1) = NaN;
    end
     waitbar(evt/nevt)
end

mi(isnan(mi))=Nmean;
close(waitmse)
% Nmean = round(mean(mi(~isnan(mi))));

% for evt = 1:nevt%     
%     if abs(mi(evt) - Nmean) >  dMean
%         mi(evt) = Nmean;
%     end
%     mi(isnan(mi))=Nmean;%     
%     figure
%     subplot(1,2,1); plot(data(:,evt),':ok');hold on
%     subplot(1,2,1); plot(mi(evt)-1+(1:40),shape,':or')
%     legend('Data','Shape(Order)'); axis tight%      
%     subplot(1,2,2); plot(MSE(:,evt),'ok');hold on
%     subplot(1,2,2); plot(mi(evt),min(MSE(:,evt)),'*r')
%     legend('MSE','MSE(minimum)'); axis tight
%     pause
%     close
%     
% end

if base.real == 0
    if base.uniform == 1
        Nmax = mi;
    else
        Nmax = round(mean(mi));
    end
else
    Nmax = mi;
end

Nmax = ones(1,nevt)*Nmax;
end
