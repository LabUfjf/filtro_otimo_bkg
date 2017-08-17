function [EST,EST_STD] = calcEST(ATRUTH,AEST)
% save test ATRUTH AEST
legenda = [{'NO RESTRICTION'} {'PHASE'} {'PHASE(2Diff)'} {'PEDESTAL'} {'PEDESTAL/PHASE' } {'PEDESTAL/PHASE(2Diff)'}];
for k=1:6
%         save test2 ATRUTH AEST
%     pause
    EST(k) = mean(ATRUTH-AEST(k,:));

    disp(['MEAN(T-E) = ' num2str(EST(k)) ' | TRUTH =' num2str(mean(ATRUTH)) ' | EST =' num2str(mean(AEST(k,:)))]) 
%     figure
%     hist(AEST(k,:),500)
%     legend('estimado')
%     figure
%     hist(ATRUTH,500)
%       legend('Truth validacao')
%     pause
    
%     [y,x]=hist(ATRUTH-AEST(k,:),40);
%     figure(99)
%     if k == 3 || k == 6
%         plot(x,y,'-'); hold on
%     else
%         plot(x,y,':'); hold on
%     end
%     disp([legenda{k} 'MEAN=' num2str(mean(ATRUTH-AEST(k,:)))])
%     if k == 6
%         legend('NO RESTRICTION','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)', 'Location', 'Best')
%         pause
%     end
    
%     EST_STD(k)=std(ATRUTH-AEST(k,:))/sqrt(length(ATRUTH));
        EST_STD(k)=std(ATRUTH-AEST(k,:));
    
end
   disp('--------------------------')
% disp('------------------------------------------------------------')
% close(99)
end