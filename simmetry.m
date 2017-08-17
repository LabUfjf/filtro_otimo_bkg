function [se,sd] = simmetry(x,h,mu,d)
nd = length(d.y);
for i = 2:nd
    %     ind = find(d.da{1}==max(d.da{1}));
    ind= find(x>mu-h/2 & x<mu+h/2);
    ie = d.da{i}(1:ind-1);
    id = d.da{i}(ind+1:end);
    [ie,id] =  sincronia(ie,id,20);
    
    
    %     plot(d.da{i},'g');hold on
    %     plot(ie,'r');hold on
    %     plot(fliplr(id),'k');
    %     pause
    %     close
    
    se(i-1) = sum(ie);
    sd(i-1) = sum(id);
end