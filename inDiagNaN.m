function [i0] = inDiagNaN(Rij) 
MB = ones(size(Rij));

k = 0;
for i=-(length(MB)-1):(length(MB)-1)
    k = k+1;
    SMB(k) = sum(diag(MB,i));
    SRIJ(k) = sum(diag(isnan(Rij),i));
end
DM = SMB - SRIJ; 
i0 = find(DM == 0);
i0=i0(round((end/2)+1):end)-127;
end