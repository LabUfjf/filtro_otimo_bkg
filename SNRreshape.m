function [RS]=SNRreshape(INFO,mod)
[~,b]=size(INFO.SR);
for i=1:6
    for j=1:b
        
        if strcmp(mod,'SNR');
            SR(:,j)=INFO.SR{j}.filter(i);
            SR2(:,j)=INFO.SR{j}.base;
        end
        
        if strcmp(mod,'EST');
            SR(:,j)=INFO.EST{j}.filter(i);
            SR2(:,j)=INFO.EST{j}.base;
            
        end
        
        if strcmp(mod,'STD');
            SR(:,j)=INFO.EST{j}.STD.filter(i);
            SR2(:,j)=INFO.EST{j}.STD.base;
            
        end
    end
    RS{i}=SR;
    
end

RS{7}=SR2;
end